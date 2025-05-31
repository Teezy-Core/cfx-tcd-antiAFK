fx_version 'cerulean'
game 'gta5'

author 'Teezy Core Developments'
description 'Anti-AFK Captcha System'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client/captcha.lua',
    'client/ui.lua',
    'client/client.lua'
}

server_scripts {
    'server/permissions.lua',
    'server/server.lua'
}

ui_page 'web/index.html'
files {
    'web/**/*'
}

lua54 'yes'