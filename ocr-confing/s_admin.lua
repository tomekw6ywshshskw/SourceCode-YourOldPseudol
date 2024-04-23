
local ranks = {
    ["support"] = {
        name = "Support",
        color = {
            hex = "#01bf34",
            rgb = tocolor(1, 191, 52),
        },
        index = 1,
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
        },
    },
    ["moderator"] = {
        name = "Moderator",
        color = {
            hex = "#FF0000",
            rgb = tocolor(255, 0, 0),
        },
        index = 2,
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
        },
    },
    ["administrator"] = {
        name = "Administrator",
        color = {
            hex = "#a31303",
            rgb = tocolor(163, 19, 3),
        },
        index = 3,
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["rapsy"] = true,
        },
    },
    ["administrator_root"] = {
        name = "Administrator root",
        color = {
            hex = "#FF007F",
            rgb = tocolor(255, 0, 127),
        },
        index = 4,
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["rapsy"] = true,
            ["cl"] = true,
        },
    },
    ["opiekun_administracji"] = {
        name = "Opiekun administracji",
        color = {
            hex = "#0000FF",
            rgb = tocolor(0, 0, 255),
        },
        index = 5,
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["rapsy"] = true,
            ["cl"] = true,
        },
    },
    ["zarzad"] = {
        name = "Zarząd",
        color = {
            hex = "#FFFF00",
            rgb = tocolor(255, 255, 0),
        },
        index = 6,
        permissions = {
            ["admins"] = true,
            ["duty"] = true,
            ["ucho"] = true,
            ["rapsy"] = true,
            ["cl"] = true,
        },
    },
}

function isPlayerInRank(player, rank)
    local playerRank
    if getElementData(player, "player:level") then
        playerRank = getElementData(player, "player:level")
    else
        return false
    end

    if ranks[playerRank] and ranks[rank] then
        local playerRankIndex = ranks[playerRank].index
        local rankIndex = ranks[rank].index
        return playerRankIndex >= rankIndex
    else
        return false
    end
end

function cmd_admins(plr)
    if not isPlayerInRank(plr, "support") then
        outputChatBox("* You do not have permissions.", plr, 255, 0, 0)
        return
    end

    -- Logika dla komendy /admins
end
addCommandHandler("admins", cmd_admins)

function cmd_duty(plr)
    if not isPlayerInRank(plr, "support") then
        outputChatBox("* You do not have permissions.", plr, 255, 0, 0)
        return
    end

    -- Logika dla komendy /duty
end
addCommandHandler("duty", cmd_duty)

function cmd_ucho(plr)
    if not isPlayerInRank(plr, "moderator") then
        outputChatBox("* You do not have permissions.", plr, 255, 0, 0)
        return
    end

    local x = getElementData(plr, "player:ucho")
    setElementData(plr, "player:ucho", not x)
end
addCommandHandler("ucho", cmd_ucho)

function cmd_rapsy(plr, cmd, uid)
    if not isPlayerInRank(plr, "administrator") and not isPlayerInRank(plr, "administrator_root") and not isPlayerInRank(plr, "opiekun_administracji") and not isPlayerInRank(plr, "zarzad") then
        outputChatBox("* You do not have permissions.", plr, 255, 0, 0)
        return
    end

    -- Logika dla komendy /rapsy
end
addCommandHandler("rapsy", cmd_rapsy)

function cmd_cl(plr, cmd, id, ...)
    if not isPlayerInRank(plr, "administrator_root") and not isPlayerInRank(plr, "zarzad") then
        outputChatBox("* You do not have permissions.", plr, 255, 0, 0)
        return
    end

    -- Logika dla komendy /cl
end
addCommandHandler("cl", cmd_cl)

