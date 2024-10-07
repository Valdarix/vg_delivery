
local deliveryState = {}
local activeRoutes = {} 
local recentRoutes = {}  


local function SelectRandomDeliveryLocation(src)
    local availableLocations = {}  
    local recentStops = recentRoutes[src] or {}

    for _, location in pairs(Config.Locations) do
        if not recentStops[location] then
            table.insert(availableLocations, location)
        end
    end

    if #availableLocations == 0 then
        recentRoutes[src] = {}
        availableLocations = Config.Locations
    end

    local deliveryLocation = availableLocations[math.random(#availableLocations)]

    table.insert(recentStops, deliveryLocation)
    if #recentStops > 10 then
        table.remove(recentStops, 1)  
    end

    recentRoutes[src] = recentStops
    return deliveryLocation
end

lib.callback.register('vg_delivery:server:spawnVehicle', function(source, model, coords)
    local netId, veh = qbx.spawnVehicle({
        model = model,
        spawnSource = coords,
        warp = GetPlayerPed(source)
    })

    local plate = 'GOPO' .. math.random(10, 99)  
    SetVehicleNumberPlateText(veh, plate)
    TriggerClientEvent('vehiclekeys:client:SetOwner', source, plate)
    return netId
end)

RegisterNetEvent('vg_delivery:server:attemptStart')
AddEventHandler('vg_delivery:server:attemptStart', function()
    local src = source

 
    if deliveryState[src] then
        TriggerClientEvent('vg_delivery:client:jobFailed', src, "You are already on a delivery.") 
        return
    end
  
    if Config.Job and Config.Job ~= false then
        if exports.qbx_core:HasGroup(src, Config.Job) then
            deliveryState[src] = true

            local deliveryLocation = SelectRandomDeliveryLocation(src)
            activeRoutes[src] = deliveryLocation  

           TriggerClientEvent('vg_delivery:client:TakeVehicle', src, deliveryLocation)
        else
            TriggerClientEvent('vg_delivery:client:jobFailed', src, "You don't have the required job.")
        end
    else
        deliveryState[src] = true

        local deliveryLocation = SelectRandomDeliveryLocation(src)
        activeRoutes[src] = deliveryLocation
        
        TriggerClientEvent('vg_delivery:client:TakeVehicle', src, deliveryLocation)
    end
end)

RegisterNetEvent('vg_delivery:server:attemptClockOut')
AddEventHandler('vg_delivery:server:attemptClockOut', function()
    local src = source

      if deliveryState[src] then
        deliveryState[src] = false
        activeRoutes[src] = nil 

        TriggerClientEvent('vg_delivery:client:clockOut', src)
    else
        print('Player tried to clock out without delivering.')
    end
end)

local function isPlayerNearDeliveryPed(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for _, v in pairs(Config.Locations) do
        local dist = #(coords - vec3(v.x, v.y, v.z))
        if dist < 20 then
            return true
        end
    end
    return false
end

RegisterNetEvent('vg_delivery:server:PayPlayer', function()
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    if not isPlayerNearDeliveryPed(src) then return DropPlayer(src, 'Attempted Exploit of Delivery Job') end

    local payment = math.random(Config.MinPricePerPackage, Config.MaxPricePerPackage)
    if math.random(1, 100) < Config.TipChance then
        payment = payment + math.random(Config.MinPricePerPackage, Config.MaxPricePerPackage)
    end
    if exports.ox_inventory:CanCarryItem(src, 'cash', payment) then
        exports.ox_inventory:AddItem(src, 'cash', payment)
    end
end)