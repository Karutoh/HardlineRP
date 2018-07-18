hook.Add("PhysgunPickup", "TRP_PropBlock", function (ply, ent)
    if !ent:IsPlayer() && ply:SteamID64() == ent:GetNWString("owner") then
        return true
    end

    return false
end)