local function Notify(title, message, type, duration)
    SendNUIMessage({
        action = "Show",
        title = title,
        message = message,
        type = type or "Info",
        duration = duration or 5000
    })
end

exports("Notify", Notify)

exports("Success", function(title, message, duration)
    Notify(title, message, "Success", duration)
end)

exports("Info", function(title, message, duration)
    Notify(title, message, "Info", duration)
end)

exports("Warning", function(title, message, duration)
    Notify(title, message, "Warning", duration)
end)

exports("Error", function(title, message, duration)
    Notify(title, message, "Error", duration)
end)

RegisterNetEvent("hyper_notify:Show", function(title, message, type, duration)
    Notify(title, message, type, duration)
end)

RegisterNetEvent("hyper_notify:Announce", function(title, message, duration)
    SendNUIMessage({
        action = "Announce",
        title = title,
        message = message,
        duration = duration or Config.AnnounceDefaultDuration,
        sound = Config.AnnounceSound
    })
end)

RegisterCommand("testnotifys", function()
    exports[GetCurrentResourceName()]:Info("Info", "Test message...", 3500)
    exports[GetCurrentResourceName()]:Success("Success", "Test message...", 3500)
    exports[GetCurrentResourceName()]:Warning("Warning", "Test message...", 3500)
    exports[GetCurrentResourceName()]:Error("Error", "Test message...", 3500)
end, false)