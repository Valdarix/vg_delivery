fx_version 'cerulean'
game 'gta5'

author 'ValdarixGames'
description 'Delivery job for FiveM'
version '0.0.1a'

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/*.lua',
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
	'@qbx_core/shared/locale.lua',
    'config/*.lua',
}

lua54 'yes'
