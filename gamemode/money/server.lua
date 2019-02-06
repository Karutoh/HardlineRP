hook.Add("HRP_SavePlayerData", "HRP_CacheMoney", function (ply)
    WriteVar(ply.data, DatabaseType.L, "holding", ply:GetNWInt("holding"))
    WriteVar(ply.data, DatabaseType.L, "bank", ply:GetNWInt("bank"))
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheMoney", function (ply)
    ply:SetNWInt("holding", ReadVar(ply.data, DatabaseType.L, "holding", 0))
    ply:SetNWInt("bank", ReadVar(ply.data, DatabaseType.L, "bank", 0))
end)

hook.Add("HRP_InitPlayerData", "HRP_InitMoney", function (ply)
    ply:SetNWInt("holding", 0)
    ply:SetNWInt("bank", 0)
end)