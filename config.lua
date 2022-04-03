Config = Config or {}

Config.UseBlips = true                                              -- True / false option for toggling farm blips
Config.Timeout = 20 * (60 * 1000)                                   -- 20 minutes

--Blips Config
MiningLocation = {
    targetZone = vector3(-600.57, 2092.49, 130.33),                 -- qb-target vector
    targetHeading = 273.47,                                         -- qb-target box zone
    coords = vector4(-600.57, 2092.49, 130.33, 339.52),             -- Move Location (Ped and blip)
    SetBlipSprite = 414,                                            -- Blip Icon (https://docs.fivem.net/docs/game-references/blips/)
    SetBlipDisplay = 6,                                             -- Blip Behavior (https://docs.fivem.net/natives/?_0x9029B2F3DA924928)
    SetBlipScale = 0.85,                                            -- Blip Size
    SetBlipColour = 21,                                             -- Blip Color
    BlipLabel = "Mine Shaft",                                       -- Blip Label
    minZ = 129.42,                                                  -- Max Z
    maxZ = 132.42,                                                  -- Max Z
}
WashLocation = {
    targetZone = vector3(77.17, 3150.86, 28.79),
    targetHeading = 80.46,
    coords = vector4(77.17, 3150.86, 28.79, 80.46),
    SetBlipSprite = 162,
    SetBlipDisplay = 6,
    SetBlipScale = 0.85,
    SetBlipColour = 26,
    BlipLabel = "Mine Washing Location",
    minZ = 27,
    maxZ = 31,
}
SmeltLocation = {
    coords = vector4(1090.11, -1991.51, 32.27, 56.22),
    SetBlipSprite = 162,
    SetBlipDisplay = 6,
    SetBlipScale = 0.85,
    SetBlipColour = 36,
    BlipLabel = "Smelt Factory",
}
SellLocation = {
    targetZone = vector3(579.11, -2804.96, 5.06),
    targetHeading = 242.63,
    coords = vector4(579.11, -2804.96, 5.06, 242.63),
    SetBlipSprite = 431,
    SetBlipDisplay = 6,
    SetBlipScale = 0.85,
    SetBlipColour = 28,
    BlipLabel = "Material Seller",
    minZ = 3,
    maxZ = 7,
}
--Job Config
MiningJob = {
    Miner = "s_m_y_construct_02",                                   -- Ped model  https://wiki.rage.mp/index.php?title=Peds
    MinerHash = 0xC5FEFADE,                                         -- Hash numbers for ped model

    Washer = "ig_cletus",
    WasherHash = 0xE6631195,

    MiningTimer = 20 * 1000,                                        -- 20 second timer
    WashingTimer = 15 * 1000,                                       -- 15 second timer
    IronTimer = 25 * 1000,                                          -- 25 seconds
    CopperTimer = 30 * 1000,                                        -- 30 seconds
    GoldTimer = 35 * 1000,                                          -- 35 seconds

    PickAxePrice = 75,                                              -- PickAxe Price ($75)
    WashPanPrice = 5,                                               -- Washing Pan Price ($5)

    StoneMin = 3,                                                   -- Min amount from mining
    StoneMax = 6,                                                   -- Max amount from mining
    
    -- Washing Min And Max
    IronFragMin = 3,
    IronFragMax = 6,
    GoldNugMin = 1,
    GoldNugMax = 3,
    CopperFragMin = 4,
    CopperFragMax = 7,

    -- Smelting Min and Max
    SmeltIronMin = 7,
    SmeltIronMax = 10,
    SmeltCopperMin = 4,
    SmeltCooperMax = 7,
    SmeltGoldMin = 7,
    SmeltGoldMax = 10,

    -- Bars Received
    IronBarsMin = 1,
    IronBarsMax = 2,
    CopperBarsMin = 1,
    CopperBarsMax = 2,
    GoldBarsMin = 1,
    GoldBarsMax = 2,
}


vector4(77.17, 3150.86, 29.79, 80.46)
Config.MiningLocation = {
    [1] = {
        ["coords"] = vector3(-590.57, 2073.85, 131.3),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [2] = {
        ["coords"] = vector3(-591.0, 2063.64, 130.08),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [3] = {
        ["coords"] = vector3(-587.13, 2054.63, 130.33),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [4] = {
        ["coords"] = vector3(-587.07, 2043.96, 129.63),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [5] = {
        ["coords"] = vector3(-577.74, 2032.72, 128.58),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [6] = {
        ["coords"] = vector3(-573.13, 2023.77, 127.85),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [7] = {
        ["coords"] = vector3(-565.44, 2015.6, 127.49),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [8] = {
        ["coords"] = vector3(-554.67, 1999.82, 127.26),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [9] = {
        ["coords"] = vector3(-549.8, 1996.89, 127.06),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [10] = {
        ["coords"] = vector3(-544.97, 1988.73, 127.0),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [11] = {
        ["coords"] = vector3(-532.22, 1979.47, 126.99),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [12] = {
        ["coords"] = vector3(-517.84, 1980.41, 126.47),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [13] = {
        ["coords"] = vector3(-541.67, 1974.28, 126.98),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [14] = {
        ["coords"] = vector3(-542.82, 1961.31, 126.82),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
    [15] = {
        ["coords"] = vector3(-538.38, 1951.48, 126.19),
        ["isMined"] = false,
        ["isOccupied"] = false,
    },
}

Config.Sell = {
    ["mining_washedstone"] = {
        ["price"] = math.random(5, 10)                             -- Seller Price
    },
    ["mining_stone"] = {
        ["price"] = 2
    },
    ["mining_ironfragment"] = {
        ["price"] = math.random(35, 45)
    },
    ["mining_ironbar"] = {
        ["price"] = math.random(75, 90)
    },
    ["mining_goldnugget"] = {
        ["price"] = math.random(75, 80)
    },
    ["mining_goldbar"] = {
        ["price"] = math.random(110, 125)
    },
    ["mining_copperfragment"] = {
        ["price"] = math.random(25, 35)
    },
    ["mining_copperbar"] = {
        ["price"] = math.random(50, 65)
    },
}

--- Config Alerts
Config.Text = {
    ['itemamount'] = 'You are trying to process a amount that is invalid try again!',
    
    ['MenuHeading'] = 'Miner Boss',
    ['MenuPickAxe'] = 'Buy a pickaxe',
    ['PickAxeText'] = 'This item is used for mining Price $'..MiningJob.PickAxePrice,

    ["MenuTarget"] = 'Talk to miner boss',
    ["goback"] = '<- Go Back!',

    ['WashHeading'] = 'Pan Seller',
    ['MenuWashPan'] = 'Buy a pan',
    ['PanText'] = 'This item is used for washing stones Price $' ..MiningJob.WashPanPrice,
    ['Menu_pTarget'] = 'Talk to pan handler',

    ['SmethHeading'] = 'Smelt Options',
    ['Semlt_Iron'] = 'Smelt Iron Fragments',
    ['smelt_IText'] = 'Smelt Fragments into Iron Bars',
    ['Semlt_Copper'] = 'Smelt Copper Fragments',
    ['smelt_CText'] = 'Smelt Fragments into Copper Bars',
    ['Smelt_Gold'] = 'Smelt Gold Nuggets',
    ['smelt_GText'] = 'Smelt Nuggets into golden bars',

    ['Pickaxe_Bought'] = 'You have bought a pickaxe for $' ..MiningJob.PickAxePrice.. ' ... Good luck!',
    ['Pickaxe_Check'] = 'It looks like you already have a pickaxe',
    ['MiningAlert'] = 'My eye just caught something shiny',
    ['StartMining'] = '[E] Start Mining',

    ['error_mining'] = 'You dont have a pickaxe to start mining',
    ['Pan_Bought'] = 'You have bought a pan for $' ..MiningJob.WashPanPrice,
    ['Pan_check'] = 'You already have a pan',
    ['error_pan'] = 'You don\'t have a pan to do this',

    ['Mining_ProgressBar'] = 'Mining For ores',

    ['Washing_Target'] = 'Wash Stones',

    ['error_minerstone'] = 'You do not have any stones to wash',
    ['error_washpan'] = 'You need a washing pan to do this!',

    ['Washing_Rocks'] = 'Washing Stones',

    ['Smeth_Rocks'] = 'Smelt Rocks',
    
    ['smelt_iron'] = 'Smelting Iron Fragments',
    ['smelt_copper'] = 'Smelting Copper Fragments',
    ['smelt_gold'] = 'Smelting Gold Nuggets',

    ['cancel'] = 'You Cancelled the process',

    ['error_ironCheck'] = 'You don\'t have any Iron fragments to smelt',
    ['error_goldCheck'] = 'You don\'t have any Gold Nuggets to smelt',
    ['error_copperCheck'] = 'You don\'t have any Copper fragments to smelt',

    ['ironSmelted'] = 'You have smelted ',
    ['ironSmeltedMiddle'] = ' Amount of Iron Fragments for ',
    ['ironSmeltedEnd'] = ' Iron Bars',

    ['CopperSmelted'] = 'You have smelted ',
    ['CopperSmeltedMiddle'] = ' Amount of Copper Fragments for ',
    ['CopperSmeltedEnd'] = ' Copper Bars',

    ['GoldSmelted'] = 'You have smelted ',
    ['GoldSmeltedMiddle'] = ' Amount of Gold Nugget for ',
    ['GoldSmeltedEnd'] = ' Gold Bars',

    ['error_alreadymined'] = 'This has already been mined',

    ['Seller'] = 'Talk to buyer',
    ['successfully_sold'] = 'The buyer has bought the marterials',

}

