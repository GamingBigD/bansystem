-- Warn Command
RegisterCommand('warn', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local targetId = tonumber(args[1])
    local reason = table.concat(args, " ", 2)
    
    if not targetId or not reason or reason == "" then
        Config.notify(source, 'error', _L('notify_title'), "Usage: /warn [id] [reason]")
        return
    end
    
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        Config.notify(source, 'error', _L('notify_title'), _L('notify_ban_targetNotFound', targetId))
        return
    end
    
    WarnPlayer(targetId, source, reason)
end, false)

-- Warn Template Command
RegisterCommand('warntemplate', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local targetId = tonumber(args[1])
    local templateId = tonumber(args[2])
    
    if not targetId or not templateId then
        Config.notify(source, 'error', _L('notify_title'), "Usage: /warntemplate [id] [templateId]")
        return
    end
    
    local template = nil
    for _, temp in ipairs(SharedConfig.WarnTemplates) do
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
        Config.notify(source, 'error', _L('notify_title'), _L('notify_ban_targetNotFound', targetId))
        return
    end
    
    WarnPlayer(targetId, source, template.reason)
end, false)

-- Warn Player Function
function WarnPlayer(targetId, adminSource, reason)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then return end
    
    local identifiers = GetPlayerIdentifiers(targetId)
    local adminName = GetPlayerName(adminSource)
    local targetName = GetPlayerName(targetId)
    
    MySQL.insert('INSERT INTO warns (license, steam, playername, reason, warnedby, warndate) VALUES (?, ?, ?, ?, ?, ?)', {
        identifiers.license,
        identifiers.steam,
        targetName,
        reason,
        adminName,
        os.time()
    }, function(warnId)
        Config.notify(adminSource, 'success', _L('notify_title'), _L('notify_warn_success'))
        TriggerClientEvent('ov_bansystem:warnReceived', targetId, reason)
        
        -- Check total warns
        MySQL.scalar('SELECT COUNT(*) FROM warns WHERE license = ?', {identifiers.license}, function(warnCount)
            if warnCount >= SharedConfig.MaxWarns then
                -- Auto ban player
                BanPlayer(targetId, 0, "Zu viele Verwarnungen", SharedConfig.AutoBanDuration)
            end
        end)
        
        -- Discord Log
        local logMessage = string.format(_L('warn_log'), adminName, targetName, reason)
        SendDiscordLog(Config.Webhooks.warn, "Player Warned", logMessage, 16776960)
    end)
end

-- Get player warns
RegisterNetEvent('ov_bansystem:getPlayerWarns')
AddEventHandler('ov_bansystem:getPlayerWarns', function(targetId)
    local source = source
    if not IsPlayerAdmin(source) then return end
    
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then return end
    
    local identifiers = GetPlayerIdentifiers(targetId)
    
    MySQL.query('SELECT * FROM warns WHERE license = ? ORDER BY warndate DESC', {
        identifiers.license
    }, function(warns)
        TriggerClientEvent('ov_bansystem:receiveWarns', source, warns)
    end)
end)
