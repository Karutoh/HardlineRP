hook.Add("HRP_SavePlayerData", "HRP_CacheMoney", function (f, ply)
    f:WriteLong(ply:GetNWInt("money"))
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheMoney", function (f, ply)
    ply:SetNWInt("money", f:ReadLong())
end)

hook.Add("HRP_InitPlayerData", "HRP_InitMoney", function (ply)
    ply:SetNWInt("money", 0)
end)