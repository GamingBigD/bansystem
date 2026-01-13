local JailedPlayers = {}

-- Jail Command
RegisterCommand('jail', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local targetId = tonumber(args[1])
    local duration = tonumber(args[2]) or 10
    local reason = table.concat(args, " ", 3)
    
    if not targetId or not reason or reason == "" then
        Config.notify(source, 'error', _L('notify_title'), "Usage: /jail [id] [duration] [reason]")
        return
    end
    
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        Config.notify(source, 'error', _L('notify_title'), _L('jail_player_offline'))
        return
    end
    
    JailPlayer(targetId, source, reason, duration)
end, false)

-- Jail Template Command
RegisterCommand('jailtemplate', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local targetId = tonumber(args[1])
    local templateId = tonumber(args[2])
    
    if not targetId or not templateId then
        Config.notify(source, 'error', _L('notify_title'), "Usage: /jailtemplate [id] [templateId]")
        return
    end
    
    local template = nil
    for _, temp in ipairs(SharedConfig.JailTemplates) do
        if temp.id == templateId then
            template = temp
            break
        end
    end
    
    if not template then
        Config.notify(source, 'error', _L('notify_title'), "Template not found")
        return
    end
    
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        Config.notify(source, 'error', _L('notify_title'), _L('jail_player_offline'))
        return
    end
    
    JailPlayer(targetId, source, template.reason, template.duration)
end, false)

-- Unjail Command
RegisterCommand('unjail', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local targetId = tonumber(args[1])
    local reason = table.concat(args, " ", 2)
    
    if not targetId then
        Config.notify(source, 'error', _L('notify_title'), "Usage: /unjail [id] [reason]")
        return
    end
    
    if not reason or reason == "" then
        Config.notify(source, 'error', _L('notify_title'), _L('command_unjail_need_reason'))
        return
    end
    
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        Config.notify(source, 'error', _L('notify_title'), _L('command_unjail_not_found'))
        return
    end
    
    UnjailPlayer(targetId, source, reason)
end, false)

-- Jail Player Function
function JailPlayer(targetId, adminSource, reason, duration)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then return end
    
    if JailedPlayers[targetId] then
        Config.notify(adminSource, 'error', _L('notify_title'), _L('jail_player_already', GetPlayerName(targetId)))
        return
    end
    
    local identifiers = GetPlayerIdentifiers(targetId)
    local adminName = GetPlayerName(adminSource)
    local targetName = GetPlayerName(targetId)
    
    local unjailTime = os.time() + (duration * 60)
    
    MySQL.insert('INSERT INTO jails (license, steam, playername, reason, jailedby, duration, unjailtime, active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
        identifiers.license,
        identifiers.steam,
        targetName,
        reason,
        adminName,
        duration,
        unjailTime,
        1
    }, function(jailId)
        JailedPlayers[targetId] = {
            id = jailId,
            unjailTime = unjailTime,
            reason = reason,
            duration = duration
        }
        
        TriggerClientEvent('ov_bansystem:jailPlayer', targetId, duration, reason)
        Config.notify(adminSource, 'success', _L('notify_title'), _L('jail_player_finish', targetName, jailId))
        
        -- Discord Log
        local logMessage = string.format(_L('jail_log'), targetName, reason, duration, jailId)
        SendDiscordLog(Config.Webhooks.jail, "Player Jailed", logMessage, 16753920)
        
        -- Start timer
        CreateThread(function()
            while JailedPlayers[targetId] and os.time() < JailedPlayers[targetId].unjailTime do
                Wait(1000)
            end
            
            if JailedPlayers[targetId] then
                UnjailPlayer(targetId, 0, "Zeit abgelaufen")
            end
        end)
    end)
end

-- Unjail Player Function
function UnjailPlayer(targetId, adminSource, reason)
    if not JailedPlayers[targetId] then
        if adminSource ~= 0 then
            Config.notify(adminSource, 'error', _L('notify_title'), _L('jail_player_not_jailed', GetPlayerName(targetId)))
        end
        return
    end
    
    local jailId = JailedPlayers[targetId].id
    local adminName = adminSource ~= 0 and GetPlayerName(adminSource) or "System"
    local targetName = GetPlayerName(targetId)
    
    MySQL.update('UPDATE jails SET active = 0 WHERE id = ?', {jailId}, function()
        JailedPlayers[targetId] = nil
        TriggerClientEvent('ov_bansystem:unjailPlayer', targetId)
        
        if adminSource ~= 0 then
            Config.notify(adminSource, 'success', _L('notify_title'), _L('command_unjail_unjailed', targetName))
        end
        
        -- Discord Log
        local logMessage = string.format(_L('unjail_log'), targetName, reason)
        SendDiscordLog(Config.Webhooks.unjail, "Player Unjailed", logMessage, 65280)
    end)
end

-- Check jail on player connecting
AddEventHandler('playerJoining', function()
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    
    MySQL.single('SELECT * FROM jails WHERE (license = ? OR steam = ?) AND active = 1', {
        identifiers.license,
        identifiers.steam
    }, function(jail)
        if jail then
            if os.time() >= jail.unjailtime then
                MySQL.update('UPDATE jails SET active = 0 WHERE id = ?', {jail.id})
            else
                local remainingTime = math.ceil((jail.unjailtime - os.time()) / 60)
                JailedPlayers[source] = {
                    id = jail.id,
                    unjailTime = jail.unjailtime,
                    reason = jail.reason,
                    duration = remainingTime
                }
                TriggerClientEvent('ov_bansystem:jailPlayer', source, remainingTime, jail.reason)
                
                -- Start timer
                CreateThread(function()
                    while JailedPlayers[source] and os.time() < JailedPlayers[source].unjailTime do
                        Wait(1000)
                    end
                    
                    if JailedPlayers[source] then
                        UnjailPlayer(source, 0, "Zeit abgelaufen")
                    end
                end)
            end
        end
    end)
end)

-- Cleanup on player drop
AddEventHandler('playerDropped', function()
    local source = source
    if JailedPlayers[source] then
        JailedPlayers[source] = nil
    end
end)
