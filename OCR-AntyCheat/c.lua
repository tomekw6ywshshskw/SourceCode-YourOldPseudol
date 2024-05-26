function requestMoney(amount)
    triggerServerEvent("clientRequestMoney", resourceRoot, amount)
end

function requestHealth(health)
    triggerServerEvent("clientRequestHealth", resourceRoot, health)
end

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
