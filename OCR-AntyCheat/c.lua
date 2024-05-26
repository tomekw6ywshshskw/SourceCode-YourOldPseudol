-- Funkcja żądająca dodania pieniędzy
function requestMoney(amount)
    triggerServerEvent("clientRequestMoney", resourceRoot, amount)
end

-- Funkcja żądająca zmiany zdrowia
function requestHealth(health)
    triggerServerEvent("clientRequestHealth", resourceRoot, health)
end

-- Przykład użycia funkcji żądających
addCommandHandler("addmoney", function(cmd, amount)
    amount = tonumber(amount)
    if amount then
        requestMoney(amount)
    else
        outputChatBox("Usage: /addmoney [amount]")
    end
end)

addCommandHandler("sethealth", function(cmd, health)
    health = tonumber(health)
    if health then
        requestHealth(health)
    else
        outputChatBox("Usage: /sethealth [health]")
    end
end)
