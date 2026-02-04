ESX = exports["es_extended"]:getSharedObject()

local isInMarker = false
local currentMarker = nil
local processedPoints = {}
local loadedIpls = {}

local function hasAllowedJob(allowedJobs, playerJob)
    if not allowedJobs then return true end
    for _, job in ipairs(allowedJobs) do
        if job == playerJob then
            return true
        end
    end
    return false
end

-- Persistent alle IPLs laden (einmalig)
Citizen.CreateThread(function()
    for _, point in ipairs(Config.TeleportPoints) do
        for _, ipl in ipairs(point.ipls or {}) do
            if not loadedIpls[ipl] then
                RequestIpl(ipl)
                loadedIpls[ipl] = true
                print(string.format("[TP] IPL geladen beim Start: %s", ipl))
            end
        end
    end
end)

-- Teleportationspunkte verarbeiten (twoWay berücksichtigen)
Citizen.CreateThread(function()
    for i, point in ipairs(Config.TeleportPoints) do
        table.insert(processedPoints, point)
        
        if point.twoWay then
            local returnPoint = {
                name = point.name .. " (Rückweg)",
                from = point.to,
                to = point.from,
                heading = point.heading and ((point.heading + 180.0) % 360.0) or 0.0,
                markerSize = point.markerSize,
                markerColor = point.markerColor,
                drawDistance = point.drawDistance,
                interactDistance = point.interactDistance,
                twoWay = false,
                ipls = point.ipls,
                allowedJobs = point.allowedJobs
            }
            table.insert(processedPoints, returnPoint)
        end
    end
end)

-- Optimierte Distanz-Überprüfung (läuft langsamer)
local nearbyMarkers = {}
local lastDistanceCheck = 0
Citizen.CreateThread(function()
    while ESX == nil do Citizen.Wait(100) end
    
    while true do
        local checkInterval = 250  -- Reduziert von 500ms auf 250ms für schnelleres Marker-Erscheinen
        Citizen.Wait(checkInterval)
        
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local tempNearby = {}
        
        for i, point in ipairs(processedPoints) do
            local distance = #(playerCoords - point.from)
            if distance < point.drawDistance then
                tempNearby[i] = {
                    point = point,
                    distance = distance
                }
            end
        end
        
        nearbyMarkers = tempNearby
    end
end)

-- Optimierter Marker-Rendering-Thread
Citizen.CreateThread(function()
    while ESX == nil do Citizen.Wait(100) end
    
    while true do
        local sleep = 1000  -- Standardmäßig 1 Sekunde schlafen
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isInVehicle = IsPedInAnyVehicle(playerPed, false)
        local playerData = ESX.GetPlayerData()
        local playerJob = playerData and playerData.job and playerData.job.name or nil
        
        -- Nur rendern wenn es nahe Marker gibt
        if next(nearbyMarkers) ~= nil then
            sleep = 0  -- Aktiv rendern
            
            for i, data in pairs(nearbyMarkers) do
                local point = data.point
                local distance = #(playerCoords - point.from)
                
                -- Marker zeichnen
                local markerType = isInVehicle and Config.MarkerTypeCarSymbol or Config.MarkerTypeVerticalCylinder
                local markerZ = isInVehicle and (point.from.z + 2) or point.from.z
                
                DrawMarker(
                    markerType,
                    point.from.x, point.from.y, markerZ,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    point.markerSize.x, point.markerSize.y, point.markerSize.z,
                    point.markerColor.r, point.markerColor.g, point.markerColor.b, point.markerColor.a,
                    false, true, 2, false, nil, nil, false
                )
                
                -- Interaktion prüfen
                if distance < point.interactDistance then
                    if not isInMarker then
                        isInMarker = true
                        currentMarker = point
                    end
                    
                    local canUse = hasAllowedJob(point.allowedJobs, playerJob)
                    if canUse then
                        if isInVehicle then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                                DisplayHelpText("Drücke ~INPUT_PICKUP~ um zu teleportieren")
                            else
                                DisplayHelpText("Nur der Fahrer kann teleportieren")
                            end
                        else
                            DisplayHelpText("Drücke ~INPUT_PICKUP~ um zu teleportieren")
                        end
                    else
                        DisplayHelpText("Du hast keine Berechtigung für diesen Teleporter")
                    end
                    
                    local canTeleport = (not isInVehicle or (isInVehicle and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed)) and hasAllowedJob(point.allowedJobs, playerJob)
                    if IsControlJustReleased(0, Config.InteractKey) and canTeleport then
                        TeleportToLocation(point.to, point.heading or 0.0, isInVehicle)
                    end
                end
            end
        else
            -- Keine Marker in der Nähe, reset state
            if isInMarker then
                isInMarker = false
                currentMarker = nil
            end
        end
        
        Citizen.Wait(sleep)
    end
end)

-- Optimierte Kollisions-Laden (nur einmalig beim Annähern)
local loadedCollisions = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)  -- Reduziert von 2000ms auf 1000ms für schnelleres Laden
        
        for i, data in pairs(nearbyMarkers) do
            local point = data.point
            local coordsKey = string.format("%.1f_%.1f_%.1f", point.to.x, point.to.y, point.to.z)
            
            if not loadedCollisions[coordsKey] then
                RequestCollisionAtCoord(point.to.x, point.to.y, point.to.z)
                loadedCollisions[coordsKey] = true
            end
            
            local fromKey = string.format("%.1f_%.1f_%.1f", point.from.x, point.from.y, point.from.z)
            if not loadedCollisions[fromKey] then
                RequestCollisionAtCoord(point.from.x, point.from.y, point.from.z)
                loadedCollisions[fromKey] = true
            end
        end
    end
end)

-- Event-Handler für Passagiere: IPLs und Kollisionen laden
RegisterNetEvent('fivem_lero_teleportation:loadDestination')
AddEventHandler('fivem_lero_teleportation:loadDestination', function(coords, ipls)
    -- IPLs für alle Passagiere laden
    for _, ipl in ipairs(ipls or {}) do
        if not loadedIpls[ipl] then
            RequestIpl(ipl)
            loadedIpls[ipl] = true
        end
    end
    
    -- Kollisionen für alle Passagiere laden
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    local coordsKey = string.format("%.1f_%.1f_%.1f", coords.x, coords.y, coords.z)
    loadedCollisions[coordsKey] = true
    
    -- Zusätzlich: Aggressives Nachladen für 2 Sekunden
    Citizen.CreateThread(function()
        local endTime = GetGameTimer() + 2000
        while GetGameTimer() < endTime do
            for _, ipl in ipairs(ipls or {}) do
                RequestIpl(ipl)
            end
            RequestCollisionAtCoord(coords.x, coords.y, coords.z)
            Citizen.Wait(100)
        end
    end)
end)

-- NEUES Event: Force-Load für garantiertes Laden bei allen Passagieren
RegisterNetEvent('fivem_lero_teleportation:forceLoadDestination')
AddEventHandler('fivem_lero_teleportation:forceLoadDestination', function(coords, ipls)
    print(string.format("[TP Client] Empfange Force-Load für: %.1f, %.1f, %.1f mit %d IPLs", coords.x, coords.y, coords.z, #ipls))
    
    -- Starte neues Szenen-Laden
    NewLoadSceneStart(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z, 50.0, 0)
    
    -- Sofortiges aggressives Laden
    for _, ipl in ipairs(ipls or {}) do
        RequestIpl(ipl)
        loadedIpls[ipl] = true
        print(string.format("[TP Client] Force-Load IPL: %s", ipl))
    end
    
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    
    -- Aggressives Nachladen für 4 Sekunden
    Citizen.CreateThread(function()
        local endTime = GetGameTimer() + 4000
        local iterations = 0
        while GetGameTimer() < endTime do
            for _, ipl in ipairs(ipls or {}) do
                RequestIpl(ipl)
            end
            RequestCollisionAtCoord(coords.x, coords.y, coords.z)
            
            -- Zusätzlich: Szenen-Streaming forcieren
            if iterations % 10 == 0 then
                NewLoadSceneStop()
                NewLoadSceneStart(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z, 50.0, 0)
            end
            
            iterations = iterations + 1
            Citizen.Wait(50)
        end
        
        NewLoadSceneStop()
        print(string.format("[TP Client] Force-Load abgeschlossen nach %d Iterationen", iterations))
    end)
end)

-- Teleportations-Funktion (optimiert)
function TeleportToLocation(coords, heading, isInVehicle)
    local targetPoint = nil
    for _, p in ipairs(processedPoints) do
        if p.to.x == coords.x and p.to.y == coords.y and p.to.z == coords.z then
            targetPoint = p
            break
        end
    end
    
    local playerPed = PlayerPedId()
    
    if isInVehicle then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        if vehicle ~= 0 then
            -- Fahrzeug SOFORT stoppen
            FreezeEntityPosition(vehicle, true)
            
            if targetPoint then
                local vehicleNetId = NetworkGetNetworkIdFromEntity(vehicle)
                local currentCoords = GetEntityCoords(vehicle)
                
                print(string.format("[TP Client] Fahrer triggert Teleport von %.1f,%.1f,%.1f nach %.1f,%.1f,%.1f", 
                    currentCoords.x, currentCoords.y, currentCoords.z,
                    coords.x, coords.y, coords.z))
                
                -- Server-Event triggern ZUERST
                TriggerServerEvent('fivem_lero_teleportation:requestLoad', coords, targetPoint.ipls or {}, vehicleNetId, currentCoords)
                
                -- Warte länger damit Server alle erreichen kann
                Citizen.Wait(100)
                
                -- Lokales Force-Load für Fahrer
                TriggerEvent('fivem_lero_teleportation:forceLoadDestination', coords, targetPoint.ipls or {})
                
                -- Warte auf initiales Laden
                Citizen.Wait(800)
            end
            
            -- Fahrzeug teleportieren
            SetEntityCoords(vehicle, coords.x, coords.y, coords.z, false, false, false, true)
            SetEntityHeading(vehicle, heading)
            
            Citizen.Wait(200)
            SetVehicleOnGroundProperly(vehicle)

            -- LERO NEW V_6
            FreezeEntityPosition(vehicle, false)
            
            -- Warte für vollständiges MLO-Laden
            Citizen.Wait(2000)
            
            print("[TP Client] Teleportation abgeschlossen")
        end
    else
        if targetPoint then
            for _, ipl in ipairs(targetPoint.ipls or {}) do
                if not loadedIpls[ipl] then
                    RequestIpl(ipl)
                    loadedIpls[ipl] = true
                end
            end
            RequestCollisionAtCoord(coords.x, coords.y, coords.z)
        end
        
        -- Teleportation zu Fuß
        SetEntityCoords(playerPed, coords.x, coords.y, coords.z, false, false, false, true)
        SetEntityHeading(playerPed, heading)
        
        Citizen.Wait(100)
    end
end

function DisplayHelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
