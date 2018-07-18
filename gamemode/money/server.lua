hook.Add("TRP_LoadPlayerData", "TRP_LoadMoney", function (f, ply)
    ply:SetNWInt("money", f:ReadLong())
end)

hook.Add("TRP_SavePlayerData", "TRP_SaveMoney", function (f, ply)
    f:WriteLong(ply:GetNWInt("money"))
end)

hook.Add("TRP_InitPlayerData", "TRP_InitMoney", function (ply)
    ply:SetNWInt("money", 0)
end)