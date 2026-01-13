-- Version Check
local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

CreateThread(function()
    PerformHttpRequest('https://api.github.com/repos/yourusername/ov_bansystem/releases/latest', function(err, responseText, headers)
        if err == 200 then
            local data = json.decode(responseText)
            if data and data.tag_name then
                local latestVersion = data.tag_name:gsub('v', '')
                
                if currentVersion ~= latestVersion then
                    print('^3[OV Bansystem]^7 New version available!')
                    print('^3[OV Bansystem]^7 Current: ^2' .. currentVersion .. '^7 | Latest: ^2' .. latestVersion .. '^7')
                    print('^3[OV Bansystem]^7 Download: ^5' .. data.html_url .. '^7')
                else
                    print('^2[OV Bansystem]^7 You are running the latest version (^2' .. currentVersion .. '^7)')
                end
            end
        else
            print('^1[OV Bansystem]^7 Failed to check for updates')
        end
    end, 'GET')
end)
