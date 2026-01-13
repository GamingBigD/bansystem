_LOCALE = _LOCALE or {}

_LOCALE.de = {
    no_permission = "Dazu hast du keine Berechtigung!",

    command_ban_help = "Bannt einen Spieler.",
    command_ban_arg_value_help = "ID oder Lizenz von dem Spieler.",
    command_ban_arg_duration_help = "Die Länge des Banns (in Minuten).",
    command_ban_arg_reason_help = "Der Grund für den Bann.",

    command_banTemplate_help = "Bannt einen Spieler per Template.",
    command_banTemplate_arg_templateId_help = "Die Template Id.",

    command_unjail_help = "Entferne einen Spieler aus dem Adminknast.",
    command_unjail_arg_value_help = "ID von dem Spieler.",
    command_unjail_arg_reason_help = "Grund für UnJail.",
    command_unjail_need_reason = "Du musst einen Grund für den UnJail angeben!",
    command_unjail_not_found = "Dieser Spieler wurde nicht gefunden!",
    command_unjail_unjailed = "Du hast %s aus dem Adminknast entfernt!",
    command_unjail_unjailed_unjailedPlayer = "Du wurdest aus dem Adminknast entfernt!",

    command_unban_arg_value_help = "Die Ban ID oder die FiveM Lizenz des Spielers.",

    command_delban_arg_id_help = "Die Ban ID  von dem User",

    command_resetbans_help = "Resette den Bancount cache von einem Spieler",
    command_resetbans_arg_value_help = "ID von dem Spieler.",

    command_bannote_usage = "Bitte nutze: /bannote (banId) (Notiz)",
    command_bannote_arg_banId_help = "Die Ban Id.",
    command_bannote_arg_note_help = "Die Notiz.",
    command_bannote_no_number = "Die Banid muss eine Zahl sein!",
    command_bannote_edited = "Du hast erfolgreich die Notiz angepasst!",
    command_bannote_not_banner = "Du hast diesen Ban nicht ausgeführt!",
    command_bannote_not_found = "Diese BanId konnte nicht gefunden werden!",

    command_jailnote_help = "Bannt einen Spieler per Template.",
    command_jailnote_arg_jailId_help = "Die Jail Id.",
    command_jailnote_arg_note_help = "Die Notiz.",
    command_jailnote_usage = "Bitte nutze: /jailnote (jailId) (Notiz)",
    command_jailnote_no_number = "Die jailId muss eine Zahl sein!",
    command_jailnote_edited = "Du hast erfolgreich die Notiz angepasst!",
    command_jailnote_not_jailer = "Du hast diesen Jail nicht ausgeführt!",
    command_jailnote_not_found = "Diese jailId konnte nicht gefunden werden!",

    chat_author = "[SYSTEM]",
    chat_banTemplate_message = "\nTemplate ID: %s. Dauer: %s Minuten. Grund: %s",
    chat_banTemplate_empty = "\nDieser Server hat keine Templates eingerichtet.",
    chat_logs_message = "\nBan ID: %s. Gebannt am: %04d-%02d-%02d %02d:%02d:%02d. Grund: %s. Dauer: %s Minuten. Aktiv: %s",
    chat_logs_empty = "\nEs gibt keine Protokolle für diesen Benutzer.",

    notify_title = "Bansystem",
    notify_ban_success = "Der Spieler mit der ID '%s' wurde gebannt.",
    notify_ban_targetNotFound = "Es konnte kein Spieler mit der ID '%s' gefunden werden.",
    notify_ban_alreadyActive = "Der Spieler ist bereits gebannt.",
    notify_ban_invalidArgs = "Falsche Argumente. Die Dauer muss -1 (permanent) sein oder größer als 0 (zero). Grund darf nicht leer sein.",
    notify_banTemplate_failure = "Es gibt kein Template mit der ID '%s'.",

    notify_unban_success = "Ein Spieler wurde entbannt.",
    notify_unban_failure = "Spieler ist nicht gebannt oder es konnte kein Ban gefunden werden.",

    notify_delban_success = "Ban ID '%s' wurde gelöscht.",
    notify_delban_failure = "Ban ID '%s' konnte nicht gefunden werden.",

    notify_warn_success = "Du hast den Spieler erfolgreich verwarnt.",
    notify_warn_recieved = "Du wurdest verwarnt! Grund: %s",

    notify_restbans_success = "Du hast den Bancount von %s resettet!",

    deferrals_update = "Wir prüfen, ob du gesperrt bist. Bitte warten...", -- Displayed when trying to connect to server.
    deferrals_update_requires_steam = "Es konnte keine SteamId zu deinem Account gefunden werden, stelle sicher, dass du Steam gestartet hast!",
    deferrals_update_requires_discord = "Es konnte keine DiscordId zu deinem Account gefunden werden, stelle sicher, dass du Discord gestartet hast!",

    banscreen_htmlBanText = "<div style=\"background-color: rgba(30, 30, 30, 0.5); padding: 20px; border: solid 2px var(--color-modal-border); border-radius: var(--border-radius-normal); margin-top: 25px; position: relative;\"><h2>Du wurdest von diesem Server gebannt!</h2><br><br><p style=\"font-size: 1.25rem; padding: 0px\"><strong>BanID: </strong>%s <br> <strong>Grund: </strong> %s <br> <strong>Entbannung: </strong> %s <br><br> Melde dich in unserem Discord für weitere Informationen! </p></div>",

    banscreen_banText = "\n\nDu bist gebannt auf diesem Server!\nBan ID: %s\nGrund: %s\nEntbannung: %s-%s-%s %s:%s:%s", -- [banId], [banReason], [unbanYear], [unbanDay], [unbanMonth], [unbanHour], [unbanMinute], [unbanSecond],
    banscreen_banText_permanent = "\n\nDu bist permanent gesperrt auf diesem Server.\nBan ID: %s\nGrund: %s",
    banscreen_banText_unban = "\n\nDu wurdest entbannt und kannst jetzt wieder spielen!\n\nHalte dich jetzt immer an alle Regeln.",
    banscreen_banText_unban_blacklist = "\n\nDu konntest nicht entbannt werden. Melde dich im Support, wenn du wieder spielen willst!\nBan ID: %s\nGrund: %s",

    ban_attempt_bypass_prefix = "Multi:\n ",


    jail_player_finish = "Du hast %s in den Adminkanst verschoben! ID: %s",
    jail_player_offline = "Der Spieler konnte nicht gefunden werden!",
    jail_player_getJailed = "Du wurdest in den Adminkanst gesteckt! Grund : %s | Dauer : %s",
    jail_player_already = "%s ist bereits im Adminknast!",
    jail_player_not_jailed = "%s ist nicht im Adminknast!",
    jail_rest_time = "Du bist noch für %s Minuten im Adminknast inhaftiert!",
    jail_out = "Du hast deine Haftzeit im Adminknast abgesessen!",
    jail_dont_leave = "Du darfst die Umgebung nicht verlassen!",
    jail_remaingTimeText = "Restliche Zeit im Adminknast: %s Minuten (%s)",
    jail_fast_last_coord_distance = "Beweg dich mehr! Diese Stelle ist schon sauber.",
    jail_fast_last_moved = "Du darfst dich nicht bewegen!",
    jail_fast_help = "Um das Deck zu putzen!",

    level_reached = 'Du kannst keine weiteren Bans mehr erstellen! Bitte melde dich bei einem Administrator!',
    not_bannable = 'Du kannst diesen Spieler nicht bannen!',

    ban_menu_search_for_id = "Suche nach ID",
    ban_menu_search_for_banid = "Ban suchen ID/License",
    ban_menu_open_lastPlayers = "Frühere Spieler",
    ban_menu_players = "Spieler",
    ban_menu_id = "ID",
    ban_menu_banid = "Ban-ID",
    ban_menu_warn_list = "Warnlist",
    ban_menu_warn_info = "Warninfo - %s",
    ban_menu_warn_info_id = "ID : [%s]",
    ban_menu_warn_info_by = "Ersteller : %s",
    ban_menu_warn_info_reason = "Grund : %s",
    ban_menu_open_ban = "Bannen",
    ban_menu_open_jail = "Adminknast",
    ban_menu_open_warn = "Warnen",
    ban_menu_open_warnlist = "Warnlist",
    ban_menu_open_banlist = "Banlist",
    ban_menu_open_settings = "Einstellungen",
    ban_menu_select = "Auswahl",
    ban_menu_ban_info = "Baninfo - %s",
    ban_menu_ban_info_id = "ID : [%s]",
    ban_menu_ban_info_duration = "Dauer : %s",
    ban_menu_ban_info_reason = "Grund : %s",
    ban_menu_ban_info_active = "Aktiv : Ja",
    ban_menu_ban_info_inactive = "Aktiv : Nein",
    ban_menu_jail_templates = "Jail - Templates",
    ban_menu_warn_templates = "Warn - Templates",
    ban_menu_ban_templates = "Ban - Templates",

    ban_menu_settings_ip_ban_on = "<span style=\"color:green;\">IP BAN - aktivieren</span>",
    ban_menu_settings_ip_ban_off = "<span style=\"color:red;\">IP BAN - deaktivieren</span>",

    ban_menu_notify_no_player_found = "Kein Spieler mit der ID '%s' gefunden.",
    ban_menu_notify_no_active_ban_found = "Kein aktiven Bann mit dieser ID/License gefunden.",
    ban_menu_notify_ip_ban_on = "Der IP-Ban wurde nun wieder aktiviert!",
    ban_menu_notify_ip_ban_off = "Der IP-Ban wurde nun deaktiviert!",
    ban_menu_notify_you_received_warn = "Du hast einen Warn erhalten\n~r~            %s",

    ban_report_creating = "Es wird ein Report erstellt!",
    ban_report_created = "Dein Report (%s) wurde erstellt!",
    ban_report_no_near_players = "Es sind keine Spieler in deiner Nähe!",
    ban_report_delay = "Du kannst gerade keinen neuen Report erstellen! Alter Report: %s",

    jail_log = "Der Spieler %s wurde für %s in den Adminknast gesteckt. \nDauer: %s Minuten\nJailId: %s",
    unjail_log = "Der Spieler %s wurde aus dem Adminknast geholt. \nGrund: %s",
    warn_log = "```%s hat den Spieler %s verwarnt! \nGrund ⇨ %s```",
    ban_log = "```%s hat den Spieler %s gebannt!\nGrund ⇨ %s\nBanId ⇨ %s\nDauer ⇨ %s ```",
    unban_log = "```%s hat einen Spieler entbannt!\nBanid ⇨ %s```",
    delete_ban_log = "```Der Ban %s wurde gelöscht!",
    ban_note_log = "**Es wurde eine Bannotiz hinzugefügt!**\n> BanId: %s\n> Notiz: %s",
    jail_note_log = "**Es wurde eine Jailnotiz hinzugefügt!**\n> JailId: %s\n> Notiz: %s"
}
