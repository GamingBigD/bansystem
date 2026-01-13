-- Server Callbacks

-- Check if player is admin
ESX.RegisterServerCallback('ov_bansystem:isAdmin', function(source, cb)
    cb(IsPlayerAdmin(source))
end)

-- Get online players
ESX.RegisterServerCallback('ov_bansystem:getOnlinePlayers', function(source, cb)
    local players = {}
    local xPlayers = ESX.GetExtendedPlayers()
    
    for _, xPlayer in pairs(xPlayers) do
        table.insert(players, {
            id = xPlayer.source,
            name = xPlayer.getName(),
            identifier = xPlayer.identifier
        })
    end
    
    cb(players)
end)

-- Server Events for Menu

-- Ban Player from Menu
RegisterNetEvent('ov_bansystem:banPlayer')
AddEventHandler('ov_bansystem:banPlayer', function(targetId, duration, reason)
    local source = source
    if not IsPlayerAdmin(source) then return end
    
    BanPlayer(targetId, source, reason, duration)
end)

-- Ban Player Template from Menu
RegisterNetEvent('ov_bansystem:banPlayerTemplate')
AddEventHandler('ov_bansystem:banPlayerTemplate', function(targetId, templateId)
    local source = source
    if not IsPlayerAdmin(source) then return end
    
    local template = nil
    for _, temp in ipairs(SharedConfig.BanTemplates) do
        if temp.id == templateId then
            template = temp
            break
        end
    end
    
    if not template then return end
    
    BanPlayer(targetId, source, template.reason, template.duration)
end)

-- Jail Player from Menu
RegisterNetEvent('ov_bansystem:jailPlayer')
AddEventHandler('ov_bansystem:jailPlayer', function(targetId, duration, reason)
    local source = source
    if not IsPlayerAdmin(source) then return end
    
    JailPlayer(targetId, source, reason, duration)
end)

-- Jail Player Template from Menu
RegisterNetEvent('ov_bansystem:jailPlayerTemplate')
AddEventHandler('ov_bansystem:jailPlayerTemplate', function(targetId, templateId)
    local source = source
    if not IsPlayerAdmin(source) then return end
    
    local template = nil
    for _, temp in ipairs(SharedConfig.JailTemplates) do
        if temp.id == templateId then
            template = temp
            break
        end
    end
    
    if not template then return end
    
    JailPlayer(targetId, source, template.reason, template.duration)
end)

-- Warn Player from Menu
RegisterNetEvent('ov_bansystem:warnPlayer')
AddEventHandler('ov_bansystem:warnPlayer', function(targetId, reason)
    local source = source
    if not IsPlayerAdmin(source) then return end
    
    WarnPlayer(targetId, source, reason)
end)

-- Warn Player Template from Menu
RegisterNetEvent('ov_bansystem:warnPlayerTemplate')
AddEventHandler('ov_bansystem:warnPlayerTemplate', function(targetId, templateId)
    local source = source
    if not IsPlayerAdmin(source) then return end
    
    local template = nil
    for _, temp in ipairs(SharedConfig.WarnTemplates) do
        if temp.id == templateId then
            template = temp
            break
        end
    end
    
    if not template then return end
    
    WarnPlayer(targetId, source, template.reason)
end)
