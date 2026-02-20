fx_version 'cerulean'
game 'gta5'

lua54 'yes'

name 't2_repairstation'
author 'Zix'
description 'Qbox Vehicle Repair Stations'
version '1.0.0'

shared_script '@ox_lib/init.lua'
shared_script 'config.lua'

client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'ox_lib',
    'ox_target',
    'qbx_core'
}