ESX = exports["es_extended"]:getSharedObject()

local isJailed = false
local jailTime = 0
local jailReason = ""

-- Helper function to get locale
function _L(str, ...)
    if _LOCALE[SharedConfig.Locale] and _LOCALE[SharedConfig.Locale][str] then
        return string.format(_LOCALE[SharedConfig.Locale][str], ...)
    end
    return str
end

-- Jail Player
RegisterNetEvent('ov_bansystem:jailPlayer')
AddEventHandler('ov_bansystem:jailPlayer', function(duration, reason)
    isJailed = true
    jailTime = duration * 60 -- Convert to seconds
    jailReason = reason
    
    -- Teleport to jail
    ESX.Game.Teleport(PlayerPedId(), SharedConfig.JailLocation, function()
        SetEntityHeading(PlayerPedId(), SharedConfig.JailHeading)
    end)
    
    ESX.ShowNotification(_L('jail_player_getJailed', reason, duration))
    
    -- Start jail timer
    CreateThread(function()
        while isJailed and jailTime > 0 do
            Wait(1000)
            jailTime = jailTime - 1
            
            -- Show remaining time every minute
            if jailTime % 60 == 0 then
                local minutes = math.ceil(jailTime / 60)
                ESX.ShowNotification(_L('jail_rest_time', minutes))
            end
        end
        
        if isJailed then
            isJailed = false
            ESX.ShowNotification(_L('jail_out'))
        end
    end)
    
    -- Prevent player from leaving jail area
    CreateThread(function()
        while isJailed do
            Wait(1000)
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - SharedConfig.JailLocation)
            
            if distance > 100.0 then
                ESX.ShowNotification(_L('jail_dont_leave'))
                ESX.Game.Teleport(playerPed, SharedConfig.JailLocation, function()
                    SetEntityHeading(playerPed, SharedConfig.JailHeading)
                end)
            end
        end
    end)
end)

-- Unjail Player
RegisterNetEvent('ov_bansystem:unjailPlayer')
AddEventHandler('ov_bansystem:unjailPlayer', function()
    isJailed = false
    jailTime = 0
    jailReason = ""
    ESX.ShowNotification(_L('command_unjail_unjailed_unjailedPlayer'))
end)

-- Warn Received
RegisterNetEvent('ov_bansystem:warnReceived')
AddEventHandler('ov_bansystem:warnReceived', function(reason)
    ESX.ShowNotification(_L('notify_warn_recieved', reason))
end)

-- Check if player is jailed
function IsPlayerJailed()
    return isJailed
end

-- Get remaining jail time
function GetJailTime()
    return math.ceil(jailTime / 60) -- Return in minutes
end

-- Disable certain actions while jailed
CreateThread(function()
    while true do
        Wait(0)
        
        if isJailed then
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 47, true) -- Weapon
            DisableControlAction(0, 58, true) -- Weapon
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 264, true) -- Melee Attack 2
            DisableControlAction(0, 257, true) -- Melee Attack Light
            DisableControlAction(0, 140, true) -- Melee Attack Light
            DisableControlAction(0, 141, true) -- Melee Attack Heavy
            DisableControlAction(0, 142, true) -- Melee Attack Alternate
            DisableControlAction(0, 143, true) -- Melee Block
            DisableControlAction(0, 75, true) -- Exit Vehicle
            DisableControlAction(27, 75, true) -- Exit Vehicle
        else
            Wait(500)
        end
    end
end)
