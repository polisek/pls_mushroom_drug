local sharedItems = exports['qbr-core']:GetItems()

exports['qbr-core']:CreateUseableItem(Config.MushroomDrugItem, function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    TriggerClientEvent('pls_houbicky:client:uselysohlavky', src)
    Player.Functions.RemoveItem(Config.MushroomDrugItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[Config.MushroomDrugItem], "remove")
end) 
