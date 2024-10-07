local isDelivering = false
local spawnedVehicle = nil
local currentDeliveryLocation = nil
local currentPed = nil
local vehicleInZone = false
local clockInPed = nil
local deliveryInProgress = false
local blip = nil
local deliveryBlip = nil
local hasPacakge = false
local visitedLocations = {}

local function CreateBlipForPed()
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end

    blip = AddBlipForCoord(Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z)
    SetBlipSprite(blip, 289)
    SetBlipColour(blip, 5)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Delivery Job")
    EndTextCommandSetBlipName(blip)
end

local function HandleBlipVisibility()
    if Config.Job and Config.Job ~= false then
        local hasJob = exports.qbx_core:HasGroup(Config.Job)
        if hasJob then
            CreateBlipForPed()
        else
            if DoesBlipExist(blip) then
                RemoveBlip(blip)
            end
        end
    else
        CreateBlipForPed()
    end
end

-- HandleBlipVisibility()

RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    HandleBlipVisibility()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    HandleBlipVisibility()
end)

local SpawnDeliveryPed, DeliverPackage

local deliveryZones = {
    lib.zones.box({
        coords = vec3(64.27, 118.87, 79.11),
        size = vec3(15.0, 15.0, 15.0),
        rotation = 0,
        onEnter = function()
            vehicleInZone = true
        end,
        onExit = function()
            vehicleInZone = false
        end,
        debug = Config.Debug
    })
}

local function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

local function UpdateTargetOptions(ped)
    local label = isDelivering and "Clock Out" or "Clock In"

    exports.ox_target:removeLocalEntity(ped, 'start_job')

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'start_job',
            icon = 'fa-solid fa-car',
            label = label,
            onSelect = function()
                if not isDelivering then
                    TriggerServerEvent('vg_delivery:server:attemptStart')
                    isDelivering = true
                else
                    TriggerServerEvent('vg_delivery:server:attemptClockOut')
                    isDelivering = false
                end

                UpdateTargetOptions(ped)
            end
        }
    })
end

local function SpawnClockInPed()
    LoadModel(Config.PedModel)
    local clockInPed = CreatePed(4, Config.PedModel, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z, Config.PedLocation.w, false, true)
    FreezeEntityPosition(clockInPed, true)
    SetEntityInvincible(clockInPed, true)
    SetBlockingOfNonTemporaryEvents(clockInPed, true)
    UpdateTargetOptions(clockInPed)

end

local function GetNextDeliveryLocation()
    local availableLocations = {}
    for _, location in ipairs(Config.Locations) do
        if not visitedLocations[location] then
            table.insert(availableLocations, location)
        end
    end
 
    if #availableLocations == 0 then
        visitedLocations = {}
        availableLocations = Config.Locations  -- Reset to all locations
    end
   
    local nextLocation = availableLocations[math.random(#availableLocations)]

    visitedLocations[nextLocation] = true
   
    currentDeliveryLocation = nextLocation
    return nextLocation
end


SpawnDeliveryPed = function(location)
    if currentPed then
        DeleteEntity(currentPed)
    end

    local pedModel = Config.Peds[math.random(1, #Config.Peds)]
    LoadModel(pedModel)

    currentPed = CreatePed(4, pedModel, location.x, location.y, location.z - 1, location.w, false, true)
    FreezeEntityPosition(currentPed, true)
    SetEntityInvincible(currentPed, true)
    SetBlockingOfNonTemporaryEvents(currentPed, true)

    exports.ox_target:addLocalEntity(currentPed, {
        {
            name = 'deliver_package',
            icon = 'fa-solid fa-box',
            label = 'Deliver Package',
            onSelect = function()
                DeliverPackage()
            end
        }
    })
end

DeliverPackage = function()

    lib.progressBar({
        duration = 5000,
        label = "Delivering Package...",
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false,
            sprint = true,
        },
        -- anim = {
        --     dict = Config.Drugs[drugType].AnimDict,
        --     clip = Config.Drugs[drugType].AnimClip,
        --     flag = Config.Drugs[drugType].AnimFlag,
        -- }
    })
    lib.notify({
        id = 'package_delivered',
        title = 'Package Delivered',
        description = 'You have successfully delivered the package.',
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#909296'
            }
        },
        icon = 'fa-solid fa-check',
        iconColor = '#00FF00'
    })

    TriggerServerEvent('vg_delivery:server:PayPlayer')

    local nextLocation = GetNextDeliveryLocation()
    if deliveryBlip then
        RemoveBlip(deliveryBlip)
    end

    if nextLocation then
        deliveryInProgress = true
        SpawnDeliveryPed(nextLocation)
        SetNewWaypoint(nextLocation.x, nextLocation.y)       
        deliveryBlip = AddBlipForCoord(nextLocation.x, nextLocation.y, nextLocation.z)
        SetBlipSprite(deliveryBlip, 1)
        SetBlipDisplay(deliveryBlip, 2)
        SetBlipScale(deliveryBlip, 1.0)
        SetBlipAsShortRange(deliveryBlip, false)
        SetBlipColour(deliveryBlip, 27)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Next Delivery')
        EndTextCommandSetBlipName(deliveryBlip)
        SetBlipRoute(deliveryBlip, true)
    else
        lib.notify({
            id = 'all_deliveries_done',
            title = 'All Deliveries Complete',
            description = 'You have completed all deliveries.',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                    color = '#909296'
                }
            },
            icon = 'fa-solid fa-check',
            iconColor = '#00FF00'
        })

        if currentPed then
            DeleteEntity(currentPed)
            currentPed = nil
        end
        isDelivering = false
        currentDeliveryLocation = nil
        deliveryInProgress = false
        SetWaypointOff()
    end
end

RegisterNetEvent('vg_delivery:client:TakeVehicle')
AddEventHandler('vg_delivery:client:TakeVehicle', function(deliveryLocation)
    local vehicleSpawnCoords = Config.VehicleSpawn

    local netId = lib.callback.await('vg_delivery:server:spawnVehicle', source, Config.VehicleModel, vehicleSpawnCoords)
    spawnedVehicle = NetToVeh(netId)

    SetVehicleFuelLevel(spawnedVehicle, 100.0)
    SetVehicleEngineOn(spawnedVehicle, true, true, false)

    isDelivering = true
    currentDeliveryLocation = deliveryLocation

    SetNewWaypoint(deliveryLocation.x, deliveryLocation.y)
    SpawnDeliveryPed(currentDeliveryLocation)
    if deliveryBlip then
        RemoveBlip(deliveryBlip)
    end
    deliveryBlip = AddBlipForCoord(deliveryLocation.x, deliveryLocation.y, deliveryLocation.z)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Delivery')
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)


    lib.notify({
        id = 'clock_in',
        title = 'Delivery Started',
        description = 'You have been assigned a delivery. Check your map for the location.',
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#909296'
            }
        },
        icon = 'fa-solid fa-truck',
        iconColor = '#00FF00'
    })

    deliveryInProgress = true
end)

RegisterNetEvent('vg_delivery:client:clockOut')
AddEventHandler('vg_delivery:client:clockOut', function()
    isDelivering = false
    currentDeliveryLocation = nil

    if spawnedVehicle then
        DeleteEntity(spawnedVehicle)
        spawnedVehicle = nil
    end

    if deliveryBlip then
        RemoveBlip(deliveryBlip)
    end
    deliveryBlip = nil
    SetWaypointOff()

     lib.notify({
        id = 'clock_out',
        title = 'Job Ended',
        description = 'You have clocked out and your vehicle has been despawned.',
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#909296'
            }
        },
        icon = 'fa-solid fa-times',
        iconColor = '#FF0000'
    })

    deliveryInProgress = false
end)

AddEventHandler('onResourceStart', function(resource)
    Wait(1000)
    if GetCurrentResourceName() == resource then
        HandleBlipVisibility()
        SpawnClockInPed()        
    end
end)


