fx_version "cerulean"
game "gta5"
lua54 "yes"

version "1.0.0"
author "Custom Bansystem BigD"
description "Advanced Ban, Jail and Warn system for FiveM"

shared_scripts {
    "shared/sh_config.lua",
    "config.lua",
    "locales/*.lua",
    "@es_extended/imports.lua",
}

client_scripts {
    "client/*.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua",
    "handler.lua"
}

dependencies {
    "oxmysql",
    "es_extended"
}
