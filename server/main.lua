local mining = false

MiningMaterial = {
    {'mining_washedstone', 1},                                                                          -- Common
    {'mining_copperfragment', math.random(MiningJob.CopperFragMin, MiningJob.CopperFragMax)},           -- Common
    {'mining_ironfragment', math.random(MiningJob.IronFragMin, MiningJob.IronFragMax)},                 -- Semi-Rare
    {'mining_goldnugget', math.random(MiningJob.GoldNugMin, MiningJob.GoldNugMax)},                     -- Rare
}

RegisterNetEvent('esx-mining:Seller', function()
    local source = source
    local price = 0
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in pairs(Config.Sell) do 
        local item = xPlayer.getInventoryItem(k)
        if item and item.count >= 1 then
            price = price + (v * item.count)
            xPlayer.removeInventoryItem(k, item.count)
        end
    end
    if price > 0 then
        xPlayer.addMoney(price)
        xPlayer.showNotification(Config.Alerts["successfully_sold"], true, false, 140)
    else
        xPlayer.showNotification(Config.Alerts["no_item"])
    end
end)

RegisterNetEvent('esx-mining:BuyPickaxe', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pickaxe = xPlayer.getInventoryItem('mining_pickaxe').count
    if pickaxe < 1 then
        xPlayer.addInventoryItem('mining_pickaxe', 1)
        xPlayer.removeMoney(MiningJob.PickAxePrice)
        xPlayer.showNotification(Config.Text["Pickaxe_Bought"])
    else
        xPlayer.showNotification(Config.Text["Pickaxe_Check"])
    end
end)

ESX.RegisterServerCallback('esx-mining:pickaxe', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getInventoryItem("mining_pickaxe").count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterNetEvent('esx-mining:BuyWash', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pan = xPlayer.getInventoryItem("mining_pan").count
    if pan < 1 then
        xPlayer.addInventoryItem('mining_pan', 1)
        xPlayer.removeMoney(MiningJob.WashPanPrice)
        xPlayer.showNotification(Config.Text["Pan_Bought"])
    else
        xPlayer.showNotification(Config.Text["Pan_check"])
    end
end)

ESX.RegisterServerCallback('esx-mining:washpan', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getInventoryItem("mining_pan").count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('esx-mining:receivedStone', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local mineStone = math.random(MiningJob.StoneMin, MiningJob.StoneMax)
    print(mineStone)
    xPlayer.addInventoryItem('mining_stone', mineStone)
end)

RegisterNetEvent('esx-mining:receivedReward', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local minerstone = xPlayer.getInventoryItem("mining_stone")
    local ChanceItem = MiningMaterial[math.random(1, #MiningMaterial)]

    local amount = minerstone.count
    if amount >= 1 then
        amount = 1
    else
        return false
    end

    if minerstone.count >= amount then 
        xPlayer.removeInventoryItem('minerstone', amount)
        xPlayer.addInventoryItem(ChanceItem[1], ChanceItem[2])
    end
end)

RegisterNetEvent('esx-mining:setMiningStage', function(stage, state, k)
    Config.MiningLocation[k][stage] = state
    TriggerClientEvent('esx-mining:getMiningstage', -1, stage, state, k)
end)

ESX.RegisterServerCallback('esx-mining:stonesbruf', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getInventoryItem("mining_stone").count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)


RegisterNetEvent('esx-mining:setMiningTimer', function()
    if not mining then
        mining = true
        CreateThread(function()
            Wait(Config.Timeout)
            for k, v in pairs(Config.MiningLocations) do
                Config.MiningLocations[k]["isMined"] = false
                TriggerClientEvent('esx-mining:getMiningstage', -1, 'isMined', false, k)
            end
            mining = false
        end)
    end
end)

RegisterServerEvent('esx-mining:IronBar', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local IronCheck = xPlayer.getInventoryItem('mining_ironfragment')
    local IronSmeltAmount = math.random(MiningJob.SmeltIronMin, MiningJob.SmeltIronMax)
    local IronBarsReceived = math.random(MiningJob.IronBarsMin, MiningJob.IronBarsMax)

    local amount = IronCheck.count
    if amount >= 1 then
        amount = IronSmeltAmount
    else
      return false
    end
    
    if IronCheck.count >= amount then 
        xPlayer.removeInventoryItem('mining_ironfragment', amount)
        xPlayer.addInventoryItem('mining_ironbar', IronBarsReceived)
        xPlayer.showNotification(Config.Text["ironSmelted"] ..IronSmeltAmount.. Config.Text["ironSmeltedMiddle"] ..IronBarsReceived.. Config.Text["ironSmeltedEnd"])
    end
end)

ESX.RegisterServerCallback('esx-mining:IronCheck', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getInventoryItem("mining_ironfragment").count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('esx-mining:CopperBar', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local CopperBars = xPlayer.getInventoryItem('mining_copperfragment')
    local CopperSmeltAmount = math.random(MiningJob.SmeltCopperMin, MiningJob.SmeltCopperMin)
    local CopperBarsReceived = math.random(MiningJob.CopperBarsMin, MiningJob.CopperBarsMax)

    local amount = CopperBars.count
    if amount >= 1 then
        amount = CopperSmeltAmount
    else
      return false
    end
    
    if CopperBars.count >= amount then 
        xPlayer.removeInventoryItem('mining_copperfragment', amount)
        xPlayer.addInventoryItem('mining_copperbar', CopperBarsReceived)
        xPlayer.showNotification(Config.Text["CopperSmelted"] ..CopperSmeltAmount.. Config.Text["CopperSmeltedMiddle"] ..CopperBarsReceived.. Config.Text["CopperSmeltedEnd"])
    end
end)

RegisterServerEvent('esx-mining:GoldBar', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gold = xPlayer.getInventoryItem('mining_goldnugget')
    local GoldSmeltAmount = math.random(MiningJob.SmeltCopperMin, MiningJob.SmeltCopperMin)
    local GoldBarsReceived = math.random(MiningJob.CopperBarsMin, MiningJob.CopperBarsMax)

    local amount = Gold.count
    if amount >= 1 then
        amount = GoldSmeltAmount
    else
      return false
    end
    
    if Gold.count >= amount then 
        xPlayer.removeInventoryItem('mining_goldnugget', amount)
        xPlayer.addInventoryItem('mining_goldbar', CopperBarsReceived)
        xPlayer.showNotification(Config.Text["GoldSmelted"] ..CopperSmeltAmount.. Config.Text["GoldSmeltedMiddle"] ..CopperBarsReceived.. Config.Text["GoldSmeltedEnd"])
    end
end)

ESX.RegisterServerCallback('esx-mining:IronCheck', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem("mining_ironfragment").count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)

ESX.RegisterServerCallback('esx-mining:GoldCheck', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem("mining_goldnugget").count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)

ESX.RegisterServerCallback('esx-mining:CopperCheck', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem("mining_copperfragment").count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print("--------------------------------------------------------------------------")
    print("^4███████╗ ██████╗██╗  ██╗  ███╗   ███╗██╗███╗  ██╗██╗███╗  ██╗ ██████╗   |")
    print("^4██╔════╝██╔════╝╚██╗██╔╝  ████╗ ████║██║████╗ ██║██║████╗ ██║██╔════╝   |")
    print("^4█████╗  ╚█████╗  ╚███╔╝   ██╔████╔██║██║██╔██╗██║██║██╔██╗██║██║  ██╗   |")
    print("^3██╔══╝   ╚═══██╗ ██╔██╗   ██║╚██╔╝██║██║██║╚████║██║██║╚████║██║  ╚██╗  |")
    print("^3███████╗██████╔╝██╔╝╚██╗  ██║ ╚═╝ ██║██║██║  ███║██║██║ ╚███║╚██████╔╝  |")
    print("^3╚══════╝╚═════╝ ╚═╝  ╚═╝  ╚═╝     ╚═╝╚═╝╚═╝  ╚══╝╚═╝╚═╝  ╚══╝ ╚═════╝   |")
    print("^7----------------------------------------------------------------------------------")
    print("^7 Converted By Mycroft (Manager of ESX-Framework) & Benzo (ESX Community Manager)  |")
    print("^7              Website: https://docs.esx-framework.org                             |")
    print("^7                    TRClassic: https://dsc.gg/trclassic                           |")
    print("^1     Original Script: https://github.com/trclassic92/tr-mining                    ^7|")
    print("----------------------------------------------------------------------------------")
end)