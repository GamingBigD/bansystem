-- Ban Command
RegisterCommand('ban', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local targetId = tonumber(args[1])
    local duration = tonumber(args[2]) or -1
    local reason = table.concat(args, " ", 3)
    
    if not targetId or not reason or reason == "" then
        Config.notify(source, 'error', _L('notify_title'), _L('notify_ban_invalidArgs'))
        return
    end
    
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        Config.notify(source, 'error', _L('notify_title'), _L('notify_ban_targetNotFound', targetId))
        return
    end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    if not Config.canPlayerBanTargetPlayer(xPlayer, xTarget) then
        Config.notify(source, 'error', _L('notify_title'), _L('not_bannable'))
        return
    end
    
    BanPlayer(targetId, source, reason, duration)
end, false)

-- Ban Template Command
RegisterCommand('bantemplate', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local targetId = tonumber(args[1])
    local templateId = tonumber(args[2])
    
    if not targetId or not templateId then
        Config.notify(source, 'error', _L('notify_title'), "Usage: /bantemplate [id] [templateId]")
        return
    end
    
    local template = nil
    for _, temp in ipairs(SharedConfig.BanTemplates) do
        if temp.id == templateId then
            template = temp
            break
        end
    end
    
    if not template then
        Config.notify(source, 'error', _L('notify_title'), _L('notify_banTemplate_failure', templateId))
        return
    end
    
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then
        Config.notify(source, 'error', _L('notify_title'), _L('notify_ban_targetNotFound', targetId))
        return
    end
    
    BanPlayer(targetId, source, template.reason, template.duration)
end, false)

-- Unban Command
RegisterCommand('unban', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local value = args[1]
    if not value then
        Config.notify(source, 'error', _L('notify_title'), "Usage: /unban [banId/license]")
        return
    end
    
    UnbanPlayer(source, value)
end, false)

-- Delete Ban Command
RegisterCommand('delban', function(source, args, rawCommand)
    if not IsPlayerAdmin(source) then
        Config.notify(source, 'error', _L('notify_title'), _L('no_permission'))
        return
    end
    
    local banId = tonumber(args[1])
    if not banId then
        Config.notify(source, 'error', _L('notify_title'), "Usage: /delban [banId]")
        return
    end
    
    DeleteBan(source, banId)
end, false)

-- Ban Player Function
function BanPlayer(targetId, adminSource, reason, duration)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xTarget then return end
    
    local identifiers = GetPlayerIdentifiers(targetId)
    local adminName = GetPlayerName(adminSource)
    local targetName = GetPlayerName(targetId)
    
    local unbanTime = nil
    if duration ~= -1 then
        unbanTime = os.time() + (duration * 60)
    end
    
    MySQL.insert('INSERT INTO bans (license, steam, discord, ip, playername, reason, bannedby, duration, unbantime, active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
        identifiers.license,
        identifiers.steam,
        identifiers.discord,
        identifiers.ip,
        targetName,
        reason,
        adminName,
        duration,
        unbanTime,
        1
    }, function(banId)
        Config.notify(adminSource, 'success', _L('notify_title'), _L('notify_ban_success', targetId))
        
        -- Kick player
        DropPlayer(targetId, string.format(_L('banscreen_banText_permanent'), banId, reason))
        
        -- Discord Log
        local logMessage = string.format(_L('ban_log'), adminName, targetName, reason, banId, duration == -1 and "Permanent" or duration .. " minutes")
        SendDiscordLog(Config.Webhooks.ban, "Player Banned", logMessage, 16711680)
    end)
end

-- Unban Player Function
function UnbanPlayer(adminSource, value)
    local adminName = GetPlayerName(adminSource)
    
    MySQL.scalar('SELECT id FROM bans WHERE (id = ? OR license = ?) AND active = 1', {
        value, value
    }, function(banId)
        if banId then
            MySQL.update('UPDATE bans SET active = 0 WHERE id = ?', {banId}, function(affectedRows)
                if affectedRows > 0 then
                    Config.notify(adminSource, 'success', _L('notify_title'), _L('notify_unban_success'))
                    
                    -- Discord Log
                    local logMessage = string.format(_L('unban_log'), adminName, banId)
                    SendDiscordLog(Config.Webhooks.unban, "Player Unbanned", logMessage, 65280)
                else
                    Config.notify(adminSource, 'error', _L('notify_title'), _L('notify_unban_failure'))
                end
            end)
        else
            Config.notify(adminSource, 'error', _L('notify_title'), _L('notify_unban_failure'))
        end
    end)
end

-- Delete Ban Function
function DeleteBan(adminSource, banId)
    MySQL.update('DELETE FROM bans WHERE id = ?', {banId}, function(affectedRows)
        if affectedRows > 0 then
            Config.notify(adminSource, 'success', _L('notify_title'), _L('notify_delban_success', banId))
            
            -- Discord Log
            local logMessage = string.format(_L('delete_ban_log'), banId)
            SendDiscordLog(Config.Webhooks.ban, "Ban Deleted", logMessage, 16776960)
        else
            Config.notify(adminSource, 'error', _L('notify_title'), _L('notify_delban_failure', banId))
        end
    end)
end

-- Check ban on player connecting
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local source = source
    deferrals.defer()
    
    Wait(0)
    deferrals.update(_L('deferrals_update'))
    
    local identifiers = GetPlayerIdentifiers(source)
    
    if not identifiers.license or identifiers.license == "" then
        deferrals.done(_L('deferrals_update_requires_steam'))
        return
    end
    
    MySQL.single('SELECT * FROM bans WHERE (license = ? OR steam = ? OR discord = ? OR ip = ?) AND active = 1', {
        identifiers.license,
        identifiers.steam,
        identifiers.discord,
        identifiers.ip
    }, function(ban)
        if ban then
            if ban.unbantime and os.time() >= ban.unbantime then
                MySQL.update('UPDATE bans SET active = 0 WHERE id = ?', {ban.id})
                deferrals.done()
            else
                local unbanDate = ban.unbantime and os.date("%Y-%m-%d %H:%M:%S", ban.unbantime) or "Never"
                deferrals.done(string.format(_L('banscreen_banText_permanent'), ban.id, ban.reason))
            end
        else
            deferrals.done()
        end
    end)
end)
