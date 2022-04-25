local QBCore = exports['qb-core']:GetCoreObject()
local mining = false

MiningMaterial = {
    {'mining_washedstone', 1},                                                                          -- Common
    {'mining_copperfragment', math.random(MiningJob.CopperFragMin, MiningJob.CopperFragMax)},           -- Common
    {'mining_ironfragment', math.random(MiningJob.IronFragMin, MiningJob.IronFragMax)},                 -- Semi-Rare
    {'mining_goldnugget', math.random(MiningJob.GoldNugMin, MiningJob.GoldNugMax)},                     -- Rare
}

RegisterNetEvent('tr-mining:Seller', function()
    local source = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if Config.Sell[Player.PlayerData.items[k].name] ~= nil then
                    price = price + (Config.Sell[Player.PlayerData.items[k].name].price * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Player.PlayerData.items[k].name], "remove")
                end
            end
        end
        Player.Functions.AddMoney("cash", price)
        TriggerClientEvent('QBCore:Notify', source, Config.Text["successfully_sold"])
	end
end)

RegisterNetEvent('tr-mining:BuyPickaxe', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local TRClassicPickaxe = MiningJob.PickAxePrice
    local pickaxe = Player.Functions.GetItemByName('mining_pickaxe')
    if not pickaxe then
        Player.Functions.AddItem('mining_pickaxe', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_pickaxe'], "add")
        Player.Functions.RemoveMoney("cash", TRClassicPickaxe)
        TriggerClientEvent('QBCore:Notify', source, Config.Text["Pickaxe_Bought"])
    elseif pickaxe then
        TriggerClientEvent('QBCore:Notify', source, Config.Text["Pickaxe_Check"], 'error')
    end
end)

QBCore.Functions.CreateCallback('tr-mining:pickaxe', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("mining_pickaxe") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterNetEvent('tr-mining:BuyWash', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local TRClassicPan = MiningJob.WashPanPrice
    local pan = Player.Functions.GetItemByName('mining_pan')
    if not pan then
        Player.Functions.AddItem('mining_pan', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_pan'], "add")
        Player.Functions.RemoveMoney("cash", TRClassicPan)
        TriggerClientEvent('QBCore:Notify', source, Config.Text["Pan_Bought"])
    elseif pan then
        TriggerClientEvent('QBCore:Notify', source, Config.Text["Pan_check"], 'error')
    end
end)

QBCore.Functions.CreateCallback('tr-mining:washpan', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("mining_pan") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('tr-mining:receivedStone', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local mineStone = math.random(MiningJob.StoneMin, MiningJob.StoneMax)
    Player.Functions.AddItem('mining_stone', mineStone)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_stone'], "add")
end)

RegisterNetEvent('tr-mining:receivedReward', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local minerstone = Player.Functions.GetItemByName('mining_stone')
    local ChanceItem = MiningMaterial[math.random(1, #MiningMaterial)]
    if not minerstone then
        TriggerClientEvent('QBCore:Notify', source, Config.Text['error_minerstone'])
    end
    local amount = minerstone.amount
    if amount >= 1 then
        amount = 1
    else
        return false
    end
    if not Player.Functions.RemoveItem('mining_stone', amount) then
        TriggerClientEvent('QBCore:Notify', source, Config.Text['error_minerstone'])
    end
    TriggerClientEvent('invenotry:client:ItemBox', source, QBCore.Shared.Items['error_minerstone'], "remove")
    Wait(1000)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[ChanceItem[1]], "add")
    Player.Functions.AddItem(ChanceItem[1], ChanceItem[2] )
    
end)

RegisterNetEvent('tr-mining:setMiningStage', function(stage, state, k)
    Config.MiningLocation[k][stage] = state
    TriggerClientEvent('tr-mining:getMiningstage', -1, stage, state, k)
end)

QBCore.Functions.CreateCallback('tr-mining:stonesbruf', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("mining_stone") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)


RegisterNetEvent('tr-mining:setMiningTimer', function()
    if not mining then
        mining = true
        CreateThread(function()
            Wait(Config.Timeout)
            for k, v in pairs(Config.MiningLocation) do
                Config.MiningLocation[k]["isMined"] = false
                TriggerClientEvent('tr-mining:getMiningstage', -1, 'isMined', false, k)
            end
            mining = false
        end)
    end
end)

RegisterServerEvent('tr-mining:IronBar', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local TRIronCheck = Player.Functions.GetItemByName('mining_ironfragment')
    local IronSmeltAmount = math.random(MiningJob.SmeltIronMin, MiningJob.SmeltIronMax)
    local IronBarsReceived = math.random(MiningJob.IronBarsMin, MiningJob.IronBarsMax)
    if not TRIronCheck then 
        TriggerClientEvent('QBCore:Notify', source, Config.Text['error_ironCheck'])
        return false
    end

    local amount = TRIronCheck.amount
    if amount >= 1 then
        amount = IronSmeltAmount
    else
      return false
    end
    
    if not Player.Functions.RemoveItem('mining_ironfragment', amount) then 
        TriggerClientEvent('QBCore:Notify', source, Config.Text['itemamount'])
        return false 
    end

    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_ironfragment'], "remove")
    TriggerClientEvent('QBCore:Notify', source, Config.Text["ironSmelted"] ..IronSmeltAmount.. Config.Text["ironSmeltedMiddle"] ..IronBarsReceived.. Config.Text["ironSmeltedEnd"])
    Wait(750)
    Player.Functions.AddItem('mining_ironbar', IronBarsReceived)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_ironbar'], "add")
end)

QBCore.Functions.CreateCallback('tr-mining:IronCheck', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("mining_ironfragment") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent('tr-mining:CopperBar', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local TRCopperBars = Player.Functions.GetItemByName('mining_copperfragment')
    local CopperSmeltAmount = math.random(MiningJob.SmeltCopperMin, MiningJob.SmeltCopperMin)
    local CopperBarsReceived = math.random(MiningJob.CopperBarsMin, MiningJob.CopperBarsMax)
    if not TRCopperBars then 
        TriggerClientEvent('QBCore:Notify', source, Config.Text['error_copperCheck'])
        return false
    end

    local amount = TRCopperBars.amount
    if amount >= 1 then
        amount = CopperSmeltAmount
    else
      return false
    end
    
    if not Player.Functions.RemoveItem('mining_copperfragment', amount) then 
        TriggerClientEvent('QBCore:Notify', source, Config.Text['itemamount'])
        return false 
    end

    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_copperfragment'], "remove")
    TriggerClientEvent('QBCore:Notify', source, Config.Text["CopperSmelted"] ..CopperSmeltAmount.. Config.Text["CopperSmeltedMiddle"] ..CopperBarsReceived.. Config.Text["CopperSmeltedEnd"])
    Wait(750)
    Player.Functions.AddItem('mining_copperbar', CopperBarsReceived)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_copperbar'], "add")
end)

RegisterServerEvent('tr-mining:GoldBar', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local TRGoldenTicket = Player.Functions.GetItemByName('mining_goldnugget')
    local GoldSmeltAmount = math.random(MiningJob.SmeltGoldMin, MiningJob.SmeltGoldMax)
    local GoldBarRecevied = math.random(MiningJob.GoldBarsMin, MiningJob.GoldBarsMax)
    if not TRGoldenTicket then 
        TriggerClientEvent('QBCore:Notify', source, Config.Text['error_copperCheck'])
        return false
    end

    local amount = TRGoldenTicket.amount
    if amount >= 1 then
        amount = GoldSmeltAmount
    else
      return false
    end
    
    if not Player.Functions.RemoveItem('mining_goldnugget', amount) then 
        TriggerClientEvent('QBCore:Notify', source, Config.Text['itemamount'])
        return false 
    end

    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_goldnugget'], "remove")
    TriggerClientEvent('QBCore:Notify', source, Config.Text["GoldSmelted"] ..GoldSmeltAmount.. Config.Text["GoldSmeltedMiddle"] ..GoldBarRecevied.. Config.Text["GoldSmeltedEnd"])
    Wait(750)
    Player.Functions.AddItem('mining_goldbar', GoldBarRecevied)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_goldbar'], "add")
end)

QBCore.Functions.CreateCallback('tr-mining:IronCheck', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("mining_ironfragment") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

QBCore.Functions.CreateCallback('tr-mining:GoldCheck', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("mining_goldnugget") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)
QBCore.Functions.CreateCallback('tr-mining:CopperCheck', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("mining_copperfragment") ~= nil then
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
    print("^0\n ------------------------------------------------------------------------------------------------------------------------------\n ^1\n ████████╗██████╗       ███╗   ███╗██╗███╗   ██╗██╗███╗   ██╗ ██████╗ \t \n ╚══██╔══╝██╔══██╗      ████╗ ████║██║████╗  ██║██║████╗  ██║██╔════╝ \t \n    ██║   ██████╔╝█████╗██╔████╔██║██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗\t \n    ██║   ██╔══██╗╚════╝██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╗██║██║   ██║ \t \n    ██║   ██║  ██║      ██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚████║╚██████╔╝\t \n    ╚═╝   ╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝ \t   \n    \n      \n                   ^1Discord ^5 --> ^0https://discord.gg/zRCdhENsHG                         ^1Author^5: ^0TRClassic#0001 \n \n------------------------------------------------------------------------------------------------------------------------------ \n ")
end)