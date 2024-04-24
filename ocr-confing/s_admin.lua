local ranks = {
    ["Support"] = {
        colors = {
            hex = "#ffffff",
            rgb = tocolor(255, 255, 255),
        },
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
        },
    },
    ["Moderator"] = {
        colors = {
            hex = "#FF0000",
            rgb = tocolor(255, 0, 0),
        },
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
        },
    },
    ["Administrator"] = {
        colors = {
            hex = "#a31303",
            rgb = tocolor(163, 19, 3),
        },
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["rapsy"] = true,
        },
    },
    ["Administrator root"] = {
        colors = {
            hex = "#FF007F",
            rgb = tocolor(255, 0, 127),
        },
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["rapsy"] = true,
            ["cl"] = true,
        },
    },
    ["Opiekun administracji"] = {
        colors = {
            hex = "#0000FF",
            rgb = tocolor(0, 0, 255),
        },
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["rapsy"] = true,
            ["cl"] = true,
        },
    },
    ["Zarząd"] = {
        colors = {
            hex = "#FFFF00",
            rgb = tocolor(255, 255, 0),
        },
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["rapsy"] = true,
            ["cl"] = true,
        },
    },
}

function isPlayerInRank(playerName, rank)
    local playerPermissions = ranks[playerName] and ranks[playerName].permissions
    local rankPermissions = ranks[rank] and ranks[rank].permissions
    return playerPermissions and rankPermissions and next(playerPermissions) == next(rankPermissions)
end

function cmd_admins(plr)
    local playerName = getPlayerName(plr)
    if not isPlayerInRank(playerName, "Support") then
        outputChatBox("* Nie masz wystarczających uprawnień.", plr, 255, 0, 0)
        return
    end

    -- Logika dla komendy /admins
end

function cmd_duty(plr)
    local playerName = getPlayerName(plr)
    if not isPlayerInRank(playerName, "Support") then
        outputChatBox("* Nie masz wystarczających uprawnień.", plr, 255, 0, 0)
        return
    end

    -- Logika dla komendy /duty
end

function cmd_ucho(plr)
    local playerName = getPlayerName(plr)
    if not ranks[playerName] or not ranks[playerName].permissions.ucho then
        outputChatBox("* Nie masz wystarczających uprawnień.", plr, 255, 0, 0)
        return
    end

    local x = getElementData(plr, "player:ucho")
    setElementData(plr, "player:ucho", not x)
end

function cmd_rapsy(plr, cmd, uid)
    local playerName = getPlayerName(plr)
    if not ranks[playerName] or not ranks[playerName].permissions.rapsy then
        outputChatBox("* Nie masz wystarczających uprawnień.", plr, 255, 0, 0)
        return
    end

    -- Logika dla komendy /rapsy
end

function cmd_cl(plr, cmd, id, ...)
    local playerName = getPlayerName(plr)
    if not ranks[playerName] or not ranks[playerName].permissions.cl then
        outputChatBox("* Nie masz wystarczających uprawnień.", plr, 255, 0, 0)
        return
    end

    -- Logika dla komendy /cl
end

-- Dodajemy obsługę komend:
addCommandHandler("admins", cmd_admins)
addCommandHandler("duty", cmd_duty)
addCommandHandler("ucho", cmd_ucho)
addCommandHandler("rapsy", cmd_rapsy)
addCommandHandler("cl", cmd_cl)
