hook.Add("HRP_SavePlayerData", "HRP_CacheRpName", function (ply)
    HRP.WriteVar(ply.data, HRP.DatabaseType.STR, "rpName", rpName)
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheRpName", function (ply)
	ply:SetNWString("rpName", HRP.ReadVar(ply.data, HRP.DatabaseType.STR, "rpName", ""))
end)

hook.Add("HRP_InitPlayerData", "HRP_IniHRPName", function (ply)
    ply:SetNWString("rpName", "")
end)