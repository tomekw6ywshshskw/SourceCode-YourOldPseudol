-- Ustawianie bankomatów na mapie
local bankomaty = {
    { x = 1234.56, y = 789.01, z = 12.34 },
    { x = 2345.67, y = 890.12, z = 23.45 },
    -- Dodaj więcej bankomatów w razie potrzeby
}

local bankomatMarkers = {}

for i, pos in ipairs(bankomaty) do
    local marker = createMarker(pos.x, pos.y, pos.z - 1, "cylinder", 1.5, 255, 0, 0, 150)
    table.insert(bankomatMarkers, marker)
end

-- GUI Bankomatu
local kwota = guiCreateEdit(396, 372, 187, 33, "", false)
local depositButton = guiCreateButton(425, 528, 128, 44, "Wpłata", false)
local withdrawButton = guiCreateButton(425, 586, 128, 44, "Wypłata", false)

guiSetVisible(kwota, false)
guiSetVisible(depositButton, false)
guiSetVisible(withdrawButton, false)

local isBankomatGUIVisible = false

function renderBankomatGUI()
    if isBankomatGUIVisible then
        dxDrawRectangle(380, 325, 219, 315, tocolor(37, 34, 34, 117), false)
        dxDrawText("BANKOMAT", 379, 326, 598, 362, tocolor(255, 255, 255, 255), 0.80, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawRectangle(425, 528, 128, 44, tocolor(48, 45, 45, 161), false)
        dxDrawRectangle(425, 586, 128, 44, tocolor(48, 45, 45, 161), false)
        dxDrawText("Wpłata", 424, 528, 553, 572, tocolor(255, 255, 255, 255), 0.80, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Wypłata", 424, 586, 553, 630, tocolor(255, 255, 255, 255), 0.80, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine(380, 362, 599, 362, tocolor(208, 182, 8, 230), 1, false)
        dxDrawText("Stan Konta:", 379, 440, 599, 474, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    end
end

function showBankomatGUI(hitElement)
    if hitElement == localPlayer then
        isBankomatGUIVisible = true
        guiSetVisible(kwota, true)
        guiSetVisible(depositButton, true)
        guiSetVisible(withdrawButton, true)
        addEventHandler("onClientRender", root, renderBankomatGUI)
    end
end

function hideBankomatGUI(hitElement)
    if hitElement == localPlayer then
        isBankomatGUIVisible = false
        guiSetVisible(kwota, false)
        guiSetVisible(depositButton, false)
        guiSetVisible(withdrawButton, false)
        removeEventHandler("onClientRender", root, renderBankomatGUI)
    end
end

for _, marker in ipairs(bankomatMarkers) do
    addEventHandler("onClientMarkerHit", marker, showBankomatGUI)
    addEventHandler("onClientMarkerLeave", marker, hideBankomatGUI)
end

function handleDeposit()
    local amount = tonumber(guiGetText(kwota))
    if amount and amount > 0 then
        triggerServerEvent("onPlayerDepositMoney", resourceRoot, amount)
    else
        outputChatBox("Podaj prawidłową kwotę do wpłaty.")
    end
end

function handleWithdraw()
    local amount = tonumber(guiGetText(kwota))
    if amount and amount > 0 then
        triggerServerEvent("onPlayerWithdrawMoney", resourceRoot, amount)
    else
        outputChatBox("Podaj prawidłową kwotę do wypłaty.")
    end
end

addEventHandler("onClientGUIClick", depositButton, handleDeposit, false)
addEventHandler("onClientGUIClick", withdrawButton, handleWithdraw, false)
