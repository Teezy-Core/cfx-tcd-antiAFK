local function isPlayerExempt(source)
    for _, permission in ipairs(Config.ExemptPermissions) do
        if IsPlayerAceAllowed(source, permission) then
            return true
        end
    end
    return false
end

RegisterNetEvent('cfx-tcd-antiAFK:checkExemption')
AddEventHandler('cfx-tcd-antiAFK:checkExemption', function()
    local src = source
    local exempt = isPlayerExempt(src)
    TriggerClientEvent('cfx-tcd-antiAFK:exemptionStatus', src, exempt)

    if Config.Debug then
        print(('[Anti-AFK] Player %s exemption status: %s'):format(GetPlayerName(src), tostring(exempt)))
    end
end)