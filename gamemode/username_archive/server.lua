hook.Add("HRP_SavePlayerData", "HRP_CacheUsername", function (ply)
    WriteVar(ply.data, DatabaseType.STR, "username", ply:Nick())
end)