local function Notify(player, title, message, type, duration)
    TriggerClientEvent("hyper_notify:Show", player, title, message, type, duration)
end

exports("Notify", Notify)