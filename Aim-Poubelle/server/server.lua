players, searechBins = {}, {}

function hasCooldownPassed(src)
    local last = players[src]
    if last then
        local now = GetGameTimer()
        if now - last < Config.General.SearchCooldown then
            return false
        end
    end
    return true
end

function hasBeenSearched(binId)
    local last = searechBins[binId]
    if last then
        local now = GetGameTimer()
        if now - last < Config.General.Recharge_Poubelle then
            return true
        end
    end
    return false
end

function isLegit(src)
    local playersLastSearch = players[src]
    if not playersLastSearch then
        return true
    end

    if GetGameTimer() - playersLastSearch >= Config.General.Temps_De_Recherche then
        return true
    end

    return false
end


RegisterNetEvent('server:searchTrash')
AddEventHandler('server:searchTrash', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not hasCooldownPassed(src) then
        local timeLeft = ((players[src] + Config.General.SearchCooldown - GetGameTimer()) / 1000)
        TriggerClientEvent("esx:showNotification", xPlayer.source, (Translations[Lang]["error"]["cooldown"]:format(timeLeft)))
        ClearPedTasks(xPlayer.source)
        return
    end

    -- Si le joueur a déjà cherché dans la poubelle dans les 10 dernières minutes qui suivent alors il reçoit un message d'erreur
    -- Affiche le message d'erreur
    local binId = data
    if hasBeenSearched(data) then
        TriggerClientEvent("esx:showNotification", xPlayer.source, Translations[Lang]["error"]["hasBeenSearched"])
        ClearPedTasks(xPlayer.source)
        return
    end
    TriggerClientEvent('client:searchTrash', src, binId)
end)


function rollPrecentage(precantage)
    local roll = math.random(1, 100)
    if roll <= precantage then
        return true
    end
    return false
end

RegisterNetEvent('server:searchedTrash')
AddEventHandler('server:searchedTrash', function(binId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
     
    -- Vérifie si le joueur triche.
    if not isLegit(src) then
        TriggerClientEvent("esx:showNotification", xPlayer.source, (Translations[Lang]["error"]["notLegit"]:format(notLegit)))
    end


    -- Définir le dernier temps de recherche
    players[src] = GetGameTimer()

    -- Définir le dernier temps de recherche
    searechBins[binId] = GetGameTimer()

    if not rollPrecentage(Config.Gains.Chance) then
        TriggerClientEvent("esx:showNotification", xPlayer.source, Translations[Lang]["error"]["nothingFound"])
        ClearPedTasks(xPlayer.source)
        return
    end

    if rollPrecentage(Config.Gains.Argent.Chance) then
        local amount = math.random(Config.Gains.Argent.Min, Config.Gains.Argent.Max)
        TriggerClientEvent("esx:showNotification", xPlayer.source, (Translations[Lang]["gains"]["money"]:format(amount)))
        xPlayer.addMoney(amount)
        ClearPedTasks(xPlayer.source)
        return
    end

    local items = {}

    for i = 1, math.random(Config.Gains.Min_Nb_Items, Config.Gains.Max_Nb_Items) do
        local item = Config.Gains.ItemList[math.random(1, #Config.Gains.ItemList)]
        items[#items + 1] = item
    end

    for k, v in pairs(items) do
        xPlayer.addInventoryItem(v, 1)
        TriggerClientEvent("esx:showNotification", xPlayer.source, (Translations[Lang]["gains"]["found"]:format(ESX.GetItemLabel(v))))
        ClearPedTasks(xPlayer.source)
    end
end)