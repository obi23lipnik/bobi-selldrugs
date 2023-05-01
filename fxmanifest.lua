fx_version 'cerulean'
game 'gta5'

author 'bobimane'
version '0.1'
name 'bobi-selldrugs'
description 'Simple drugs selling script'
lua54 'no'

shared_scripts {
    '@ox_lib/init.lua',
    'data/*.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'config.lua',
    'server/*.lua',
}

dependencies {
    -- qb-inventory or ox_inventory
    'qb-target',
    'dpemotes',
	'ox_lib',
    'ox_inventory',
	'/server:6116',
}