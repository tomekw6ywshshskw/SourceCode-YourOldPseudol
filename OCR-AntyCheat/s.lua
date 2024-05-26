local authorizedScripts = {
    ["nazwa skryptu"] = true,
    
}


local function isScriptAuthorized(scriptName)
    return authorizedScripts[scriptName] ~= nil
end

local originalGivePlayerMoney = givePlayerMoney
givePlayerMoney = function(player, amount)
    if not isScriptAuthorized(sourceResourceName) then
        outputChatBox("Unauthorized script: " .. sourceResourceName, player)
        cancelEvent()
        return
    end
    originalGivePlayerMoney(player, amount)
end

local originalSetElementHealth = setElementHealth
setElementHealth = function(element, health)
    if not isScriptAuthorized(sourceResourceName) then
        outputChatBox("Unauthorized script: " .. sourceResourceName, element)
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
