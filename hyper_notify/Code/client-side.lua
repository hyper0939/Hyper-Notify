local function Notify(title, message, type, duration)
    SendNUIMessage({
        action = "Show",
        title = title,
        message = message,
        type = type,
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

RegisterNetEvent("hyper_notify:Show", Notify)