local pickupMarker
local deliveryMarker

-- Marker rozpoczęcia pracy
local jobStartMarker = createMarker(950, 1000, 10, "cylinder", 2.0, 255, 255, 0, 150)
local jobStartBlip = createBlip(950, 1000, 10, 41)

-- Funkcja rozpoczynania pracy
function startJob(player)
    if getElementType(player) == "player" then
        triggerClientEvent(player, "showJobGUI", player)
    end
end
addEventHandler("onMarkerHit", jobStartMarker, startJob)

-- Funkcja uruchamiająca pracę magazyniera
function initiateWarehouseJob(player)
    if getElementType(player) == "player" and not getElementData(player, "onWarehouseJob") then
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
function givePackage(hitElement)
    if getElementType(hitElement) == "player" and getElementData(hitElement, "onWarehouseJob") and not getElementData(hitElement, "hasPackage") then
        setElementData(hitElement, "hasPackage", true)
        outputChatBox("Odebrałeś paczkę! Dostarcz ją do wyznaczonego miejsca.", hitElement)

        deliveryMarker = createMarker(1020, 1000, 10, "cylinder", 2.0, 0, 0, 255, 150)
        addEventHandler("onMarkerHit", deliveryMarker, deliverPackage)
        triggerClientEvent(hitElement, "updateMarkers", hitElement, "delivery")
    end
end

-- Funkcja dostarczania paczki
function deliverPackage(hitElement)
    if getElementType(hitElement) == "player" and getElementData(hitElement, "hasPackage") then
        setElementData(hitElement, "hasPackage", false)
        givePlayerMoney(hitElement, 500)
        outputChatBox("Dostarczyłeś paczkę i otrzymałeś $500!", hitElement)

        if isElement(deliveryMarker) then
            destroyElement(deliveryMarker)
        end
        triggerClientEvent(hitElement, "updateMarkers", hitElement, "none")
    end
end

-- Funkcja kończenia pracy
function endJob(player)
    if getElementType(player) == "player" and getElementData(player, "onWarehouseJob") then
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
