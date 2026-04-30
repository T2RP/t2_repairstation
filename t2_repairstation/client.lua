-- client.lua

-- Blips
CreateThread(function()
    for _, loc in ipairs(Config.RepairLocations) do
        local blip = AddBlipForCoord(loc.coords.x, loc.coords.y, loc.coords.z)
        SetBlipSprite(blip, loc.blip.sprite or 446)
        SetBlipColour(blip, loc.blip.colour or 5)
        SetBlipScale(blip, loc.blip.scale or 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(loc.name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- E-key interaction at repair stations
CreateThread(function()
    local showingPrompt = false

    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local veh = cache.vehicle
        local closestDist = math.huge

        for _, loc in ipairs(Config.RepairLocations) do
            local dist = #(pedCoords - loc.coords)
            if dist < closestDist then
                closestDist = dist
            end
        end

        local inRange = closestDist <= (Config.InteractDistance or 4.5)
        local canInteract = inRange and veh and veh ~= 0

        if canInteract then
            sleep = 0
            if not showingPrompt then
                lib.showTextUI(('[E] Full Repair  $%s'):format(Config.RepairPrice), {
                    position = 'left-center',
                    icon = 'fa-solid fa-screwdriver-wrench'
                })
                showingPrompt = true
            end

            if IsControlJustReleased(0, 38) then -- E
                lib.hideTextUI()
                showingPrompt = false
                local success, reason = lib.callback.await('qbx_repairstation:payAndRepair', false)
                if success then
                    DoRepair()
                else
                    lib.notify({
                        title       = 'Repair Station',
                        description = reason or 'Could not process payment',
                        type        = 'error',
                        duration    = 4500
                    })
                end
                Wait(200)
            end
        else
            if showingPrompt then
                lib.hideTextUI()
                showingPrompt = false
            end
        end

        Wait(sleep)
    end
end)

-- Full repair function
function DoRepair()
    local veh = cache.vehicle
    if not veh or veh == 0 then
        lib.notify({ description = 'No vehicle found', type = 'error' })
        return
    end

    SetVehicleDoorOpen(veh, 4, false, false) -- open hood

    if lib.progressBar({
        duration     = Config.RepairDuration,
        label        = 'Repairing vehicle...',
        useWhileDead = false,
        canCancel    = true,
        disable = { move = true, car = true, combat = true },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped',
            flag = 49
        },
        prop = {
            model = `prop_toolbox_03`,
            pos   = vec3(0.05, 0.0, -0.25),
            rot   = vec3(0.0, 0.0, -45.0)
        }
    }) then
        SetVehicleEngineHealth(veh, 1000.0)
        SetVehiclePetrolTankHealth(veh, 1000.0)
        SetVehicleBodyHealth(veh, 1000.0)
        SetVehicleDeformationFixed(veh)
        for wheel = 0, 7 do
            SetVehicleTyreFixed(veh, wheel)
        end
        SetVehicleFixed(veh)
        SetVehicleUndriveable(veh, false)
        SetVehicleEngineOn(veh, true, false)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleDoorShut(veh, 4, false) -- close hood

        lib.notify({
            title       = 'Repair Station',
            description = 'Vehicle repaired successfully!',
            type        = 'success',
            duration    = 5000
        })
    else
        SetVehicleDoorShut(veh, 4, false) -- close hood
        lib.notify({
            title       = 'Repair Station',
            description = 'Repair cancelled.',
            type        = 'inform',
            duration    = 4000
        })
    end
end
