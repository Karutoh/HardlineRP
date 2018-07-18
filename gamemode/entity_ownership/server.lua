hook.Add("PlayerSpawnedProp", "TRP_PropOwnership", function (ply, mdl, ent)
    ent:SetNWString("owner", ply:SteamID64())
end)