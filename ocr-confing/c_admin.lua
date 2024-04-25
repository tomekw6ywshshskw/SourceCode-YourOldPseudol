local function streamInHandler(element)
    local elementType = getElementType(element)
    if elementType == "vehicle" then
        triggerServerEvent("streamIn", element, element, localPlayer)
    elseif elementType == "object" then
        setObjectBreakable(element, false)
    end
end
addEventHandler("onClientElementStreamIn", root, streamInHandler)

local function setBreakableHandler(obj)
    setObjectBreakable(obj, false)
end
addEvent("setBreakable", true)
addEventHandler("setBreakable", root, setBreakableHandler)

local function addNotificationHandler(tekst, typ)
    if tekst then
        outputChatBox(tekst)
    end
end
addEvent("addNotification", true)
addEventHandler("addNotification", root, addNotificationHandler)

local function addNotificationeHandler(tekst, typ)
    if tekst then
        exports['notices']:addNotification(tekst, typ)
    end
end
addEvent("addNotificatione", true)
addEventHandler("addNotificatione", root, addNotificationeHandler)

local function stopMinigunDamage(attacker, weapon, bodypart)
    if weapon == 0 then
        cancelEvent()
    end
end
addEventHandler("onClientPlayerDamage", localPlayer, stopMinigunDamage)

local function nodamage(attacker, bodypart)
    if attacker and getElementType(attacker) == 'vehicle' then
        cancelEvent()
    end
end
addEventHandler("onClientPlayerDamage", localPlayer, nodamage)

local function blokada(prevSlot, newSlot)
    local pedWeapon = getPedWeapon(localPlayer, newSlot)
    local isAdmin = getElementData(localPlayer, "player:admin") == true
    toggleControl("fire", not (pedWeapon == 0 and isAdmin) and pedWeapon ~= 7 and pedWeapon ~= 22)
    toggleControl("aim_weapon", not (pedWeapon == 0 and isAdmin))
end
addEventHandler("onClientPlayerWeaponSwitch", root, blokada)

setTimer(function()
    local czas = tonumber(getElementData(localPlayer, "player:online"))
    if czas then
        setElementData(localPlayer, "player:online", czas + 1)
    end
end, 60000, 0)

local function coreBlipyautHandler(plr)
    if plr == localPlayer then
        local uid = getElementData(plr, "player:uid")
        for id, veh in ipairs(getElementsByType("vehicle")) do
            if uid == getElementData(veh, "vehicle:ownedPlayer") then
                createBlipAttachedTo(veh, 0, 0, 5000, 0, 0.3, 0, 255, 0, 255, 1, 99999)
            end
        end
    end
end
addEvent("core:blipyaut", true)
addEventHandler("core:blipyaut", root, coreBlipyautHandler)

local function destroyBlipsAttachedTo(elemente)
    local attached = getAttachedElements(elemente)
    if attached then
        for k, element in ipairs(attached) do
            if getElementType(element) == "blip" then
                destroyElement(element)
            end
        end
    end
end

local function vehBlips()
    for i, v in pairs(getElementsByType("vehicle")) do
        if getElementData(v, "vehicle:spawn") == true then
            local uid = getElementData(localPlayer, "player:uid")
            if getElementData(v, "vehicle:ownedPlayer") == uid then
                createBlipAttachedTo(v, 0, 1, 255, 0, 0, 255, 1, 9999)
            end
            local rent = getElementData(v, "vehicle:rent")
            if rent and type(rent) == "table" then
                for i, s in pairs(rent) do
                    if tonumber(s) == uid then
                        createBlipAttachedTo(v, 0, 1, 0, 0, 255, 255, 1, 9999)
                    end
                end
            end
        end
    end
end
setTimer(vehBlips, 10000, 0)

local function elementDataChangeHandler(dataName)
    local elementType = getElementType(source)
    if elementType == "vehicle" and (dataName == "vehicle:ownedPlayer" or dataName == "vehicle:rent") then
        destroyBlipsAttachedTo(source)
    end
end
addEventHandler("onClientElementDataChange", root, elementDataChangeHandler)

addEventHandler("onClientElementDestroy", root,
    function()
        if getElementType(source) == "vehicle" then
            destroyBlipsAttachedTo(source)
        end
    end
)
