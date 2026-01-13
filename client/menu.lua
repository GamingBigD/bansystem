-- Ban Menu
local menuOpen = false

-- Open Ban Menu
RegisterCommand('banmenu', function()
    if not menuOpen then
        OpenBanMenu()
    end
end, false)

-- Open Ban Menu Function
function OpenBanMenu()
    ESX.TriggerServerCallback('ov_bansystem:isAdmin', function(isAdmin)
        if not isAdmin then
            ESX.ShowNotification(_L('no_permission'))
            return
        end
        
        menuOpen = true
        
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ban_menu', {
            title = _L('ban_menu_open_settings'),
            align = 'top-left',
            elements = {
                {label = _L('ban_menu_open_ban'), value = 'ban'},
                {label = _L('ban_menu_open_jail'), value = 'jail'},
                {label = _L('ban_menu_open_warn'), value = 'warn'},
                {label = _L('ban_menu_open_banlist'), value = 'banlist'},
                {label = _L('ban_menu_open_warnlist'), value = 'warnlist'},
            }
        }, function(data, menu)
            if data.current.value == 'ban' then
                OpenBanPlayerMenu()
            elseif data.current.value == 'jail' then
                OpenJailPlayerMenu()
            elseif data.current.value == 'warn' then
                OpenWarnPlayerMenu()
            elseif data.current.value == 'banlist' then
                OpenBanListMenu()
            elseif data.current.value == 'warnlist' then
                OpenWarnListMenu()
            end
        end, function(data, menu)
            menu.close()
            menuOpen = false
        end)
    end)
end

-- Open Ban Player Menu
function OpenBanPlayerMenu()
    ESX.UI.Menu.CloseAll()
    
    local elements = {}
    
    -- Get online players
    ESX.TriggerServerCallback('ov_bansystem:getOnlinePlayers', function(players)
        for _, player in ipairs(players) do
            table.insert(elements, {
                label = player.name .. ' [' .. player.id .. ']',
                value = player.id,
                name = player.name
            })
        end
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ban_player_menu', {
            title = _L('ban_menu_open_ban'),
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            local playerId = data.current.value
            local playerName = data.current.name
            
            -- Open ban options
            OpenBanOptionsMenu(playerId, playerName)
        end, function(data, menu)
            menu.close()
            OpenBanMenu()
        end)
    end)
end

-- Open Ban Options Menu
function OpenBanOptionsMenu(playerId, playerName)
    ESX.UI.Menu.CloseAll()
    
    local elements = {}
    
    -- Add templates
    table.insert(elements, {label = '--- Templates ---', value = nil})
    for _, template in ipairs(SharedConfig.BanTemplates) do
        local durationText = template.duration == -1 and "Permanent" or template.duration .. " min"
        table.insert(elements, {
            label = template.reason .. ' (' .. durationText .. ')',
            value = 'template',
            templateId = template.id,
            duration = template.duration,
            reason = template.reason
        })
    end
    
    -- Add custom ban
    table.insert(elements, {label = '--- Custom ---', value = nil})
    table.insert(elements, {label = 'Custom Ban', value = 'custom'})
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ban_options_menu', {
        title = _L('ban_menu_ban_info', playerName),
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'template' then
            TriggerServerEvent('ov_bansystem:banPlayerTemplate', playerId, data.current.templateId)
            menu.close()
            OpenBanMenu()
        elseif data.current.value == 'custom' then
            OpenCustomBanMenu(playerId, playerName)
        end
    end, function(data, menu)
        menu.close()
        OpenBanPlayerMenu()
    end)
end

-- Open Custom Ban Menu
function OpenCustomBanMenu(playerId, playerName)
    ESX.UI.Menu.CloseAll()
    
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'custom_ban_duration', {
        title = 'Ban Dauer (Minuten, -1 = Permanent)'
    }, function(data, menu)
        local duration = tonumber(data.value)
        
        if not duration then
            ESX.ShowNotification('Ungültige Dauer')
            return
        end
        
        menu.close()
        
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'custom_ban_reason', {
            title = 'Ban Grund'
        }, function(data2, menu2)
            local reason = data2.value
            
            if not reason or reason == "" then
                ESX.ShowNotification('Kein Grund angegeben')
                return
            end
            
            TriggerServerEvent('ov_bansystem:banPlayer', playerId, duration, reason)
            menu2.close()
            OpenBanMenu()
        end, function(data2, menu2)
            menu2.close()
            OpenBanOptionsMenu(playerId, playerName)
        end)
    end, function(data, menu)
        menu.close()
        OpenBanOptionsMenu(playerId, playerName)
    end)
end

-- Open Jail Player Menu
function OpenJailPlayerMenu()
    ESX.UI.Menu.CloseAll()
    
    local elements = {}
    
    ESX.TriggerServerCallback('ov_bansystem:getOnlinePlayers', function(players)
        for _, player in ipairs(players) do
            table.insert(elements, {
                label = player.name .. ' [' .. player.id .. ']',
                value = player.id,
                name = player.name
            })
        end
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jail_player_menu', {
            title = _L('ban_menu_open_jail'),
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            local playerId = data.current.value
            local playerName = data.current.name
            
            OpenJailOptionsMenu(playerId, playerName)
        end, function(data, menu)
            menu.close()
            OpenBanMenu()
        end)
    end)
end

-- Open Jail Options Menu
function OpenJailOptionsMenu(playerId, playerName)
    ESX.UI.Menu.CloseAll()
    
    local elements = {}
    
    table.insert(elements, {label = '--- Templates ---', value = nil})
    for _, template in ipairs(SharedConfig.JailTemplates) do
        table.insert(elements, {
            label = template.reason .. ' (' .. template.duration .. ' min)',
            value = 'template',
            templateId = template.id
        })
    end
    
    table.insert(elements, {label = '--- Custom ---', value = nil})
    table.insert(elements, {label = 'Custom Jail', value = 'custom'})
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jail_options_menu', {
        title = 'Jail - ' .. playerName,
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'template' then
            TriggerServerEvent('ov_bansystem:jailPlayerTemplate', playerId, data.current.templateId)
            menu.close()
            OpenBanMenu()
        elseif data.current.value == 'custom' then
            OpenCustomJailMenu(playerId, playerName)
        end
    end, function(data, menu)
        menu.close()
        OpenJailPlayerMenu()
    end)
end

-- Open Custom Jail Menu
function OpenCustomJailMenu(playerId, playerName)
    ESX.UI.Menu.CloseAll()
    
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'custom_jail_duration', {
        title = 'Jail Dauer (Minuten)'
    }, function(data, menu)
        local duration = tonumber(data.value)
        
        if not duration or duration <= 0 then
            ESX.ShowNotification('Ungültige Dauer')
            return
        end
        
        menu.close()
        
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'custom_jail_reason', {
            title = 'Jail Grund'
        }, function(data2, menu2)
            local reason = data2.value
            
            if not reason or reason == "" then
                ESX.ShowNotification('Kein Grund angegeben')
                return
            end
            
            TriggerServerEvent('ov_bansystem:jailPlayer', playerId, duration, reason)
            menu2.close()
            OpenBanMenu()
        end, function(data2, menu2)
            menu2.close()
            OpenJailOptionsMenu(playerId, playerName)
        end)
    end, function(data, menu)
        menu.close()
        OpenJailOptionsMenu(playerId, playerName)
    end)
end

-- Open Warn Player Menu
function OpenWarnPlayerMenu()
    ESX.UI.Menu.CloseAll()
    
    local elements = {}
    
    ESX.TriggerServerCallback('ov_bansystem:getOnlinePlayers', function(players)
        for _, player in ipairs(players) do
            table.insert(elements, {
                label = player.name .. ' [' .. player.id .. ']',
                value = player.id,
                name = player.name
            })
        end
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warn_player_menu', {
            title = _L('ban_menu_open_warn'),
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            local playerId = data.current.value
            local playerName = data.current.name
            
            OpenWarnOptionsMenu(playerId, playerName)
        end, function(data, menu)
            menu.close()
            OpenBanMenu()
        end)
    end)
end

-- Open Warn Options Menu
function OpenWarnOptionsMenu(playerId, playerName)
    ESX.UI.Menu.CloseAll()
    
    local elements = {}
    
    table.insert(elements, {label = '--- Templates ---', value = nil})
    for _, template in ipairs(SharedConfig.WarnTemplates) do
        table.insert(elements, {
            label = template.reason,
            value = 'template',
            templateId = template.id
        })
    end
    
    table.insert(elements, {label = '--- Custom ---', value = nil})
    table.insert(elements, {label = 'Custom Warn', value = 'custom'})
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warn_options_menu', {
        title = 'Warn - ' .. playerName,
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'template' then
            TriggerServerEvent('ov_bansystem:warnPlayerTemplate', playerId, data.current.templateId)
            menu.close()
            OpenBanMenu()
        elseif data.current.value == 'custom' then
            OpenCustomWarnMenu(playerId, playerName)
        end
    end, function(data, menu)
        menu.close()
        OpenWarnPlayerMenu()
    end)
end

-- Open Custom Warn Menu
function OpenCustomWarnMenu(playerId, playerName)
    ESX.UI.Menu.CloseAll()
    
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'custom_warn_reason', {
        title = 'Warn Grund'
    }, function(data, menu)
        local reason = data.value
        
        if not reason or reason == "" then
            ESX.ShowNotification('Kein Grund angegeben')
            return
        end
        
        TriggerServerEvent('ov_bansystem:warnPlayer', playerId, reason)
        menu.close()
        OpenBanMenu()
    end, function(data, menu)
        menu.close()
        OpenWarnOptionsMenu(playerId, playerName)
    end)
end

-- Open Ban List Menu
function OpenBanListMenu()
    ESX.UI.Menu.CloseAll()
    ESX.ShowNotification('Ban List - Coming Soon')
    OpenBanMenu()
end

-- Open Warn List Menu
function OpenWarnListMenu()
    ESX.UI.Menu.CloseAll()
    ESX.ShowNotification('Warn List - Coming Soon')
    OpenBanMenu()
end
