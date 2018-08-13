hook.Add("HRP_SavePlayerData", "HRP_CacheMoney", function (f, ply)
    f:WriteLong(ply:GetNWInt("holding"))
    f:WriteLong(ply:GetNWInt("bank"))
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheMoney", function (f, ply)
    ply:SetNWInt("holding", f:ReadLong())
    ply:SetNWInt("bank", f:ReadLong())
end)

hook.Add("HRP_InitPlayerData", "HRP_InitMoney", function (ply)
    ply:SetNWInt("holding", 0)
    ply:SetNWInt("bank", 0)
end)