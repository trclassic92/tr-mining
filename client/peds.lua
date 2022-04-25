local ClassicMiner = Config.Blips.MiningLocation.coords
local ClassicPed = MiningJob.Miner
local ClassicMHash = MiningJob.MinerHash
local ClasWashericPed = MiningJob.Washer
local notClasHashsic = MiningJob.WasherHash
local TRonTop = Config.Blips.WashLocation.coords
local ClassicSeller = Config.Blips.SellLocation.coords

CreateThread(function()
    RequestModel( GetHashKey( ClassicPed ) )
    while ( not HasModelLoaded( GetHashKey( ClassicPed ) ) ) do
        Wait(1)
    end
    RequestModel( GetHashKey( ClasWashericPed ) )
    while ( not HasModelLoaded( GetHashKey( ClasWashericPed ) ) ) do
        Wait(1)
    end
    Miner1 = CreatePed(1, ClassicMHash, ClassicMiner, false, true)
    Miner2 = CreatePed(1, notClasHashsic, TRonTop, false, true)
    Miner3 = CreatePed(1, ClassicMHash, ClassicSeller, false, true)
    SetEntityInvincible(Miner1, true)
    SetBlockingOfNonTemporaryEvents(Miner1, true)
    FreezeEntityPosition(Miner1, true)
    SetEntityInvincible(Miner2, true)
    SetBlockingOfNonTemporaryEvents(Miner2, true)
    FreezeEntityPosition(Miner2, true)
    SetEntityInvincible(Miner3, true)
    SetBlockingOfNonTemporaryEvents(Miner3, true)
    FreezeEntityPosition(Miner3, true)
end)