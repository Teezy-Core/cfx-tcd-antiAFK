RegisterNetEvent('cfx-tcd-antiAFK:kickPlayer')
AddEventHandler('cfx-tcd-antiAFK:kickPlayer', function()
    local src = source
    local playerName = GetPlayerName(src)

    if Config.Debug then
        print('[Anti-AFK] Kicking player ' .. playerName .. ' for being AFK')
    end

    DropPlayer(src, Config.KickMessage)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('^2[Anti-AFK]^7 System started successfully!')
    end
end)
