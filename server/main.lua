ESX = exports["es_extended"]:getSharedObject()

-- Helper function to get locale
function _L(str, ...)
    if _LOCALE[SharedConfig.Locale] and _LOCALE[SharedConfig.Locale][str] then
        return string.format(_LOCALE[SharedConfig.Locale][str], ...)
    end
    return str
end

-- Get player identifiers
function GetPlayerIdentifiers(source)
    local identifiers = {
        steam = "",
        license = "",
        discord = "",
        ip = ""
    }
    
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        
        if string.find(id, "steam:") then
            identifiers.steam = id
        elseif string.find(id, "license:") then
            identifiers.license = id
        elseif string.find(id, "discord:") then
            identifiers.discord = id
        elseif string.find(id, "ip:") then
            identifiers.ip = id
        end
    end
    
    return identifiers
end

-- Send Discord Log
function SendDiscordLog(webhook, title, message, color)
    if not webhook or webhook == "" then return end
    
    local embed = {
        {
            ["title"] = title,
            ["description"] = message,
            ["type"] = "rich",
            ["color"] = color or 16711680,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S"),
            },
        }
    }
    
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        username = "Bansystem",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

-- Check if player is admin
function IsPlayerAdmin(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    
    for _, group in ipairs(SharedConfig.AdminGroups) do
        if xPlayer.getGroup() == group then
            return true
        end
    end
    return false
end

-- Get player name
function GetPlayerName(source)
    return GetPlayerName(source) or "Unknown"
end
