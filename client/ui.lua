function ShowUIComponent(componentId, data)
    SendNUIMessage({
        type = "component",
        componentId = componentId,
        action = "show",
        data = data
    })
    SetNuiFocus(true, true)
    DebugPrint('Showing UI component: ' .. componentId)
end

function HideUIComponent(componentId)
    SendNUIMessage({
        type = "component",
        componentId = componentId,
        action = "hide"
    })
    SetNuiFocus(false, false)
    DebugPrint('Hiding UI component: ' .. componentId)
end

-- Command to test AFK warning (for development only)
if Config.Debug then
    RegisterCommand('testafk', function()
        ShowAfkWarning()
    end, false)
end