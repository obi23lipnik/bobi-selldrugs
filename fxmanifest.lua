fx_version 'cerulean'
game 'gta5'

author 'bobimane'
version '0.2'
name 'bobi-selldrugs'
description 'Simple drugs selling script'
lua54 'no'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    'data/*.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

dependencies {
	'ox_lib',
    -- qb-inventory or ox_inventory
    -- qb-target or ox_target
    -- ox_inventory or qbcore
	'/server:6116',
}