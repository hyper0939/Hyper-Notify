local function Notify(player, title, message, type, duration)
    TriggerClientEvent("hyper_notify:Show", player, title, message, type, duration)
end

exports("Notify", Notify)

-- // Github \\ --
local ResourceName = GetCurrentResourceName()

local GITHUB_USER = "hyper0939"
local GITHUB_REPO = "hyper-notify"
local GITHUB_BRANCH = "main"

local function GetCurrentVersion()
    local manifest = LoadResourceFile(ResourceName, "fxmanifest.lua")
    if not manifest then return "unkown" end
    return manifest:match("version%s+['\"](.-)['\"]") or "unknown"
end

local function CheckForUpdate()
    local currentVersion = GetCurrentVersion()

    PerformHttpRequest(("https://raw.githubusercontent.com/%s/%s/%s/fxmanifest.lua"):format(GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH),
    function (status, body, headers)
        if status ~= 200 or not body then
            print("^3[%s] ^7 Update-Check failed (HTTP %s)"):format(ResourceName, status)
            return
        end

        local latestVersion = body:match("version%s+['\"](.-)['\"]") or "unknown"
        if not latestVersion then
            print(("^3[%s] ^7Could not read the GitHub version."):format(ResourceName))
            return
        end

        if currentVersion == latestVersion then
            print(("^2[%s] ^7Aktuell auf dem neusten Stand. (v%s)"):format(ResourceName, currentVersion))
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