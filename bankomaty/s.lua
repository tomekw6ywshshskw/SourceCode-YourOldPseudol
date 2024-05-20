addEvent("onPlayerDepositMoney", true)
addEventHandler("onPlayerDepositMoney", resourceRoot, function(amount)
    local playerMoney = getPlayerMoney(source)
    if playerMoney >= amount then
        takePlayerMoney(source, amount)
        -- Zakładam, że masz funkcję addBankMoney(player, amount)
        addBankMoney(source, amount)
        outputChatBox("Wpłacono " .. amount .. " PLN na konto bankowe.", source)
    else
        outputChatBox("Nie masz wystarczająco dużo pieniędzy.", source)
    end
end)

addEvent("onPlayerWithdrawMoney", true)
addEventHandler("onPlayerWithdrawMoney", resourceRoot, function(amount)
    local bankMoney = getBankMoney(source)
    if bankMoney >= amount then
        givePlayerMoney(source, amount)
        -- Zakładam, że masz funkcję removeBankMoney(player, amount)
        removeBankMoney(source, amount)
        outputChatBox("Wypłacono " .. amount .. " PLN z konta bankowego.", source)
    else
        outputChatBox("Nie masz wystarczająco dużo pieniędzy na koncie.", source)
    end
end)

function getBankMoney(player)
    -- Pobierz pieniądze z konta bankowego gracza z bazy danych lub innego miejsca
    -- Na przykład:
    return getElementData(player, "bank_money") or 0
end

function addBankMoney(player, amount)
    -- Dodaj pieniądze do konta bankowego gracza
    -- Na przykład:
    local currentMoney = getBankMoney(player)
    setElementData(player, "bank_money", currentMoney + amount)
end

function removeBankMoney(player, amount)
    -- Usuń pieniądze z konta bankowego gracza
    -- Na przykład:
    local currentMoney = getBankMoney(player)
    setElementData(player, "bank_money", currentMoney - amount)
end
