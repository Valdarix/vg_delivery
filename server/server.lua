-- Initialize the deliveryState table to track each player's state
local deliveryState = {}
local activeRoutes = {}  -- Tracks active routes for players
local recentRoutes = {}  -- Table to track recent delivery locations for each player

-- Helper function to select a random delivery location that hasn't been used in the last 10 stops
local function SelectRandomDeliveryLocation(src)
    local availableLocations = {}  -- Filtered locations that haven't been used recently
    local recentStops = recentRoutes[src] or {}

    -- Build a list of available locations excluding the recent ones
    for _, location in pairs(Config.Locations) do
        if not recentStops[location] then
            table.insert(availableLocations, location)
        end
    end

    -- If all locations have been used, reset the recent stops table
    if #availableLocations == 0 then
        recentRoutes[src] = {}
        availableLocations = Config.Locations
    end

    -- Select a random location from the available ones
    local deliveryLocation = availableLocations[math.random(#availableLocations)]

    -- Update the recent stops table for the player
    table.insert(recentStops, deliveryLocation)
    if #recentStops > 10 then
        table.remove(recentStops, 1)  -- Keep the list limited to the last 10 stops
    end

    recentRoutes[src] = recentStops
    return deliveryLocation
end

-- Register the vehicle spawning callback
lib.callback.register('vg_delivery:server:spawnVehicle', function(source, model, coords)
    local netId, veh = qbx.spawnVehicle({
        model = model,
        spawnSource = coords,
        warp = GetPlayerPed(source)
    })

    local plate = 'GOPO' .. math.random(10, 99)  -- Generate delivery vehicle plate
    SetVehicleNumberPlateText(veh, plate)
    TriggerClientEvent('vehiclekeys:client:SetOwner', source, plate)  -- Give the player keys
    return netId
end)

-- Server-side: handle job start request
RegisterNetEvent('vg_delivery:server:attemptStart')
AddEventHandler('vg_delivery:server:attemptStart', function()
    local src = source

    -- Check if the player is already delivering
    if deliveryState[src] then
        TriggerClientEvent('vg_delivery:client:jobFailed', src, "You are already on a delivery.")  -- Notify the client
        return
    end

    -- Job validation (if required)
    if Config.Job and Config.Job ~= false then
        if exports.qbx_core:HasGroup(src, Config.Job) then
            deliveryState[src] = true

            -- Assign a random delivery location
            local deliveryLocation = SelectRandomDeliveryLocation(src)
            activeRoutes[src] = deliveryLocation  -- Store the active route for the player

            -- Trigger the client to take the vehicle and send the delivery location
            TriggerClientEvent('vg_delivery:client:TakeVehicle', src, deliveryLocation)
        else
            TriggerClientEvent('vg_delivery:client:jobFailed', src, "You don't have the required job.")
        end
    else
        -- No job restriction
        deliveryState[src] = true

        -- Assign a random delivery location
        local deliveryLocation = SelectRandomDeliveryLocation(src)
        activeRoutes[src] = deliveryLocation

        -- Trigger the client to take the vehicle and send the delivery location
        TriggerClientEvent('vg_delivery:client:TakeVehicle', src, deliveryLocation)
    end
end)

-- Server-side: handle clock out request
RegisterNetEvent('vg_delivery:server:attemptClockOut')
AddEventHandler('vg_delivery:server:attemptClockOut', function()
    local src = source

    -- Check if the player is currently delivering
    if deliveryState[src] then
        deliveryState[src] = false
        activeRoutes[src] = nil  -- Clear the active route

        -- Notify the client that they are clocking out
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