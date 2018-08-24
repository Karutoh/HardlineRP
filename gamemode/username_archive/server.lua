hook.Add("HRP_SavePlayerData", "HRP_CacheUsername", function (ply)
    HRP.WriteVar(ply.data, HRP.DatabaseType.STR, "username", ply:Nick())
end)