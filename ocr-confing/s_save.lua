local function savePlayerData(plr)
    if not isElement(plr) or getElementType(plr) ~= "player" then return end

  
    local uid = getElementData(plr, "player:uid")
    if not uid then return end
    local data = {
        money = getPlayerMoney(plr),
        bank_money = getElementData(plr, "player:bank_money"),
        skin = getElementModel(plr),
        weave = getElementData(plr, "player:weave"),
        ocrPoints = getElementData(plr, "player:ocrPoints"),
        category = getElementData(plr, "player:category"),
        worker = getElementData(plr, "player:worker"),
        hours = tonumber(getElementData(plr, "player:hours")) or 0,
        mandate = getElementData(plr, "player:mandate"),
        register_serial = getElementData(plr, "player:register_serial"),
        jail = getElementData(plr, "player:jail"),
        keys = getElementData(plr, "player:keys")
    }
  
    local query = exports["db-connect"]:dbSet("UPDATE OCR_players SET money=?, bank_money=?, skin=?, weave=?, ocrPoints=?, category=?, worker=?, hours=?, mandate=?, register_serial=?, jail=?, keys=? WHERE id=?",
        data.money, data.bank_money, data.skin, data.weave, data.ocrPoints, data.category, data.worker, data.hours, data.mandate, data.register_serial, data.jail, data.keys, uid
    )

  
    outputDebugString("Dane gracza zostały zapisane do bazy danych.")
end


local function loadPlayerData(plr)
    if not isElement(plr) or getElementType(plr) ~= "player" then return end
  
    local uid = getElementData(plr, "player:uid")
    if not uid then return end
    local query = exports["db-connect"]:dbGet("SELECT * FROM OCR_players WHERE id=?", uid)
    if not query then return end
    local result = dbPoll(query, -1)
    if not result or #result ~= 1 then return end
  
    local data = result[1]
    setPlayerMoney(plr, data.money)
    setElementModel(plr, data.skin)
    setElementData(plr, "player:bank_money", data.bank_money)
    setElementData(plr, "player:weave", data.weave)
    setElementData(plr, "player:ocrPoints", data.ocrPoints)
    setElementData(plr, "player:category", data.category)
    setElementData(plr, "player:worker", data.worker)
    setElementData(plr, "player:hours", data.hours)
    setElementData(plr, "player:mandate", data.mandate)
    setElementData(plr, "player:register_serial", data.register_serial)
    setElementData(plr, "player:jail", data.jail)
    setElementData(plr, "player:keys", data.keys)
  
    outputDebugString("Dane gracza zostały załadowane.")
end

addEventHandler("onPlayerQuit", root, function()
    savePlayerData(source)
end)


addEventHandler("onPlayerLogin", root, function()
    loadPlayerData(source)
end)
