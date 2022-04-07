local QBCore = exports['qb-core']:GetCoreObject()
local miningZone = false
local isMining = false

RegisterNetEvent('tr-mining:getMiningstage', function(stage, state, k)
  Config.MiningLocation[k][stage] = state
end)

local function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(3)
  end
end

local function StartMining(mining)
  local animDict = "melee@hatchet@streamed_core"
  local animName = "plyr_rear_takedown_b"
  local trClassic = PlayerPedId()
  local miningtimer = MiningJob.MiningTimer
  isMining = true
  TriggerEvent('tr-mining:miningwithaxe')
  FreezeEntityPosition(trClassic, true)
  QBCore.Functions.Progressbar("Mining....", Config.Text['Mining_ProgressBar'], miningtimer, false, true, {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
  }, {}, {}, {}, function()
      TriggerServerEvent('tr-mining:setMiningStage', "isMined", true, mining)
      TriggerServerEvent('tr-mining:setMiningStage', "isOccupied", false, mining)
      TriggerServerEvent('tr-mining:receivedStone')
      TriggerServerEvent('tr-mining:setMiningTimer')
      isMining = false
      TaskPlayAnim(trClassic, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
      DetachEntity(pickaxeprop, 1, true)
      DeleteEntity(pickaxeprop)
      DeleteObject(pickaxeprop)
      FreezeEntityPosition(trClassic, false)
  end, function()
      ClearPedTasks(trClassic)
      TriggerServerEvent('tr-mining:setMiningStage', "isOccupied", false, mining)
      isMining = false
      TaskPlayAnim(trClassic, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
      FreezeEntityPosition(trClassic, false)
      DetachEntity(pickaxeprop, 1, true)
      DeleteEntity(pickaxeprop)
      DeleteObject(pickaxeprop)
  end)
  TriggerServerEvent('tr-mining:setMiningStage', "isOccupied", true, mining)
  CreateThread(function()
      while isMining do
          loadAnimDict(animDict)
          TaskPlayAnim(trClassic, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
          Wait(3000)
      end
  end)
end

RegisterNetEvent('tr-mining:miningwithaxe', function()
  local ped = PlayerPedId()
  trpickaxeprop = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true)        
  AttachEntityToEntity(trpickaxeprop, ped, GetPedBoneIndex(ped, 57005), 0.17, -0.04, -0.04, 180, 100.00, 120.0, true, true, false, true, 1, true)
  Wait(MiningJob.MiningTimer)
  DetachEntity(trpickaxeprop, 1, true)
  DeleteEntity(trpickaxeprop)
  DeleteObject(trpickaxeprop)
end)

RegisterNetEvent('tr-mining:getpickaxe', function()
  TriggerServerEvent('tr-mining:BuyPickaxe')
end)

RegisterNetEvent('tr-mining:getPan', function()
  TriggerServerEvent('tr-mining:BuyWash')
end)

RegisterNetEvent('tr-mining:minermenu', function()
local minermenu = {
  {
    header = Config.Text["MenuHeading"],
    isMenuHeader = true,
  },
    {
      header = Config.Text["MenuPickAxe"],
      txt = Config.Text["PickAxeText"],
      params = {
          event = 'tr-mining:getpickaxe',
        }
    },
    {
      header = Config.Text["goback"],
    },
  }
  exports['qb-menu']:openMenu(minermenu)
end)

RegisterNetEvent('tr-mining:panmenu', function()
local panmenu = {
  {
    header = Config.Text["WashHeading"],
    isMenuHeader = true,
  },
    {
      header = Config.Text["MenuWashPan"],
      txt = Config.Text["PanText"],
      params = {
          event = 'tr-mining:getPan',
        }
    },
    {
      header = Config.Text["goback"],
    },
  }
  exports['qb-menu']:openMenu(panmenu)
end)

RegisterNetEvent('tr-mining:smeltmenu', function()
  local smeltMenu = {
    {
      header = Config.Text["SmethHeading"],
      isMenuHeader = true,
    },
      {
        header = Config.Text["Semlt_Iron"],
        txt = Config.Text["smelt_IText"],
        params = {
            event = 'tr-mining:SmeltIron',
          }
      },
      {
        header = Config.Text["Semlt_Copper"],
        txt = Config.Text["smelt_CText"],
        params = {
            event = 'tr-mining:SmeltCopper',
          }
      },
      {
        header = Config.Text["Smelt_Gold"],
        txt = Config.Text["smelt_GText"],
        params = {
            event = 'tr-mining:SmeltGold',
          }
      },
      {
        header = Config.Text["goback"],
      },
    }
    exports['qb-menu']:openMenu(smeltMenu)
  end)

local inMiningZone = false
local function MiningKeyBind(mining)
  isMiningZone = true
  CreateThread(function()
    while isMiningZone do
      if IsControlJustPressed(0, 38) then
        isMiningZone = false
        if not Config.MiningLocation[mining]["isMined"] and not Config.MiningLocation[mining]["isOccupied"] then
          exports['qb-core']:KeyPressed()
          QBCore.Functions.TriggerCallback('tr-mining:pickaxe', function(PickAxe)
            if PickAxe then
              StartMining(mining)
            elseif not PickAxe then
              QBCore.Functions.Notify(Config.Text['error_mining'], 'error')
            end
          end)
        else
          exports['qb-core']:DrawText(Config.Text['error_alreadymined'], 'left')
        end
      end
      Wait(0)
    end
  end)
end

RegisterNetEvent('tr-mining:washingrocks', function()
  QBCore.Functions.TriggerCallback('tr-mining:washpan', function(washingpancheck)
    if washingpancheck then
      QBCore.Functions.TriggerCallback('tr-mining:stonesbruf', function(stonesbruf)
        if stonesbruf then
          local playerPed = PlayerPedId()
          local coords = GetEntityCoords(playerPed)
          local rockwash = MiningJob.WashingTimer
          TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_BUM_WASH', 0, false)
            QBCore.Functions.Progressbar('Washing Stones', Config.Text['Washing_Rocks'], rockwash, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          }, {
          }, {}, {}, function() 
              ClearPedTasks(PlayerPedId())
              TriggerServerEvent("tr-mining:receivedReward")
          end, function() 
            QBCore.Functions.Notify(Config.Text['cancel'], "error")
          end)
        elseif not stonesbruf then
          QBCore.Functions.Notify(Config.Text['error_minerstone'], "error")
        end
      end)
    elseif not washingpancheck then
      Wait(500)
      QBCore.Functions.Notify(Config.Text['error_washpan'], "error", 3000)
    end
  end)
end)

RegisterNetEvent('tr-mining:SmeltIron', function()
  QBCore.Functions.TriggerCallback('tr-mining:IronCheck', function(IronCheck)
    if IronCheck then
      local iron = MiningJob.IronTimer
      TriggerEvent('animations:client:EmoteCommandStart', {"Warmth"})
      QBCore.Functions.Progressbar("smeltIron", Config.Text['smelt_iron'], iron, false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
          disableInventory = true,
      }, {}, {}, {}, function()
          TriggerEvent('animations:client:EmoteCommandStart', {"c"})
          TriggerServerEvent('tr-mining:IronBar')
      end, function() 
          ClearPedTasks(PlayerPedId())
          QBCore.Functions.Notify(Config.Text['cancel'], "error")
      end)
    elseif not IronCheck then
      QBCore.Functions.Notify(Config.Text['error_ironCheck'], "error", 3000)
    end
  end)
end)

RegisterNetEvent('tr-mining:SmeltCopper', function()
  QBCore.Functions.TriggerCallback('tr-mining:CopperCheck', function(CopperCheck)
    if CopperCheck then
      local copper = MiningJob.CopperTimer
      TriggerEvent('animations:client:EmoteCommandStart', {"Warmth"})
      QBCore.Functions.Progressbar("SmeltCopper", Config.Text['smelt_copper'], copper, false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
          disableInventory = true,
      }, {}, {}, {}, function()
          TriggerEvent('animations:client:EmoteCommandStart', {"c"})
          TriggerServerEvent('tr-mining:CopperBar')
      end, function() 
          ClearPedTasks(PlayerPedId())
          QBCore.Functions.Notify(Config.Text['cancel'], "error")
      end)
    elseif not CopperCheck then
      QBCore.Functions.Notify(Config.Text['error_goldCheck'], "error", 3000)
    end
  end)
end)

RegisterNetEvent('tr-mining:SmeltGold', function()
  QBCore.Functions.TriggerCallback('tr-mining:GoldCheck', function(GoldCheck)
    if GoldCheck then
      local gold = MiningJob.GoldTimer
      TriggerEvent('animations:client:EmoteCommandStart', {"Warmth"})
      QBCore.Functions.Progressbar("smeltGold", Config.Text['smelt_gold'], gold, false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
          disableInventory = true,
      }, {}, {}, {}, function()
          TriggerEvent('animations:client:EmoteCommandStart', {"c"})
          TriggerServerEvent('tr-mining:GoldBar')
      end, function() 
          ClearPedTasks(PlayerPedId())
          QBCore.Functions.Notify(Config.Text['cancel'], "error")
      end)
    elseif not GoldCheck then
      QBCore.Functions.Notify(Config.Text['error_goldCheck'], "error", 3000)
    end
  end)
end)

CreateThread(function()
  for k, v in pairs(Config.MiningLocation) do
    local shaftZones = BoxZone:Create(v.coords, 3.5, 3, {
      name = "mineshaft"..k,
      heading = 15,
      minZ = v.coords - 1,
      maxZ = v.coords + 1,
      debugPoly = false
    })
    shaftZones:onPlayerInOut(function(isPointInside)
      if isPointInside then
        miningZone = true
        exports['qb-core']:DrawText(Config.Text['MiningAlert'], 'left')
        Wait(1500)
        exports['qb-core']:HideText() 
        Wait(1000)
        exports['qb-core']:DrawText(Config.Text['StartMining'],'left')
        MiningKeyBind(k)
      else
        inMiningZone = false
        miningZone = false
        exports['qb-core']:HideText()
      end
    end)
  end
  exports['qb-target']:AddBoxZone("MinerBoss", MiningLocation.targetZone, 1, 1, {
    name = "MinerBoss",
    heading = MiningLocation.targetHeading,
    debugPoly = false,
    minZ = MiningLocation.minZ,
    maxZ = MiningLocation.maxZ,
  }, {
    options = {
      {
        type = "client",
        event = "tr-mining:minermenu",
        icon = "Fas Fa-hands",
        label = Config.Text['MenuTarget'],
      },
    },
    distance = 1.5
  })
  exports['qb-target']:AddBoxZone("PanWasher", WashLocation.targetZone, 1, 1, {
    name = "PanWasher",
    heading = WashLocation.targetHeading,
    debugPoly = false,
    minZ = WashLocation.minZ,
    maxZ = WashLocation.maxZ,
  }, {
    options = {
      {
        type = "client",
        event = "tr-mining:panmenu",
        icon = "Fas Fa-hands",
        label = Config.Text['Menu_pTarget'],
      },
    },
    distance = 1.5
  })
  exports['qb-target']:AddBoxZone("Water", vector3(54.77, 3160.31, 25.62), 38.2, 8, {
    name = "Water",
    heading = 155,
    debugPoly = false,
    minZ=22.82,
    maxZ=26.62
  }, {
    options = {
      {
        type = "client",
        event = "tr-mining:washingrocks",
        icon = "Fas Fa-hands",
        label = Config.Text['Washing_Target'],
      },
    },
    distance = 3.0
  })
  exports['qb-target']:AddBoxZone("smelt", vector3(1086.38, -2003.69, 31.42), 3.8, 3, {
    name = "smelt",
    heading = 319,
    debugPoly = false,
    minZ = 31.42,
    maxZ = 32.22
  }, {
    options = {
      {
        type = "client",
        event = "tr-mining:smeltmenu",
        icon = "Fas Fa-hands",
        label = Config.Text['Smeth_Rocks'],
      },
    },
    distance = 1.5
  })
  exports['qb-target']:AddBoxZone("Seller", SellLocation.targetZone, 1, 1, {
    name = "Seller",
    heading = SellLocation.targetHeading,
    debugPoly = false,
    minZ = SellLocation.minZ,
    maxZ = SellLocation.maxZ,
  }, {
    options = {
      {
        type = "server",
        event = "tr-mining:Seller",
        icon = "Fas Fa-hands",
        label = Config.Text['Seller'],
      },
    },
    distance = 1.5
  })
end)
