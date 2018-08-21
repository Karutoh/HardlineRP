hook.Add("HRP_SavePlayerData", "HRP_CacheMoney", function (ply)
    HRP.WriteVar(ply.data, HRP.DatabaseType.L, "holding", ply:GetNWInt("holding"))
    HRP.WriteVar(ply.data, HRP.DatabaseType.L, "bank", ply:GetNWInt("bank"))
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheMoney", function (ply)
    ply:SetNWInt("holding", HRP.ReadVar(ply.data, HRP.DatabaseType.L, "holding", 0))
    ply:SetNWInt("bank", HRP.ReadVar(ply.data, HRP.DatabaseType.L, "bank", 0))
end)

hook.Add("HRP_InitPlayerData", "HRP_InitMoney", function (ply)
    ply:SetNWInt("holding", 0)
    ply:SetNWInt("bank", 0)
end)