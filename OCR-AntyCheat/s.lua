
local authorizedScripts = {
    ["NazwaSkryptu"] = true,
}

local function isScriptAuthorized(scriptName)
    return authorizedScripts[scriptName] ~= nil
end

local originalGivePlayerMoney = givePlayerMoney
givePlayerMoney = function(player, amount)
    secureGivePlayerMoney(player, amount, "directCall")
end

function secureGivePlayerMoney(player, amount, scriptName)
    if not isScriptAuthorized(scriptName) then
        outputChatBox("Unauthorized script: " .. scriptName, player)
        cancelEvent()
        return
    end
    originalGivePlayerMoney(player, amount)
end

local originalSetElementHealth = setElementHealth
setElementHealth = function(element, health)
    secureSetElementHealth(element, health, "directCall")
end

function secureSetElementHealth(element, health, scriptName)
    if not isScriptAuthorized(scriptName) then
        outputChatBox("Unauthorized script: " .. scriptName, element)
        cancelEvent()
        return
    end
    originalSetElementHealth(element, health)
end

function checkPlayerState(player)
    local health = getElementHealth(player)
    if health > 100 then
        outputChatBox("Suspicious activity detected: Health value out of range.", player)
        setElementHealth(player, 100)
    end
    
    local money = getPlayerMoney(player)
    if money > 1000000 then
        outputChatBox("Suspicious activity detected: Money value out of range.", player)
        setPlayerMoney(player, 0)
    end
end

addEventHandler("onPlayerDamage", getRootElement(), function()
    checkPlayerState(source)
end)

addEventHandler("onPlayerMoneyChange", getRootElement(), function()
    checkPlayerState(source)
end)

addEvent("clientRequestMoney", true)
addEventHandler("clientRequestMoney", resourceRoot, function(amount)
    secureGivePlayerMoney(client, amount, "clientRequest")
end)

addEvent("clientRequestHealth", true)
addEventHandler("clientRequestHealth", resourceRoot, function(health)
    secureSetElementHealth(client, health, "clientRequest")
end)
