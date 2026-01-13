-- Server Exports

-- Ban Player Export
exports('BanPlayer', function(targetId, adminSource, reason, duration)
    return BanPlayer(targetId, adminSource, reason, duration)
end)

-- Unban Player Export
exports('UnbanPlayer', function(adminSource, value)
    return UnbanPlayer(adminSource, value)
end)

-- Warn Player Export
exports('WarnPlayer', function(targetId, adminSource, reason)
    return WarnPlayer(targetId, adminSource, reason)
end)

-- Jail Player Export
exports('JailPlayer', function(targetId, adminSource, reason, duration)
    return JailPlayer(targetId, adminSource, reason, duration)
end)

-- Unjail Player Export
exports('UnjailPlayer', function(targetId, adminSource, reason)
    return UnjailPlayer(targetId, adminSource, reason)
end)

-- Check if player is banned
exports('IsPlayerBanned', function(identifier)
    local promise = promise.new()
    
    MySQL.single('SELECT * FROM bans WHERE (license = ? OR steam = ?) AND active = 1', {
        identifier, identifier
    }, function(ban)
        if ban then
            if ban.unbantime and os.time() >= ban.unbantime then
                MySQL.update('UPDATE bans SET active = 0 WHERE id = ?', {ban.id})
                promise:resolve(false)
            else
                promise:resolve(true)
            end
        else
            promise:resolve(false)
        end
    end)
    
    return Citizen.Await(promise)
end)

-- Get player ban info
exports('GetPlayerBanInfo', function(identifier)
    local promise = promise.new()
    
    MySQL.single('SELECT * FROM bans WHERE (license = ? OR steam = ?) AND active = 1', {
        identifier, identifier
    }, function(ban)
        promise:resolve(ban)
    end)
    
    return Citizen.Await(promise)
end)

-- Get player warns count
exports('GetPlayerWarnsCount', function(identifier)
    local promise = promise.new()
    
    MySQL.scalar('SELECT COUNT(*) FROM warns WHERE license = ?', {identifier}, function(count)
        promise:resolve(count or 0)
    end)
    
    return Citizen.Await(promise)
end)

-- Check if player is jailed (client export)
if not IsDuplicityVersion() then
    exports('IsPlayerJailed', function()
        return IsPlayerJailed()
    end)
    
    exports('GetJailTime', function()
        return GetJailTime()
    end)
end
