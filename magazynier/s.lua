local pickupMarker
local deliveryMarker

-- Marker rozpoczęcia pracy
local jobStartMarker = createMarker(950, 1000, 10, "cylinder", 2.0, 255, 255, 0, 150)
local jobStartBlip = createBlip(950, 1000, 10, 41)

-- Funkcja rozpoczynania pracy
function startJob(player)
    triggerClientEvent(player, "showJobGUI", player)
end
addEventHandler("onMarkerHit", jobStartMarker, startJob)

-- Funkcja uruchamiająca pracę magazyniera
function initiateWarehouseJob(player)
    if not getElementData(player, "onWarehouseJob") then
        setElementData(player, "onWarehouseJob", true)
        outputChatBox("Rozpocząłeś pracę magazyniera! Odbierz paczkę z wyznaczonego miejsca.", player)

        pickupMarker = createMarker(1000, 1000, 10, "cylinder", 2.0, 0, 255, 0, 150)
        addEventHandler("onMarkerHit", pickupMarker, givePackage)
        triggerClientEvent(player, "updateMarkers", player, "pickup")
    else
        outputChatBox("Już pracujesz jako magazynier!", player)
    end
end
addEvent("startWarehouseJob", true)
addEventHandler("startWarehouseJob", root, initiateWarehouseJob)

-- Funkcja przydzielania paczki
function givePackage(player)
    if getElementType(player) == "player" and getElementData(player, "onWarehouseJob") and not getElementData(player, "hasPackage") then
        setElementData(player, "hasPackage", true)
        outputChatBox("Odebrałeś paczkę! Dostarcz ją do wyznaczonego miejsca.", player)

        deliveryMarker = createMarker(1020, 1000, 10, "cylinder", 2.0, 0, 0, 255, 150)
        addEventHandler("onMarkerHit", deliveryMarker, deliverPackage)
        triggerClientEvent(player, "updateMarkers", player, "delivery")
    end
end

-- Funkcja dostarczania paczki
function deliverPackage(player)
    if getElementType(player) == "player" and getElementData(player, "hasPackage") then
        setElementData(player, "hasPackage", false)
        givePlayerMoney(player, 500)
        outputChatBox("Dostarczyłeś paczkę i otrzymałeś $500!", player)

        destroyElement(deliveryMarker)
        triggerClientEvent(player, "updateMarkers", player, "none")
    end
end

-- Funkcja kończenia pracy
function endJob(player)
    if getElementData(player, "onWarehouseJob") then
        setElementData(player, "onWarehouseJob", false)
        setElementData(player, "hasPackage", false)
        outputChatBox("Zakończyłeś pracę magazyniera.", player)

        if isElement(pickupMarker) then
            destroyElement(pickupMarker)
        end
        if isElement(deliveryMarker) then
            destroyElement(deliveryMarker)
        end

        triggerClientEvent(player, "updateMarkers", player, "none")
    end
end
addEvent("endWarehouseJob", true)
addEventHandler("endWarehouseJob", root, endJob)
