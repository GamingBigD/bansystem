Config = {}

-- Custom Notify -- type is 'success' or 'error'
Config.notify = function(src, type, title, message)
    if src == 0 then
        print(title .. ': ' .. message)
    elseif src ~= nil then
        if GetResourceState("ov_notifier") == 'started' then
            TriggerClientEvent('ov_notify', src, type, title, message)
        else
            local xPlayer = ESX.GetPlayerFromId(src)
            if xPlayer then
                xPlayer.showNotification(message)
            end
        end
    else
        if GetResourceState("ov_notifier") == 'started' then
            TriggerEvent('ov_notify', type, title, message)
        else
            ESX.ShowNotification(message)
        end
    end
end

-- Permission check
Config.canPlayerBanTargetPlayer = function(xPlayer, xTarget)
    if (xPlayer.getGroup() == "superadmin") then
        return true
    end
    if (xTarget ~= nil and xTarget.getGroup() == "superadmin") then
        return false
    end
    return true
end

-- Custom HelpNotify
Config.HelpNotify = function(src, message)
    if src == nil then
        if GetResourceState("ov_notifier") == "started" then
            exports["ov_notifier"]:sendHelpNotify(message)
        else
            ESX.ShowHelpNotification(message)
        end
    end
end

-- Discord Webhook Configuration
Config.Webhooks = {
    ban = "",  -- Discord Webhook URL for bans
    unban = "", -- Discord Webhook URL for unbans
    warn = "", -- Discord Webhook URL for warns
    jail = "", -- Discord Webhook URL for jail
    unjail = "" -- Discord Webhook URL for unjail
}
