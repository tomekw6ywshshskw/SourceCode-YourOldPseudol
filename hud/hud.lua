local HUD = {}

local screenWidth, screenHeight = guiGetScreenSize()
local x, y = (screenWidth / 1980), (screenHeight / 1080)

function HUD:init()
  self.show = true
  self.func = {}
  self.func.turnOff = function() self:hideComponents() end
  self.func.render = function() self:draw() end
  
  addEventHandler("onClientRender",root,self.func.render)
  addEventHandler("onClientResourceStart",resourceRoot,self.func.turnOff)
end

function HUD:formatNumber(number)
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

function HUD:setVariables()
  local player = localPlayer
  self.playerSrp = getElementData(player, "player:reputation") or 0
  self.playerMoney = getPlayerMoney(player)
  self.formattedMoney = formatNumber(playerMoney) -- Formatowanie ilości pieniędzy
  self.playerName = getPlayerName(player)
  self.plainlayerName = playerName:gsub("#%x%x%x%x%x%x", "")
  self.maxHealth = 100
  self.playerHealth = getElementHealth(player)
  self.healthPercentage = playerHealth / maxHealth
  self.barWidth = 200 * x * healthPercentage 
end

function HUD:draw()
  self:setVariables()
  dxDrawRectangle(screenWidth - (200 * x), 0, self.barWidth, 15 * y, tocolor(255, 0, 0, 150)) -- Pasek HP czerwony
  dxDrawText("Nick: " .. self.plainPlayerName .. " | SRP: " .. self.playerSrp, screenWidth - (190 * x), 20 * y, screenWidth, screenHeight, tocolor(255, 255, 255), 1, "default-bold", "left", "top")
  dxDrawText("$ " .. self.formattedMoney, screenWidth - (190 * x), 40 * y, screenWidth, screenHeight, tocolor(255, 255, 255), 1, "default-bold", "left", "top")
end

function HUD:hideComponents()
  local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted" }
  for _,v in pairs(components) do
    setPlayerHudComponentVisible( v, false )
  end
end

function HUD:toggleHUD(state)
  if state then
    addEventHandler("onClientRender",root,self.func.render)
  else
    removeEventHandler("onClientRender",root,self.func.render)
  end
end

HUD:init()

--DLA EXPORTU
function showHUD(state)
  HUD:toggleHUD(state)
end
