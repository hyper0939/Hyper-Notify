Config = {}

Config.AceAllowedName = "hyper_notify.announce"

Config.AnnounceAllowedLicenses = {
    ["license:2c6f0795336282eaa0184efec71416e55701373f"] = true
}

Config.AnnounceSound = "Warning" -- Info | Success | Warning | Error
Config.AnnounceDefaultDuration = 8000
Config.AnnounceCommandName = "announce"

Config.Language = {
    ["no_permission_title"] = "No permission",
    ["no_permission"] = "You are not allowed to use this command.",
    ["no_title"] = "Announcement",

    ["wrong_command_title"] = "Invalid command",
    ["wrong_command"] = "Use: /announce [title] [message] [duration]",
}