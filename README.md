## Overview
This is a Anti-AFK system for FiveM servers that detects inactive players and presents them with a captcha challenge to prevent automatic kicks. This resource helps maintain server performance by removing idle players while giving legitimate players a chance to prove they're still present.

## Features
- Configurable AFK detection thresholds
- Customizable captcha system
- Permission-based exemptions
- Multiple UI styles for captcha panel
- Detailed notification system
- Debug mode for testing

## Configuration
The system can be fully customized through the config.lua file.

### AFK Detection Settings
```lua
Config.AfkWarningThreshold = 10  -- Minutes before showing warning
Config.KickTime = 60               -- Seconds until kick after warning
```

### Captcha Settings
```lua
Config.CaptchaLength = 6          -- Length of captcha text
Config.CaseSensitive = true       -- Whether captcha verification is case sensitive
```

### Exemption System
Players with specific permissions can be exempted from the AFK checks:
```lua
Config.ExemptPermissions = {
    "group.admin",             -- Example permission
    "group.mod",
    "command.bypassafk"        -- Custom ACE permission
}
```

### UI Customization
```lua
Config.Title = "ANTI-AFK SYSTEM"
Config.Description = "You are about to be kicked for inactivity..."
Config.ButtonText = "Confirm"
Config.ServerName = "Teezy Core Developments"
Config.AllowCancel = false
Config.PanelStyle = "modern"      -- Available: default, modern, minimal, futuristic, retro
Config.CaptchaStyle = "default"   -- Available: default, neon, minimalist, gradient, 3d, etc.
```

### Color Customization
```lua
Config.ColorPalette = {
    primary = "#F13D3D",          -- Red
    secondary = "#7B2222",        -- Darker red
    background = "#0A0A0A",       -- Near Black
    text = "#FFFFFF"              -- White
}
```

## How It Works

### AFK Detection
The system monitors player activity through:
- Movement detection
- Key presses
- Mouse movements

If a player is inactive for the specified threshold time, the AFK warning is displayed.

### Captcha Challenge
When triggered, players are presented with a captcha they must enter correctly to avoid being kicked. The captcha:
- Is randomly generated
- Can be case-sensitive (configurable)
- Has customizable styling

### Exemption System
The permissions.lua file handles checking if a player has permission to bypass AFK checks based on ACE permissions defined in the config.

## Developer Commands
In debug mode, the following commands are available:
- `/testafk` - Triggers the AFK warning UI for testing

## Installation

1. Place the `cfx-tcd-antiAFK` folder in your server's resources directory
2. Add `ensure cfx-tcd-antiAFK` to your server.cfg
3. Configure settings in config.lua as needed
4. Restart your server

## Credits
Developed by Teezy Core Developments