hook.Add("TRP_LoadPlayerData", "TRP_LoadRpName", function (f, ply)
    ply:SetNWString("rpName", f:Read(f:ReadULong()))
end)

hook.Add("TRP_SavePlayerData", "TRP_SaveRpName", function (f, ply)
    local rpName = ply:GetNWString("rpName")
    f:WriteULong(string.len(rpName))
    f:Write(rpName)
end)

hook.Add("TRP_InitPlayerData", "TRP_InitRpName", function (ply)
    ply:SetNWString("rpName", "")
end)