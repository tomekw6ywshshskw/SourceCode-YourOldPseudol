--[[
    Resource: OURGame v2
    Developers: Split <split.programista@gmail.com>
    You have no right to use this code without my permission.
    (c) 2015 <split.programista@gmail.com>. All rights reserved.
]]


addEvent("core:spawnPlayer", true)
addEventHandler("core:spawnPlayer", root, function()
	setCameraTarget(source,source)
	local pos=getElementData(source,"player:spawn")
	if not pos then return end
	fadeCamera(source, true)
	spawnPlayer(source, pos[1], pos[2], pos[3])
	toggleControl(source,"fire", false)
	toggleControl(source,"aim_weapon", false)        
	setPlayerArmor(source, 100) 
	local load=loadPlayerData(source)
	if load then 	triggerClientEvent(source,"addNotification",root,"✪ ✪ INFO ✪ ✪ Witaj graczu! Pomyślnie wczytano twoje dane!","info") end
	setElementData( source, 'HS_accountName', getPlayerName(source));
	setElementData(source, "player:online", 0)
	if getElementData(client,"player:premium") then
		local queryA=string.format("SELECT * FROM ogrpg_users WHERE id=%d AND premiumdate>NOW() LIMIT 1", getElementData(client,"player:uid"))
		local resultA=exports["ogrpg-db"]:pobierzWyniki(queryA)
		if (resultA) then
			outputChatBox("✪ ✪ INFO ✪ ✪ Posiadasz ważne konto Premium do: " ..resultA["premiumdate"], client, 255, 255, 255)
		end
		local v2=exports['ogrpg-db']:dbGet('SELECT * FROM ogrpg_users WHERE premiumdate>NOW()')
		for ile,_ in ipairs(v2) do
			ilosc = ile
		end
		outputChatBox("✪ ✪ Aktualnie posiadamy sprzedane "..ilosc.." konta Premium , dziękujemy wam za wsparcie! ✪ ✪", client, 0,162,255)
	end
	triggerClientEvent(client,"core:blipyaut",root,client)
end)

setTimer(function()
	local players=getElementsByType('player')
	for _, p in pairs(players) do
			if getElementData(p, "player:online") and tonumber(getElementData(p, "player:online")) > 15 then
				if getElementData(p, "player:online") == 15 then
					local hour = getElementData(localPlayer,"player:hours") or 0
					setElementData(localPlayer,"player:hours",hour+1)
				end	
				setElementData(p, "player:online", 0)
				if getElementData(p, "player:premium") then
				triggerEvent("givePlayerMoney", p, 1500, false)
				triggerClientEvent(p,"addNotification",root,"★ ★ Premium ★ ★ Otrzymujesz 1500 PLN za przegranie 15 minutek na naszym serwerze :)","info")
			end
		end
 	end
end, 60000, 0)

addEvent("pobierz:parametry",true)
addEventHandler("pobierz:parametry",root,function(tabelka,komu)
	if not komu then return end
		for k, v in pairs( tabelka ) do
			outputChatBox( k .. " : " .. tostring( v ),komu )
		end
end)

addCommandHandler("pobierzparametry",function(plr,cmd,cel)
    local target=findPlayer(plr, cel)
    if not target then
		triggerClientEvent(plr,"addNotification",root,'* Nie znaleziono podanego gracza.',"error")
        return
    end
	triggerClientEvent(target,"pobierz:parametry",root,plr)
end)


addEventHandler("onPlayerWasted", root, function()
	plr=source
	--setTimer(fadeCamera, 300, 1, plr, false)
	if getElementData(plr,"player:job") then
		triggerClientEvent(plr,"onFinish", root, plr)
		setElementData(plr,"player:job", false)
	end
	setTimer(function()
		local pos=getElementData(plr,"player:spawn")
		if not pos then return end
		fadeCamera(plr, true)
		setElementInterior(plr,0)
		setElementDimension(plr,0)
                setPlayerArmor(plr, 100)
		spawnPlayer(plr, pos[1], pos[2], pos[3])
		setCameraTarget(plr, plr)
		setElementModel(plr, getElementData(plr, "player:skin"))
	end, 60, 1)
end)
addEvent("giveSpray", true)
addEvent("takeSpray", true)
addEventHandler("giveSpray", root, function()
	giveWeapon ( source, 41, 200 )
end)

addEventHandler("takeSpray", root, function()
	takeWeapon ( source, 41)
end)

addEventHandler("onPlayerConnect", root, function(playerNick)
	if string.find(playerNick, "#") ~= nil or string.find(playerNick, "?") ~= nil or string.find(playerNick, "!") ~= nil then
		cancelEvent(true,"Twój nick zawiera jeden z niedozwolonych znaków(#,?,!), zmień go.")
	end
end)

addEventHandler("onPlayerConnect", root, function(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber)
    if string.find(playerNick, "#") ~= nil then
        cancelEvent(true, "[Error]Obowiązuje zakaz wchodzenia na serwer z kolorowym nickiem, zmień nick i połącz się ponownie!")
    end
end)

addEventHandler ("onPlayerJoin", root,function()
	local query=string.format("SELECT * FROM ogrpg_ban WHERE type=%q AND active=1 AND serial=%q AND time>NOW() LIMIT 1","ban", getPlayerSerial(source))
	local result=exports["ogrpg-db"]:pobierzWyniki(query)
	if (result) then
		outputConsole("***********************",source)
		outputConsole(string.format("Zostales zbanowany na serwerze! "),source)
		outputConsole(string.format("Posiadasz Bana do "..result["time"]),source)
		outputConsole(string.format("Posiadasz Bana za: "..result["reason"]),source)
		outputConsole("***********************",source)
	kickPlayer(source,string.format("Kliknij F8 aby zobaczyc wiecej informacji!"))
	else
		exports["ogrpg-db"]:dbSet("DELETE FROM ogrpg_ban WHERE type=? AND active=1 AND serial=?", "ban", getPlayerSerial(source))
	end
end)

addEventHandler("onPlayerJoin", root, function()
end)

 function GraczPowitanie()
    local GraczNazwa = getPlayerName ( source )
    outputChatBox ( "#FF8000✦ ✦ Witaj #FFFFFF"..GraczNazwa.." #FF8000na naszym serwerze! ✦ ✦" , source, 255, 255, 255, true)
    outputChatBox ( "✦ Jesteś nowy? wciśnij F1 znajdziesz tam krótki poradnik po serwerze ✦" , source, 255, 255, 255 )
    setElementAlpha(source,255)
end
addEventHandler ( "onPlayerJoin", getRootElement(), GraczPowitanie)


addEventHandler("onResourceStart", resourceRoot, function()
	setWaveHeight(2)
	setMinuteDuration(6000)
    setMapName("RPG")
    setGameType("RPG")
end)


addEventHandler("onPlayerChangeNick", root, function() cancelEvent() end)
addEventHandler("onResourceStart", root, function() 
local players=getElementsByType('player')
for _, p in pairs(players) do
end
end)

setTimer(function()
	local vehicles=getElementsByType('vehicle')
	for _, vehicle in pairs(vehicles) do
		if getElementHealth(vehicle)<300 then
			setVehicleDamageProof(vehicle, true)
		elseif getElementHealth(vehicle)>301 then
			if getVehicleController (vehicle) then
			setVehicleDamageProof(vehicle, false)
			end
		end
 	end
end, 500, 0)

setTimer(function()
  for i,v in ipairs(getElementsByType("player")) do
	if not getElementData(v,"player:spawn") then return end
	if isPedDead(v) then
		local pos=getElementData(v,"player:spawn")
		fadeCamera(v, true)
		setElementInterior(v,0)
		setElementDimension(v,0)
                setPlayerArmor(v, 100)
		spawnPlayer(v, pos[1], pos[2], pos[3])
		setCameraTarget(v, plr)
		setElementModel(v, getElementData(plr, "player:skin"))
	end
	if( getPlayerIdleTime(v) > 1 ) then
	setElementData(v, "player:afk", true)
	elseif ( getPlayerIdleTime(v) < 1 ) then
	setElementData(v, "player:afk", false)
	end	
  end
end, 10000, 0)

words = {"22003",":220","78.157","23.235","22015","22010","22020","22017","mtasa://"}

addEventHandler('onPlayerChat', root, function(msg, type)
	if type==0 then
		cancelEvent()
		if ninjaban(msg) then
		kickPlayer (source, "System:Reklama")
		triggerClientEvent(root, "admin:rendering", root, "* "..getPlayerName(source).."("..getElementData(source,"id")..") został(a) wyrzucony(a) przez system. Powod: Reklama")
		return end
		local x,y,z=getElementPosition(source)
		local sphere=createColSphere(x,y,z, 30)
		local players=getElementsWithinColShape(sphere, 'player')
		if #players==0 then
			destroyElement(sphere)
			triggerClientEvent(source,"addNotification",root,'* Nie ma żadnego gracza w pobliżu, więc wiadomość jest niemożliwa.',"warning")
			return
		end

		for i,v in pairs(players) do
			local id=getElementData(source,"id")
			outputChatBox("#0033FF[ID:#FFFFFF"..getElementData(source,"id").."#0033FF] #FFFFFF"..getPlayerName(source)..":#FFFFFF "..msg:gsub("#%x%x%x%x%x%x",""), v, _, _, _, true)
		end
		
		destroyElement(sphere)
		local desc = string.format("Czat Lokalny> "..getPlayerName(source).."("..getElementData(source,"id").."): "..msg):gsub("#%x%x%x%x%x%x","")
		--triggerClientEvent(root, "admin:addText", root, desc)
		triggerClientEvent(root, "onDebugMessage", resourceRoot, desc:gsub("#%x%x%x%x%x%x",""),1, "CZAT")
		triggerClientEvent("onChatbubblesMessageIncome",source,msg:gsub("#%x%x%x%x%x%x",""),0)
	elseif type==1 then
		cancelEvent()
		if ninjaban(msg) then
		kickPlayer (source, "System:Reklama")
		triggerClientEvent(root, "admin:rendering", root, "* "..getPlayerName(source).."("..getElementData(source,"id")..") został(a) wyrzucony(a) przez system. Powod: Reklama")
		return end
		local x,y,z=getElementPosition(source)
		local sphere=createColSphere(x,y,z, 30)
		local players=getElementsWithinColShape(sphere, 'player')
		destroyElement(sphere)

		for i,v in pairs(players) do
			outputChatBox("* "..getPlayerName(source):gsub("#%x%x%x%x%x%x","").." "..msg:gsub("#%x%x%x%x%x%x",""), v, 255, 51, 102)
		end
		local q = string.format(">> "..getPlayerName(source).."("..getElementData(source,"id").."): "..msg:gsub("#%x%x%x%x%x%x",""))
		triggerClientEvent("onDebugMessage", resourceRoot, q,1, "/ME")
	end
end)

function ninjaban(ip)
    -- must pass in a string value
    if ip == nil or type(ip) ~= "string" then
        return false
    end

    -- check for format 1.11.111.111 for ipv4
    local chunks = {ip:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")}
    if (#chunks == 4) then
        for _,v in pairs(chunks) do
            if (tonumber(v) < 0 or tonumber(v) > 255) then
                return false
			else
			return true
			end
        end
    else
        return false
    end

    return false
end

function findPlayer(plr,cel)
	local target=nil
	if (tonumber(cel) ~= nil) then
		target=getElementByID("p"..cel)
	else -- podano fragment nicku
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 0, true) then
				if (target) then
					outputChatBox("Znaleziono wiecej niz jednego gracza o pasujacym nicku, podaj wiecej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	if target and getElementData(target,"p:inv") then return nil end
	return target
end

local function findFreeValue(tablica_id)
	table.sort(tablica_id)
	local wolne_id=1
	for i,v in ipairs(tablica_id) do
		if (v==wolne_id) then wolne_id=wolne_id+1 end
		if (v>wolne_id) then return wolne_id end
	end
	return wolne_id
end

function assignPlayerID(plr)
	local gracze=getElementsByType("player")
	local tablica_id = {}
	for i,v in ipairs(gracze) do
		local lid=getElementData(v, "id")
		if (lid) then
			table.insert(tablica_id, tonumber(lid))
		end
	end
	local free_id=findFreeValue(tablica_id)
	if isElement(plr) then
	setElementData(plr,"id", free_id)
	setElementID(plr, "p" .. free_id)
	end
	return free_id
end

function getPlayerID(plr)
	if not plr then return "" end
	local id=getElementData(plr,"id")
	if (id) then
		return id
	else
		return assignPlayerID(plr)
	end
	
end

addEventHandler ("onPlayerJoin", getRootElement(), function()
	assignPlayerID(source)
end)

-------------------------------------------------------------------

function dynamiczne()
local maks_graczy = getServerConfigSetting ( "maxplayers" )
local teraz_graczy = #getElementsByType( "player" )
local nowe = math.ceil( teraz_graczy + (tonumber(maks_graczy) * 0.2) )
if tonumber(nowe) < tonumber(maks_graczy) then
setMaxPlayers(nowe)
else
setMaxPlayers(tonumber(maks_graczy))
end
end

addEventHandler("onPlayerQuit",root,dynamiczne)
addEventHandler("onPlayerJoin",root,dynamiczne)

-------------------------------------------------------------------
