function ShowAfkWarning()
    if AfkWarningShown then return end

    AfkWarningShown = true
    DebugPrint('Showing AFK warning')

    local captchaText = GenerateRandomCaptcha(Config.CaptchaLength)

    local captchaData = {
        title = Config.Title,
        description = Config.Description,
        warning_time = Config.KickTime,
        kick_time = Config.KickTime,
        color_palette = Config.ColorPalette,
        captcha = {
            text = captchaText,
            case_sensitive = Config.CaseSensitive,
            length = #captchaText,
        },
        button_text = Config.ButtonText,
        server_name = Config.ServerName,
        allow_cancel = Config.AllowCancel,
        notification = {
            success = Config.Notification.Success,
            error = Config.Notification.Error,
            cancel = Config.Notification.Cancel
        },
        panel_style = Config.PanelStyle,
        captcha_style = Config.CaptchaStyle
    }

    TriggerScreenblurFadeIn(1000)
    ShowUIComponent('afk-warning', captchaData)
end

function HideAfkWarning()
    if not AfkWarningShown then return end

    AfkWarningShown = false
    HideUIComponent('afk-warning')
    ResetAfkState()
    TriggerScreenblurFadeOut(1000)
    DebugPrint('Hiding AFK warning')
end

function KickPlayerForAfk()
    TriggerServerEvent('cfx-tcd-antiAFK:kickPlayer')
end

function GenerateRandomCaptcha(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local captcha = ""

    for i = 1, length do
        local rand = math.random(1, #chars)
        captcha = captcha .. string.sub(chars, rand, rand)
    end

    return captcha
end

RegisterNUICallback('captchaSuccess', function(data, cb)
    DebugPrint('Captcha successful')
    Citizen.SetTimeout(1000, function()
        HideAfkWarning()
    end)
    cb({ status = 'ok' })
end)

RegisterNUICallback('captchaCancel', function(data, cb)
    DebugPrint('Captcha cancelled, player will be kicked')
    Citizen.SetTimeout(2000, function()
        KickPlayerForAfk()
    end)

    cb({ status = 'ok' })
end)