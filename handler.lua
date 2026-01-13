Config.onPlayerJailed = function(identifier, reason, duration)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer ~= nil then
        if reason == "Modding" or reason == "PC Kontrolle" or reason == "Spielmodifikationen" then
            if GetResourceState("BB_TimedRanks") == "started" then
                exports["BB_TimedRanks"]:givePlayerRank(identifier, "aufnahmepflicht", function(success)
                    print("Give timed rank aufnahmepflicht: " .. tostring(success))
                end)
            end
        end
    end
end