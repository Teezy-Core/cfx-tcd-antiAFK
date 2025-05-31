local afkTimer = 0
AfkWarningShown = false
local afkCheckInterval = 60000
local lastInputTime = GetGameTimer()
local isExempt = false

local function checkExemptionStatus()
    TriggerServerEvent('cfx-tcd-antiAFK:checkExemption')
end

local function updateLastInputTime()
    lastInputTime = GetGameTimer()

    if AfkWarningShown then
        HideAfkWarning()
    end
end

function DebugPrint(...)
    if Config.Debug then
        print('[Anti-AFK]', ...)
    end
end

function ResetAfkState()
    afkTimer = 0
    AfkWarningShown = false
    updateLastInputTime()
    DebugPrint('AFK state reset')
end

Citizen.CreateThread(function()
    checkExemptionStatus()
    
    local lastX, lastY, lastZ = table.unpack(GetEntityCoords(PlayerPedId()))
    
    while true do
        if IsControlJustPressed(0, 0) or    -- V (Vehicle enter/exit)
            IsControlJustPressed(0, 1) or   -- F (Enter)
            IsControlJustPressed(0, 2) or   -- E (Context action)
            IsControlJustPressed(0, 3) or   -- Left mouse
            IsControlJustPressed(0, 4) or   -- Right mouse
            IsControlJustPressed(0, 5) or   -- Mouse wheel up
            IsControlJustPressed(0, 6) or   -- Mouse wheel down
            IsControlJustPressed(0, 30) or  -- Move up (W)
            IsControlJustPressed(0, 31) or  -- Move down (S)
            IsControlJustPressed(0, 32) or  -- Move left (A)
            IsControlJustPressed(0, 33) then -- Move right (D)
            updateLastInputTime()
        end
        
        -- Check for continuous control input (holding buttons)
        if IsControlPressed(0, 30) or   -- Move up (W)
           IsControlPressed(0, 31) or   -- Move down (S)
           IsControlPressed(0, 32) or   -- Move left (A)
           IsControlPressed(0, 33) or   -- Move right (D)
           IsControlPressed(0, 34) or   -- Move up only (Analog)
           IsControlPressed(0, 35) or   -- Move down only (Analog)
           IsControlPressed(0, 36) or   -- Move left only (Analog)
           IsControlPressed(0, 37) then -- Move right only (Analog)
            updateLastInputTime()
        end
        
        local currentX, currentY, currentZ = table.unpack(GetEntityCoords(PlayerPedId()))
        local distance = #(vector3(currentX, currentY, currentZ) - vector3(lastX, lastY, lastZ))
        
        if distance > 0.5 then
            updateLastInputTime()
            lastX, lastY, lastZ = currentX, currentY, currentZ
        end

        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if not isExempt then
            local currentTime = GetGameTimer()
            local inactiveTime = currentTime - lastInputTime

            if not AfkWarningShown and inactiveTime >= (Config.AfkWarningThreshold * 60000) then
                ShowAfkWarning()
                afkTimer = currentTime
                DebugPrint('Player inactive for ' .. Config.AfkWarningThreshold .. ' minutes, showing warning')
            end

            if AfkWarningShown then
                local timeElapsed = currentTime - afkTimer
                local timeRemaining = (Config.KickTime * 1000) - timeElapsed
                
                if timeRemaining <= 0 then
                    DebugPrint('AFK timer expired, kicking player')
                    KickPlayerForAfk()
                    return
                end

                local nextWaitTime = math.min(timeRemaining, afkCheckInterval)
                if nextWaitTime > 0 then
                    Citizen.Wait(nextWaitTime)
                    goto continue
                end
            end
        else
            DebugPrint('Player is exempt from AFK checks')
            Citizen.Wait(60000)
        end

        Citizen.Wait(afkCheckInterval)
        ::continue::
    end
end)

RegisterNetEvent('cfx-tcd-antiAFK:exemptionStatus')
AddEventHandler('cfx-tcd-antiAFK:exemptionStatus', function(status)
    isExempt = status
    DebugPrint('Exemption status updated: ' .. tostring(status))
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        HideAfkWarning()
        DebugPrint('Resource stopped, hiding AFK warning')
    end
end)
