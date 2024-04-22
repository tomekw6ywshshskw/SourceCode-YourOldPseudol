
GUIEditor = {
    button = {},
    window = {},
    label = {},
    edit = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 283) / 2, (screenH - 312) / 2, 283, 312, "Zmiana hasła(F3 wlaczasz kursor!)", false)
        guiWindowSetMovable(GUIEditor.window[1], false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetAlpha(GUIEditor.window[1], 0.94)
        guiSetProperty(GUIEditor.window[1], "CaptionColour", "FF86202A")
        GUIEditor.edit[1] = guiCreateEdit(0.09, 0.18, 0.82, 0.09, "", true, GUIEditor.window[1])
        GUIEditor.edit[2] = guiCreateEdit(0.07, 0.49, 0.82, 0.09, "", true, GUIEditor.window[1])
        GUIEditor.edit[3] = guiCreateEdit(0.07, 0.69, 0.82, 0.09, "", true, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(0.21, 0.09, 0.58, 0.05, "Aktualne Haslo", true, GUIEditor.window[1])
        GUIEditor.label[2] = guiCreateLabel(0.21, 0.41, 0.58, 0.05, "Wpisz nowe hasło", true, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(0.21, 0.61, 0.58, 0.05, "Ponów", true, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(0.15, 0.82, 0.67, 0.13, "Zmien haslo", true, GUIEditor.window[1])    
		guiSetVisible(GUIEditor.window[1], false)
		addEventHandler ( "onClientGUIClick", GUIEditor.button[1], przycisk, false )
    end
)


function przycisk ( button )
    if button == "left" then
        local text = guiGetText ( GUIEditor.edit[1] )
        local text2 = guiGetText ( GUIEditor.edit[2] )
		local text3 = guiGetText ( GUIEditor.edit[3] )
		if text2 ~= text3 then outputChatBox("Nowe hasla nie sa takie same") return end
		guiSetVisible(GUIEditor.window[1], false)
		triggerServerEvent("change:password",localPlayer,text,text2,text3)
    end
end

addCommandHandler("zmianahasla",function()
	if not getElementData(localPlayer,"player:uid") then return end
	guiSetVisible(GUIEditor.window[1], not guiGetVisible(GUIEditor.window[1]))
	guiSetText(GUIEditor.edit[1],"")
	guiSetText(GUIEditor.edit[2],"")
	guiSetText(GUIEditor.edit[3],"")
end)

addCommandHandler("zmienhaslo",function()
	if not getElementData(localPlayer,"player:uid") then return end
	guiSetVisible(GUIEditor.window[1], not guiGetVisible(GUIEditor.window[1]))
	guiSetText(GUIEditor.edit[1],"")
	guiSetText(GUIEditor.edit[2],"")
	guiSetText(GUIEditor.edit[3],"")
end)

addEventHandler( "onClientElementStreamIn", getRootElement( ),
    function ( )
        if getElementType( source ) == "vehicle" then
         triggerServerEvent( "streamIn", source, source, getLocalPlayer() )
        end
    end
)
addEvent( "setElementPosForPl", true )
function setElementPosForPl( element, towed )
   if towed then
   attachTrailerToVehicle(towed, element)
   end
end
addEventHandler( "setElementPosForPl", getRootElement(), setElementPosForPl )

addEventHandler( "onClientElementStreamIn", root,
    function ( )
        if getElementType( source ) == "object" then
			setObjectBreakable(source, false)
		end
end)
addEvent("setBreakable",true)
addEventHandler("setBreakable",root,function(obj)
setObjectBreakable(obj, false)
end)


addEvent("addNotification",true)
addEventHandler("addNotification",root,function(tekst,typ)
if not tekst then return end
if not typ then return end
outputChatBox(tekst)
end)

addEvent("addNotificatione",true)
addEventHandler("addNotificatione",root,function(tekst,typ)
if not tekst then return end
if not typ then return end
exports['notices']:addNotification(tekst,typ)
end)


function stopMinigunDamage ( attacker, weapon, bodypart )
	if ( weapon == 0 ) then 
		cancelEvent()
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopMinigunDamage )

function nodamage(attacker, bodypart)
	if not attacker then return end
	if getElementType(attacker) == 'vehicle' then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", getLocalPlayer(),nodamage)

function blokada ( prevSlot, newSlot )
	if getPedWeapon(getLocalPlayer(),newSlot) == 0 and getElementData(getLocalPlayer(),"player:admin") == true then 
		toggleControl ( "fire", true )
		toggleControl("aim_weapon", true)
	elseif getPedWeapon(getLocalPlayer(),newSlot) == 7 then
		toggleControl ("fire", false ) 
		toggleControl("aim_weapon", false)
		return false
	elseif getPedWeapon(getLocalPlayer(),newSlot) ~= 0 and  getPedWeapon(getLocalPlayer(),newSlot) ~= 22 then
		toggleControl ("fire", true ) 
		toggleControl("aim_weapon", true)
	elseif getPedWeapon(getLocalPlayer(),newSlot) == 22 and getElementData(getLocalPlayer(),"player:admin") == true then
		toggleControl ("fire", false ) 
		toggleControl("aim_weapon", true)
	elseif getPedWeapon(getLocalPlayer(),newSlot) == 22 and getElementData(getLocalPlayer(),"player:admin") == false then
		toggleControl ("fire", true ) 
		toggleControl("aim_weapon", true)
	else
		toggleControl ( "fire", false ) 
		toggleControl("aim_weapon", false)
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), blokada )

setTimer(function()
local czas=tonumber(getElementData(localPlayer, "player:online"))
if not czas then return end
setElementData(localPlayer, "player:online", czas+1)
end, 60000, 0)

addEvent("core:blipyaut", true)
addEventHandler("core:blipyaut", root, function(plr)
if plr ~= localPlayer then return end
local uid=getElementData(plr,"player:uid")
for id, veh in ipairs( getElementsByType ( "vehicle" ) ) do
if uid == getElementData(veh,"vehicle:ownedPlayer") then
createBlipAttachedTo(veh,0,0,5000,0,0.3,0,255,0,255,1,99999)
end
end
end)
function destroyBlipsAttachedTo(elemente)
	local attached = getAttachedElements ( elemente )
	if ( attached ) then
		for k,element in ipairs(attached) do
			if getElementType ( element ) == "blip" then
				destroyElement ( element )
			end
		end
	end
end
function veh_blips()
    for i,v in pairs(getElementsByType("vehicle")) do
        if getElementData(v,"vehicle:spawn") == true then
            if getElementData(v,"vehicle:ownedPlayer") == getElementData(localPlayer,"player:uid") then
				createBlipAttachedTo(v,0,1,255,0,0,255,1,9999)
            end
			local rent = getElementData(v,"vehicle:rent")
			if rent and (type(rent) == "table") then
				for i,s in pairs(rent) do
					if tonumber(s) == getElementData(localPlayer,"player:uid") then
						createBlipAttachedTo(v,0,1,0,0,255,255,1,9999)
					end
				end
			end
        end
    end
end
setTimer(veh_blips,10000,0)
addEventHandler("onClientElementDestroy", root, function ()
	if getElementType(source) == "vehicle" then
	destroyBlipsAttachedTo(source)
	end
end)
addEventHandler ( "onClientElementDataChange", root,
function ( dataName )
	if getElementType ( source ) == "vehicle" and dataName == "vehicle:ownedPlayer" then
		destroyBlipsAttachedTo(source)
	end
	if getElementType ( source ) == "vehicle" and dataName == "vehicle:rent" then
		destroyBlipsAttachedTo(source)
	end
end )