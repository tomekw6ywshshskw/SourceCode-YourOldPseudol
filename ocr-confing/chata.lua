local reklamaWords = {"zapraszam", "serwer", "server", "mtasa://"}

local function ninjaban(ip)
    if ip == nil or type(ip) ~= "string" then
        return false
    end

    local chunks = {ip:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")}
    if (#chunks == 4) then
        for _,v in ipairs(chunks) do
            if (tonumber(v) < 0 or tonumber(v) > 255) then
                return false
            end
        end
        return true
    else
        return false
    end
end

local function localChat(source, msg, type)
    if type == 0 then
        cancelEvent()
        if ninjaban(msg) then
            banPlayer(source, "System: Reklama")
            triggerClientEvent(root, "admin:rendering", root, "* " .. getPlayerName(source) .. "(" .. getElementData(source, "id") .. ") został(a) wyrzucony(a) przez system. Powód: Reklama")
            return
        end
        local x, y, z = getElementPosition(source)
        local sphere = createColSphere(x, y, z, 30)
        local players = getElementsWithinColShape(sphere, 'player')
        destroyElement(sphere)
        if #players == 1 then
            outputChatBox('* Nie ma żadnego gracza w pobliżu, więc wiadomość jest niemożliwa.', source, 255, 0, 0)
            return
        end
        for _, player in ipairs(players) do
            local id = getElementData(source, "id")
            outputChatBox("#0066cc[LOCAL][ID: " .. getElementData(source, "id") .. "] #FFFFFF" .. getPlayerName(source) .. ": " .. msg, player, _, _, _, true)
        end
        triggerClientEvent(root, "admin:addText", root, "LOCAL> " .. getPlayerName(source) .. "(" .. getElementData(source, "id") .. "): " .. msg)
    end
end

local function localCommand(source, cmd, ...)
    local text = table.concat({...}, ' ')
    if not text then
        return
    end
    local msg = table.concat({...}, " ")
    local x, y, z = getElementPosition(source)
    local sphere = createColSphere(x, y, z, 30)
    local players = getElementsWithinColShape(sphere, 'player')
    destroyElement(sphere)
    for _, player in ipairs(players) do
        outputChatBox("* " .. getPlayerName(source) .. " " .. msg, player, 255, 51, 102)
    end
end

local function showPlayerVehicles(plr, cmd)
    local uid = getElementData(plr, 'player:uid')
    if not uid then
        return
    end
    outputChatBox('* Twoje pojazdy (zrespione na mapie): ', plr)
    outputChatBox('====================================', plr)
    local vehicles = getElementsByType('vehicle')
    for _, vehicle in ipairs(vehicles) do
        if getElementData(vehicle, 'vehicle:ownedPlayer') and getElementData(vehicle, 'vehicle:ownedPlayer') == uid then
            outputChatBox("* Nazwa: " .. getVehicleNameFromModel(getElementModel(vehicle)) .. ", ID: " .. getElementData(vehicle, "vehicle:id"), plr)
        end
    end
end

addEventHandler('onPlayerChat', root, function(msg, type)
    localChat(source, msg, type)
end)

addCommandHandler('do', localCommand)

addCommandHandler('vmoje', showPlayerVehicles)
