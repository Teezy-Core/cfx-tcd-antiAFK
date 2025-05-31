Config = {}

--[[
▀█▀ █▀▀ █▀▀ ▀█ █▄█   █▀▀ █▀█ █▀█ █▀▀   █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▄▀█ █▀▀ █▄░█ ▀█▀
░█░ ██▄ ██▄ █▄ ░█░   █▄▄ █▄█ █▀▄ ██▄   █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ █░▀░█ ██▄ █░▀█ ░█░
]]

Config.Debug = false

Config.AfkWarningThreshold = 10 -- Minutes before showing warning
Config.KickTime = 60 -- Seconds until kick after warning

-- Captcha Settings
Config.CaptchaLength = 6
Config.CaseSensitive = true

-- Exemption Settings
Config.ExemptPermissions = {
    -- "group.admin", -- Example permission
    -- "group.mod",
    -- "command.bypassafk" -- Custom ACE permission
}

-- UI Settings
Config.Title = "ANTI-AFK SYSTEM"
Config.Description = "You are about to be kicked for inactivity. Input the captcha below to prevent this."
Config.ButtonText = "Confirm"
Config.ServerName = "Teezy Core Developments"
Config.AllowCancel = false
Config.PanelStyle = "futuristic" -- Available: default, modern, minimal, futuristic, retro
Config.CaptchaStyle = "default" -- Available: default, neon, minimalist, gradient, 3d, glitch, cyber, retro-arcade, holographic, paper, matrix

-- Message shown to player when kicked
Config.KickMessage = "You were kicked for being AFK too long"

Config.Notification = {
    Success = "Captcha verified successfully!",
    Error = "Captcha verification failed. Please try again.",
    Cancel = "Captcha verification cancelled."
}

-- UI Color Palette
Config.ColorPalette = {
    primary = "#F13D3D", -- Red
    secondary = "#7B2222", -- Darker red
    background = "#0A0A0A", -- Near Black
    text = "#FFFFFF" -- White
}