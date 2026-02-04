ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('fivem_lero_teleportation:requestLoad')
AddEventHandler('fivem_lero_teleportation:requestLoad', function(destCoords, ipls, vehicleNetId, currentCoords)
    local source = source
    local players = ESX.GetExtendedPlayers()
    local loadedPlayers = {}
    
    for _, xPlayer in pairs(players) do
        local targetPed = GetPlayerPed(xPlayer.source)
        local targetCoords = GetEntityCoords(targetPed)
        local distance = #(vector3(currentCoords.x, currentCoords.y, currentCoords.z) - targetCoords)
        
        if distance < 50.0 then
            TriggerClientEvent('fivem_lero_teleportation:forceLoadDestination', xPlayer.source, destCoords, ipls)
            table.insert(loadedPlayers, xPlayer.source)
        end
    end
    
    print(string.format("[Teleportation] Spieler %s lädt IPLs für %d Spieler: %s", source, #loadedPlayers, table.concat(loadedPlayers, ", ")))
end)
