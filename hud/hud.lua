--[[
autor:TwojStary(mlody hill)
w raie problemów pisz mlody.hill@interia.pl
--]]

local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted" }
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	for _, component in ipairs( components ) do
		setPlayerHudComponentVisible( component, false )
	end
end)

local screenWidth, screenHeight = guiGetScreenSize()
local x, y = (screenWidth / 1980), (screenHeight / 1080) -- Współczynniki skalowania

local hudVisible = true

-- Funkcja formatująca liczby
local function formatNumber(number)
    local formattedNumber = tostring(number)
    local formattedString = ""
    local length = string.len(formattedNumber)
    for i = 1, length do
        if (i % 3 == 1) and (i ~= 1) then
            formattedString = "," .. formattedString
        end
        formattedString = string.sub(formattedNumber, length - i + 1, length - i + 1) .. formattedString
    end
    return formattedString
end

function drawHUD()
    local player = getLocalPlayer()
    if not player then return end

    local playerName = getPlayerName(player)
    local playerSrp = getElementData(player, "player:reputation") or 0
    local playerHealth = getElementHealth(player)
    local playerMoney = getPlayerMoney(player)
    local formattedMoney = formatNumber(playerMoney) -- Formatowanie ilości pieniędzy

    dxDrawRectangle(screenWidth - (200 * x), 0, 200 * x, 15 * y, tocolor(255, 0, 0, 150)) -- Pasek HP czerwony

    dxDrawText("Nick: " .. playerName .. " | SRP: " .. playerSrp, screenWidth - (190 * x), 20 * y, screenWidth, screenHeight, tocolor(255, 255, 255), 1, "default-bold", "left", "top")
    dxDrawText("$:" .. formattedMoney, screenWidth - (190 * x), 40 * y, screenWidth, screenHeight, tocolor(255, 255, 255), 1, "default-bold", "left", "top")
end

local function toggleHUD(key, state)
    if key == "F7" and state == "down" then
        hudVisible = not hudVisible
    end
end
bindKey("F7", "down", toggleHUD)

local function renderHUD()
    if hudVisible then
        drawHUD()
    end
end
addEventHandler("onClientRender", root, renderHUD)