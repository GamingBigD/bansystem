_LOCALE = _LOCALE or {}

_LOCALE.en = {
    no_permission = "You don't have permission to do this!",

    command_ban_help = "Ban a player.",
    command_ban_arg_value_help = "ID or License of the player.",
    command_ban_arg_duration_help = "Duration of the ban (in minutes).",
    command_ban_arg_reason_help = "Reason for the ban.",

    command_banTemplate_help = "Ban a player using a template.",
    command_banTemplate_arg_templateId_help = "The template ID.",

    command_unjail_help = "Remove a player from admin jail.",
    command_unjail_arg_value_help = "ID of the player.",
    command_unjail_arg_reason_help = "Reason for unjail.",
    command_unjail_need_reason = "You must provide a reason for unjail!",
    command_unjail_not_found = "This player was not found!",
    command_unjail_unjailed = "You removed %s from admin jail!",
    command_unjail_unjailed_unjailedPlayer = "You were removed from admin jail!",

    command_unban_arg_value_help = "The ban ID or FiveM license of the player.",

    command_delban_arg_id_help = "The ban ID of the user",

    command_resetbans_help = "Reset the ban count cache of a player",
    command_resetbans_arg_value_help = "ID of the player.",

    command_bannote_usage = "Please use: /bannote (banId) (note)",
    command_bannote_arg_banId_help = "The ban ID.",
    command_bannote_arg_note_help = "The note.",
    command_bannote_no_number = "The ban ID must be a number!",
    command_bannote_edited = "You successfully edited the note!",
    command_bannote_not_banner = "You didn't issue this ban!",
    command_bannote_not_found = "This ban ID could not be found!",

    command_jailnote_help = "Add a note to a jail entry.",
    command_jailnote_arg_jailId_help = "The jail ID.",
    command_jailnote_arg_note_help = "The note.",
    command_jailnote_usage = "Please use: /jailnote (jailId) (note)",
    command_jailnote_no_number = "The jail ID must be a number!",
    command_jailnote_edited = "You successfully edited the note!",
    command_jailnote_not_jailer = "You didn't issue this jail!",
    command_jailnote_not_found = "This jail ID could not be found!",

    chat_author = "[SYSTEM]",
    chat_banTemplate_message = "\nTemplate ID: %s. Duration: %s minutes. Reason: %s",
    chat_banTemplate_empty = "\nThis server has no templates configured.",
    chat_logs_message = "\nBan ID: %s. Banned on: %04d-%02d-%02d %02d:%02d:%02d. Reason: %s. Duration: %s minutes. Active: %s",
    chat_logs_empty = "\nThere are no logs for this user.",

    notify_title = "Bansystem",
    notify_ban_success = "Player with ID '%s' has been banned.",
    notify_ban_targetNotFound = "No player with ID '%s' could be found.",
    notify_ban_alreadyActive = "Player is already banned.",
    notify_ban_invalidArgs = "Invalid arguments. Duration must be -1 (permanent) or greater than 0. Reason cannot be empty.",
    notify_banTemplate_failure = "There is no template with ID '%s'.",

    notify_unban_success = "A player has been unbanned.",
    notify_unban_failure = "Player is not banned or no ban could be found.",

    notify_delban_success = "Ban ID '%s' has been deleted.",
    notify_delban_failure = "Ban ID '%s' could not be found.",

    notify_warn_success = "You successfully warned the player.",
    notify_warn_recieved = "You have been warned! Reason: %s",

    notify_restbans_success = "You have reset the ban count of %s!",

    deferrals_update = "We are checking if you are banned. Please wait...",
    deferrals_update_requires_steam = "No Steam ID could be found for your account, make sure Steam is running!",
    deferrals_update_requires_discord = "No Discord ID could be found for your account, make sure Discord is running!",

    banscreen_htmlBanText = "<div style=\"background-color: rgba(30, 30, 30, 0.5); padding: 20px; border: solid 2px var(--color-modal-border); border-radius: var(--border-radius-normal); margin-top: 25px; position: relative;\"><h2>You have been banned from this server!</h2><br><br><p style=\"font-size: 1.25rem; padding: 0px\"><strong>Ban ID: </strong>%s <br> <strong>Reason: </strong> %s <br> <strong>Unban: </strong> %s <br><br> Contact our Discord for more information! </p></div>",

    banscreen_banText = "\n\nYou are banned from this server!\nBan ID: %s\nReason: %s\nUnban: %s-%s-%s %s:%s:%s",
    banscreen_banText_permanent = "\n\nYou are permanently banned from this server.\nBan ID: %s\nReason: %s",
    banscreen_banText_unban = "\n\nYou have been unbanned and can now play again!\n\nAlways follow all rules.",
    banscreen_banText_unban_blacklist = "\n\nYou could not be unbanned. Contact support if you want to play again!\nBan ID: %s\nReason: %s",

    ban_attempt_bypass_prefix = "Multi:\n ",

    jail_player_finish = "You moved %s to admin jail! ID: %s",
    jail_player_offline = "The player could not be found!",
    jail_player_getJailed = "You were put in admin jail! Reason: %s | Duration: %s",
    jail_player_already = "%s is already in admin jail!",
    jail_player_not_jailed = "%s is not in admin jail!",
    jail_rest_time = "You are still in admin jail for %s minutes!",
    jail_out = "You have served your time in admin jail!",
    jail_dont_leave = "You must not leave the area!",
    jail_remaingTimeText = "Remaining time in admin jail: %s minutes (%s)",
    jail_fast_last_coord_distance = "Move more! This spot is already clean.",
    jail_fast_last_moved = "You must not move!",
    jail_fast_help = "To clean the deck!",

    level_reached = 'You cannot create any more bans! Please contact an administrator!',
    not_bannable = 'You cannot ban this player!',

    ban_menu_search_for_id = "Search by ID",
    ban_menu_search_for_banid = "Search ban ID/License",
    ban_menu_open_lastPlayers = "Recent players",
    ban_menu_players = "Players",
    ban_menu_id = "ID",
    ban_menu_banid = "Ban ID",
    ban_menu_warn_list = "Warn list",
    ban_menu_warn_info = "Warn info - %s",
    ban_menu_warn_info_id = "ID: [%s]",
    ban_menu_warn_info_by = "Issued by: %s",
    ban_menu_warn_info_reason = "Reason: %s",
    ban_menu_open_ban = "Ban",
    ban_menu_open_jail = "Admin jail",
    ban_menu_open_warn = "Warn",
    ban_menu_open_warnlist = "Warn list",
    ban_menu_open_banlist = "Ban list",
    ban_menu_open_settings = "Settings",
    ban_menu_select = "Select",
    ban_menu_ban_info = "Ban info - %s",
    ban_menu_ban_info_id = "ID: [%s]",
    ban_menu_ban_info_duration = "Duration: %s",
    ban_menu_ban_info_reason = "Reason: %s",
    ban_menu_ban_info_active = "Active: Yes",
    ban_menu_ban_info_inactive = "Active: No",
    ban_menu_jail_templates = "Jail - Templates",
    ban_menu_warn_templates = "Warn - Templates",
    ban_menu_ban_templates = "Ban - Templates",

    ban_menu_settings_ip_ban_on = "<span style=\"color:green;\">IP BAN - enable</span>",
    ban_menu_settings_ip_ban_off = "<span style=\"color:red;\">IP BAN - disable</span>",

    ban_menu_notify_no_player_found = "No player with ID '%s' found.",
    ban_menu_notify_no_active_ban_found = "No active ban with this ID/License found.",
    ban_menu_notify_ip_ban_on = "IP ban has been enabled!",
    ban_menu_notify_ip_ban_off = "IP ban has been disabled!",
    ban_menu_notify_you_received_warn = "You received a warning\n~r~            %s",

    ban_report_creating = "Creating a report!",
    ban_report_created = "Your report (%s) has been created!",
    ban_report_no_near_players = "There are no players near you!",
    ban_report_delay = "You cannot create a new report right now! Previous report: %s",

    jail_log = "Player %s was put in admin jail for %s. \nDuration: %s minutes\nJail ID: %s",
    unjail_log = "Player %s was released from admin jail. \nReason: %s",
    warn_log = "```%s warned player %s! \nReason ⇨ %s```",
    ban_log = "```%s banned player %s!\nReason ⇨ %s\nBan ID ⇨ %s\nDuration ⇨ %s ```",
    unban_log = "```%s unbanned a player!\nBan ID ⇨ %s```",
    delete_ban_log = "```Ban %s was deleted!",
    ban_note_log = "**A ban note was added!**\n> Ban ID: %s\n> Note: %s",
    jail_note_log = "**A jail note was added!**\n> Jail ID: %s\n> Note: %s"
}
