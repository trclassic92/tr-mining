if Config.UseBlips then
    CreateThread(function()
        for k,v in pairs(Config.Blips) do
        local Blip = AddBlipForCoord(v.coords)
        SetBlipSprite (Blip, v.Sprite)
        SetBlipDisplay(Blip, v.Display)
        SetBlipScale  (Blip, v.Scale)
        SetBlipAsShortRange(Blip, true)
        SetBlipColour(Blip, v.Colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.Label)
        EndTextCommandSetBlipName(Blip)
        Config.Blips[k].blip = Blip
        end
    end)
end