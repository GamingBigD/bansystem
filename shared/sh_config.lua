SharedConfig = {}

-- Jail Configuration
SharedConfig.JailLocation = vector3(1641.94, 2570.44, 45.56) -- Prison location
SharedConfig.JailHeading = 268.0

-- Admin Groups (can use ban/warn/jail commands)
SharedConfig.AdminGroups = {
    "admin",
    "superadmin",
    "mod"
}

-- Ban Templates
SharedConfig.BanTemplates = {
    {id = 1, duration = 1440, reason = "Beleidigung"}, -- 1 day
    {id = 2, duration = 4320, reason = "RDM"}, -- 3 days
    {id = 3, duration = 10080, reason = "VDM"}, -- 7 days
    {id = 4, duration = 43200, reason = "Hacking/Cheating"}, -- 30 days
    {id = 5, duration = -1, reason = "Permanent Ban"}, -- Permanent
}

-- Jail Templates
SharedConfig.JailTemplates = {
    {id = 1, duration = 10, reason = "Spam"},
    {id = 2, duration = 30, reason = "Fail RP"},
    {id = 3, duration = 60, reason = "RDM"},
}

-- Warn Templates
SharedConfig.WarnTemplates = {
    {id = 1, reason = "Beleidigung"},
    {id = 2, reason = "Fail RP"},
    {id = 3, reason = "Meta Gaming"},
}

-- Max warns before auto ban
SharedConfig.MaxWarns = 3
SharedConfig.AutoBanDuration = 4320 -- 3 days in minutes

-- Locale
SharedConfig.Locale = "de"
