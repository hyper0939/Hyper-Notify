# Hyper Notify

<img width="453" height="172" alt="image" src="https://github.com/user-attachments/assets/e839761d-949a-4feb-8d70-4c25056c338e" />

### Types:
##### **Types = Info, Success, Warning, Error**

## Exports (Client Side):
##### exports["hyper_notify"]:Notify(title, message, type, time)

## **Success**
##### exports["hyper_notify"]:Success(title, message, time)

## **Warning**
##### exports["hyper_notify"]:Warning(title, message, time)

## **Error**
##### exports["hyper_notify"]:Error(title, message, time)

## **Exports (Server Side)**:
##### exports["hyper_notify"]:Notify(source, title, message, type, time)

## **Trigger Events (Client Side)**:
##### TriggerEvent("hyper_notify:Show", title, message, type, duration)

## **Trigger Events (Server Side)**:
##### TriggerClientEvent("hyper_notify:Show", playerId, title, message, type, duration)

# TODO:
- Smaller Bg
- SFX
- Maybe announce