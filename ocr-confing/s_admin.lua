-- Maksymalna liczba logów wyświetlanych na ścianie
local MAX_LOGS = 10  

-- Maksymalna liczba raportów wyświetlanych na ścianie
local MAX_REPORTS = 5  

-- Tablica przechowująca logi
local logs = {}  

-- Tablica przechowująca raporty
local reports = {}  

-- Tablica przechowująca uprawnienia rang
local ranks = {
    ["Support"] = {
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["cl"] = true,
        },
    },
    ["Moderator"] = {
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["cl"] = true,
        },
    },
    ["Administrator"] = {
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["cl"] = true,
        },
    },
    ["Administrator root"] = {
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["cl"] = true,
        },
    },
    ["Opiekun administracji"] = {
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["cl"] = true,
        },
    },
    ["Zarząd"] = {
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["cl"] = true,
        },
    },
}

-- Funkcja sprawdzająca uprawnienia gracza
function hasPermission(playerName, permission)
    local playerRank = getPlayerRank(playerName)
    if not playerRank then
        return false
    end

    local rankPermissions = ranks[playerRank] and ranks[playerRank].permissions
    return rankPermissions and rankPermissions[permission] == true
end

-- Funkcja dodająca log
function addLog(logText)
    table.insert(logs, logText)
    if #logs > MAX_LOGS then
        table.remove(logs, 1)  
    end
    refreshLogsOnWall()
end

-- Funkcja dodająca raport
function addReport(playerName, reportText)
    table.insert(reports, {player = playerName, text = reportText})
    if #reports > MAX_REPORTS then
        table.remove(reports, 1)  
    end
    refreshReportsOnWall()
end

-- Funkcja odświeżająca wyświetlanie logów na ścianie
function refreshLogsOnWall()
    -- Tutaj umieść kod odświeżający wyświetlanie logów na ścianie
end

-- Funkcja odświeżająca wyświetlanie raportów na ścianie
function refreshReportsOnWall()
    -- Tutaj umieść kod odświeżający wyświetlanie raportów na ścianie
end

-- Funkcja do automatycznego odświeżania logów i raportów co sekundę
function refreshData()
    refreshLogsOnWall()
    refreshReportsOnWall()
end
setTimer(refreshData, 1000, 0)

-- Obsługa komendy /report
function cmd_report(player, cmd, targetPlayerName, ...)
    local reportText = table.concat({...}, " ")
    if not reportText or reportText == "" then
        outputChatBox("* Użycie: /report <nick gracza> <treść raportu>", player, 255, 0, 0)
        return
    end

    if not getPlayerFromName(targetPlayerName) then
        outputChatBox("* Podany gracz nie jest online.", player, 255, 0, 0)
        return
    end

    addReport(player, "Gracz " .. player .. " zgłosił gracza " .. targetPlayerName .. ": " .. reportText)
    outputChatBox("* Twój raport został wysłany pomyślnie.", player, 0, 255, 0)
end
addCommandHandler("report", cmd_report)

-- Obsługa komendy /duty
function cmd_duty(player, cmd)
    local playerName = getPlayerName(player)
    if not hasPermission(playerName, "duty") then
        outputChatBox("* Nie masz wystarczających uprawnień.", player, 255, 0, 0)
        return
    end

    -- Logika dla komendy /duty
    local playerDutyStatus = getElementData(player, "player:duty") or false
    if playerDutyStatus then
        outputChatBox("* Zszedłeś z duty.", player, 0, 255, 0)
        setElementData(player, "player:duty", false)
    else
        outputChatBox("* Wszedłeś na duty.", player, 0, 255, 0)
        setElementData(player, "player:duty", true)
    end
end
addCommandHandler("duty", cmd_duty)

-- Obsługa komendy /ucho
function cmd_ucho(player, cmd)
    local playerName = getPlayerName(player)
    if not hasPermission(playerName, "ucho") then
        outputChatBox("* Nie masz wystarczających uprawnień.", player, 255, 0, 0)
        return
    end

    -- Logika dla komendy /ucho
    -- Tutaj umieść kod dla komendy /ucho
end
addCommandHandler("ucho", cmd_ucho)

-- Obsługa komendy /cl
function cmd_cl(player, cmd)
    local playerName = getPlayerName(player)
    if not hasPermission(playerName, "cl") then
        outputChatBox("* Nie masz wystarczających uprawnień.", player, 255, 0, 0)
        return
    end

    -- Logika dla komendy /cl
    -- Tutaj umieść kod dla komendy /cl
end
addCommandHandler("cl", cmd_cl)
