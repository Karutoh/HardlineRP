hook.Add("HRP_SavePlayerData", "HRP_CacheRpName", function (ply)
    WriteVar(ply.data, DatabaseType.STR, "rpName", ply:GetNWString("rpName"))
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheRpName", function (ply)
	ply:SetNWString("rpName", ReadVar(ply.data, DatabaseType.STR, "rpName", ""))
end)

hook.Add("HRP_InitPlayerData", "HRP_IniHRPName", function (ply)
    ply:SetNWString("rpName", "")
end)