-- Lista autoryzowanych funkcji i ich wywołań
local authorizedFunctions = {
    ["givePlayerMoney"] = true,
    ["setElementHealth"] = true,
    -- Dodaj tutaj inne funkcje, które mają być autoryzowane
}

-- Funkcja sprawdzająca, czy wywołanie funkcji jest autoryzowane
local function isFunctionAuthorized(funcName)
    return authorizedFunctions[funcName] ~= nil
end

-- Nadpisanie funkcji w celu weryfikacji autoryzacji
local originalGivePlayerMoney = givePlayerMoney
givePlayerMoney = function(player, amount)
    if not isFunctionAuthorized("givePlayerMoney") then
        outputChatBox("Unauthorized function call: givePlayerMoney", player)
        cancelEvent()
        return
    end
    originalGivePlayerMoney(player, amount)
end

local originalSetElementHealth = setElementHealth
setElementHealth = function(element, health)
    if not isFunctionAuthorized("setElementHealth") then
        outputChatBox("Unauthorized function call: setElementHealth", element)
        cancelEvent()
        return
    end
    originalSetElementHealth(element, health)
end

-- Funkcja sprawdzająca stan gracza
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

-- Dodanie event handlera monitorującego zmiany stanu gracza
addEventHandler("onPlayerDamage", getRootElement(), function()
    checkPlayerState(source)
end)

addEventHandler("onPlayerMoneyChange", getRootElement(), function()
    checkPlayerState(source)
end)

-- Lista autoryzowanych skryptów
local authorizedScripts = {
    ["trustedScript1.lua"] = true,
    ["trustedScript2.lua"] = true,
    -- Dodaj tutaj inne autoryzowane skrypty
}

-- Funkcja sprawdzająca, czy skrypt jest autoryzowany
function isScriptAuthorized(scriptName)
    return authorizedScripts[scriptName] ~= nil
end

-- Przykład wywołania funkcji z białej listy
function secureGivePlayerMoney(player, amount, scriptName)
    if not isScriptAuthorized(scriptName) then
        outputChatBox("Unauthorized script: " .. scriptName, player)
        cancelEvent()
        return
    end
    givePlayerMoney(player, amount)
end

function secureSetElementHealth(element, health, scriptName)
    if not isScriptAuthorized(scriptName) then
        outputChatBox("Unauthorized script: " .. scriptName, element)
        cancelEvent()
        return
    end
    setElementHealth(element, health)
end

-- Obsługa komunikacji z klientem
addEvent("clientRequestMoney", true)
addEventHandler("clientRequestMoney", resourceRoot, function(amount)
    secureGivePlayerMoney(client, amount, "clientRequest")
end)

addEvent("clientRequestHealth", true)
addEventHandler("clientRequestHealth", resourceRoot, function(health)
    secureSetElementHealth(client, health, "clientRequest")
end)
