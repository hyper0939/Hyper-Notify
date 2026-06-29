local function Notify(player, title, message, type, duration)
    TriggerClientEvent("hyper_notify:Show", player, title, message, type, duration)
end

exports("Notify", Notify)


-- // Announce \\ --
local function HasAnnouncePermission(source)
    if IsPlayerAceAllowed(source, Config.AceAllowedName) then
        return true
    end

    local license = GetPlayerIdentifierByType(source, "license")
    if license and Config.AnnounceAllowedLicenses[license] then
        return true
    end

    return false
end

RegisterCommand(Config.AnnounceCommandName, function(source, args)
    print("Command")

    if source == 0 then
        local title = args[1] or Config.Language["no_title"]
        local hasDuration = tonumber(args[#args]) ~= nil
        local duration = tonumber(args[#args]) or Config.AnnounceDefaultDuration
        local message = table.concat(args, " ", 2, hasDuration and (#args - 1) or #args)

        TriggerClientEvent("hyper_notify:Announce", -1, title, message, duration)

        return
    end

    if not HasAnnouncePermission(source) then
        Notify(source, Config.Language["no_permission_title"], Config.Language["no_permission"], "Error", 5000)
        return
    end

    if #args < 2 then
        Notify(source, Config.Language["wrong_command_title"], Config.Language["no_permission"], "Warning", 5000)
        return
    end

    local title = args[1]
    local duration = tonumber(args[#args]) or Config.AnnounceDefaultDuration
    local hasDuration = tonumber(args[#args]) ~= nil
    local message = table.concat(args, " ", 2, hasDuration and (#args - 1) or #args)

    TriggerClientEvent("hyper_notify:Announce", -1, title, message, duration)
end, false)

-- // Github \\ --
local ResourceName = GetCurrentResourceName()

local GITHUB_USER = "hyper0939"
local GITHUB_REPO = "Hyper-Notify"
local GITHUB_BRANCH = "main"

local function GetCurrentVersion()
    local manifest = LoadResourceFile(ResourceName, "fxmanifest.lua")
    if not manifest then return "unkown" end
    return manifest:match("version%s*['\"]([%d%.]+)['\"]") or "unknown"
end

local function CheckForUpdate()
    local currentVersion = GetCurrentVersion()

    PerformHttpRequest(("https://raw.githubusercontent.com/%s/%s/%s/hyper_notify/fxmanifest.lua"):format(GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH),
    function (status, body, headers)
        if status ~= 200 or not body then
            print(("^3[%s] ^7 Update-Check failed (HTTP %s)"):format(ResourceName, status))
            return
        end

        local latestVersion = body:match("version%s*['\"]([%d%.]+)['\"]") or "unknown"
        if not latestVersion then
            print(("^3[%s] ^7Could not read the GitHub version."):format(ResourceName))
            return
        end

        if currentVersion == latestVersion then
            print(("^9[%s] ^7Aktuell auf dem neusten Stand. (v%s)"):format(ResourceName, currentVersion))
        else
            print(("^3[%s] ^7Update verfügbar! Installiert ^1v%s ^7=> Neu: ^2v%s"):format(ResourceName, currentVersion, latestVersion))
            print(("^3[%s] ^7Download https://github.com/%s/%s"):format(ResourceName, GITHUB_USER, GITHUB_REPO))
        end
    end, "GET", "", { ["Content-Type"] = "application/json" }
    )
end

AddEventHandler("onResourceStart", function(resource)
    if resource ~= ResourceName then return end

    Citizen.SetTimeout(3000, CheckForUpdate)
end)