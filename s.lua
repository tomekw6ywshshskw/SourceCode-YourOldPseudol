------komendy------

function sendPrivateMessage(sender, receiverName, message)
    local receiver = getPlayerFromName(receiverName)
    if receiver then
        outputChatBox("[DM] "..getPlayerName(sender)..": "..receiverName..": "..message, receiver, 255, 255, 0)
        outputChatBox("[DM] "..receiverName..": "..message, sender, 255, 255, 0)
    else
        outputChatBox("Player not found!", sender, 255, 0, 0)
    end
end

addCommandHandler("prive",
    function(player, cmd, targetPlayer, ...)
        local message = table.concat({...}, " ")
        if targetPlayer and message then
            sendPrivateMessage(player, targetPlayer, message)
        else
            outputChatBox("Usage: /prive [player] [message]", player, 255, 0, 0)
        end
    end
)

addCommandHandler("DW",
    function(player, cmd, ...)
        local message = table.concat({...}, " ")
        if message then
            outputChatBox("[DarkWeb] Anonim: "..message, root, 255, 255, 255, true)
        else
            outputChatBox("Usage: /DW [message]", player, 255, 0, 0)
        end
    end
)

function onTransferMoney(plr, cmd, target, value)
    if not target or not tonumber(value) then
        outputChatBox(' Użyj: /przelej <nick/ID> <kwota>', plr)
        return
    end
    value=tonumber(value)
    local target=findPlayer(plr,target)
    if not target then
		triggerClientEvent(plr,"addNotification",root,'* Nie znaleziono podanego gracza.',"error")
        return
    end
	if not (getElementData(target, "player:logged") == true) then
	   outputChatBox('* Gracz nie jest zalogowany!.', plr, 255, 0, 0)
	return end
    if getPlayerMoney(plr) < value then
		triggerClientEvent(plr,"addNotification",root,'* Nie masz wystarczajacych środków.',"error")
        return
    end
    if value == 0 or value < 0 then
		triggerClientEvent(plr,"addNotification",root,'* Podałeś nie prawidłową wartość.',"error")
        return
    end
    takePlayerMoney(plr, value)
    givePlayerMoney(target ,value)

    outputChatBox("#2A7900* Przelałeś Pieniądze graczowi: #ffffff"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."("..getElementData(target,"id")..") #2A7900Ilość przelanej gotówki: #ffffff"..value, plr,  _, _, _, true)
    outputChatBox("#2A7900* Dostałeś pieniądze od: #ffffff"..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."("..getElementData(plr,"id")..") #2A7900ilość otrzymanej gotówki: #ffffff"..value, target,  _, _, _, true)

    local transfer_text=('TRANSFER> %s(%d)(uid:%d)>> %s(%d)(uid:%d): %d'):format(getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"id"), getElementData(plr,"player:uid"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"id"),getElementData(target,"player:uid"), value)
	triggerClientEvent("onDebugMessage", resourceRoot, transfer_text,4, "TRANSFER")
	triggerEvent("admin:logs", root, transfer_text)
	local uid=getElementData(target,"player:uid")
	if not uid then return end
	local money=getPlayerMoney(target)
	local query=exports["ogrpg-db"]:dbSet("UPDATE ogrpg_users SET money=? WHERE id=?",
	money, uid)
end
addCommandHandler('transfer', onTransferMoney)



































---ac itd---
addEventHandler("onPlayerCommand", root, function(command)
if command == "register" then cancelEvent() return end
if command == "logout" then cancelEvent() return end
if command == "msg" then cancelEvent() return end
if command == "Toggle" then cancelEvent() return end
if command == "Next" then  cancelEvent() return end
if command == "Previous" then cancelEvent() return end
if command == "say" then  return end
end
)
