local screenW, screenH = guiGetScreenSize()
local showGUI = false

-- Rysowanie GUI
function drawJobGUI()
    if showGUI then
        dxDrawRectangle(screenW * 0.4, screenH * 0.4, screenW * 0.2, screenH * 0.2, tocolor(0, 0, 0, 200))
        dxDrawText("Rozpocznij pracę", screenW * 0.4, screenH * 0.4, screenW * 0.6, screenH * 0.45, tocolor(255, 255, 255, 255), 1.5, "default-bold", "center", "center")
        dxDrawText("Zakończ pracę", screenW * 0.4, screenH * 0.55, screenW * 0.6, screenH * 0.6, tocolor(255, 255, 255, 255), 1.5, "default-bold", "center", "center")
    end
end
addEventHandler("onClientRender", root, drawJobGUI)

-- Pokazywanie GUI
function showJobGUI()
    showGUI = true
    showCursor(true)
end
addEvent("showJobGUI", true)
addEventHandler("showJobGUI", root, showJobGUI)

-- Ukrywanie GUI
function hideJobGUI()
    showGUI = false
    showCursor(false)
end

-- Obsługa kliknięć w GUI
function onClick(button, state)
    if button == "left" and state == "up" and showGUI then
        local mouseX, mouseY = getCursorPosition()
        mouseX, mouseY = mouseX * screenW, mouseY * screenH

        if mouseX >= screenW * 0.4 and mouseX <= screenW * 0.6 then
            if mouseY >= screenH * 0.4 and mouseY <= screenH * 0.45 then
                triggerServerEvent("startWarehouseJob", localPlayer)
                hideJobGUI()
            elseif mouseY >= screenH * 0.55 and mouseY <= screenH * 0.6 then
                triggerServerEvent("endWarehouseJob", localPlayer)
                hideJobGUI()
            end
        end
    end
end
addEventHandler("onClientClick", root, onClick)

-- Aktualizacja markerów
function updateMarkers(stage)
    if stage == "pickup" then
        pickupBlip = createBlip(1000, 1000, 10, 41)
    elseif stage == "delivery" then
        if isElement(pickupBlip) then
            destroyElement(pickupBlip)
        end
        deliveryBlip = createBlip(1020, 1000, 10, 41)
    elseif stage == "none" then
        if isElement(pickupBlip) then
            destroyElement(pickupBlip)
        end
        if isElement(deliveryBlip) then
            destroyElement(deliveryBlip)
        end
    end
end
addEvent("updateMarkers", true)
addEventHandler("updateMarkers", root, updateMarkers)

-- Dodanie paczki do rąk gracza
function attachPackage(player)
    if getElementData(player, "hasPackage") then
        local package = createObject(1550, 0, 0, 0)  -- Przykładowy model paczki
        attachElements(package, player, 0, 0, 0.5)
    end
end
addEventHandler("onClientRender", root, function() attachPackage(localPlayer) end)
