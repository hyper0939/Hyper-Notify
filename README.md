# Hyper Notify

#### Types:
### Types = Info, Success, Warning, Error

## Exports (Client Side):
exports["hyper_notify"]:Notify(title, message, type, time)

### Success
exports["hyper_notify"]:Success(title, message, time)

### Warning
exports["hyper_notify"]:Warning(title, message, time)

### Error
exports["hyper_notify"]:Error(title, message, time)

## Exports (Server Side):
exports["hyper_notify"]:Notify(source, title, message, type, time)

## Trigger Events:
TriggerEvent("hyper_notify:Show", title, message, type, duration)

## Trigger Events (Server Side):
TriggerClientEvent("hyper_notify:Show", playerId, title, message, type, duration)