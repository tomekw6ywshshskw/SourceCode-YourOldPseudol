-- Funkcja do zapisywania danych gracza
local function savePlayerData(plr)
    if not isElement(plr) or getElementType(plr) ~= "player" then return end

    -- Pobieranie danych gracza
    local uid = getElementData(plr, "player:uid")
    if not uid then return end
    local money = getPlayerMoney(plr)
    local mandate = getElementData(plr, "player:mandate")
    local licensea = getElementData(plr, "player:license:pjA")
    local licenseb = getElementData(plr, "player:license:pjB")
    local licensec = getElementData(plr, "player:license:pjC")
    local licensel = getElementData(plr, "player:license:pjL")
    local reputation = getElementData(plr, "player:reputation")
    local worker = getElementData(plr, "player:workinjob")
    local hours = tonumber(getElementData(plr, "player:hours")) or 0

    -- Zapisywanie danych gracza do bazy danych MySQL
    local query = exports["ogrpg-db"]:dbSet("UPDATE ogrpg_users SET money=?, reputation=?, mandate=?, pjA=?, pjB=?, pjC=?, pjL=?, worker=?, hours=? WHERE id=?",
        money, reputation, mandate, licensea, licenseb, licensec, licensel, worker, hours, uid
    )

    -- Wyświetlanie komunikatu debugowania
    outputDebugString("Dane gracza zostały zapisane do bazy danych.")
end

-- Funkcja do ładowania danych gracza
local function loadPlayerData(plr)
    if not isElement(plr) or getElementType(plr) ~= "player" then return end

    -- Pobieranie danych gracza z bazy danych MySQL
    local uid = getElementData(plr, "player:uid")
    if not uid then return end
    local query = exports["ogrpg-db"]:dbGet("SELECT * FROM ogrpg_users WHERE id=?", uid)
    if not query then return end
    local result = dbPoll(query, -1)
    if not result or #result ~= 1 then return end

    -- Ustawianie danych gracza
    local data = result[1]
    setPlayerMoney(plr, data.money)
    setElementModel(plr, data.skin)
    setElementData(plr, "status", "Aktywny")
    setElementData(plr, "player:logged", true)
    setElementData(plr, "player:mandate", data.mandate)
    setElementData(plr, "player:license:pjA", data.pjA)
    setElementData(plr, "player:license:pjB", data.pjB)
    setElementData(plr, "player:license:pjC", data.pjC)
    setElementData(plr, "player:license:pjL", data.pjL)
    setElementData(plr, "player:reputation", data.reputation)
    setElementData(plr, "player:workinjob", data.worker)
    setElementData(plr, "player:registerdate", data.registered)
    setElementData(plr, "player:hours", data.hours)

    -- Wyświetlanie komunikatu debugowania
    outputDebugString("Dane gracza zostały załadowane.")
end

-- Obsługa zdarzenia onPlayerQuit
addEventHandler("onPlayerQuit", root, function()
    savePlayerData(source)
end)

-- Obsługa zdarzenia onPlayerLogin
addEventHandler("onPlayerLogin", root, function()
    loadPlayerData(source)
end)