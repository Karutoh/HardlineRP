hook.Add("HRP_SavePlayerData", "HRP_CacheRpName", function (f, ply)
    local rpName = ply:GetNWString("rpName")
    f:WriteULong(string.len(rpName))
    f:Write(rpName)
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheRpName", function (f, ply)
	if !f:ReadULong() then return false end
	ply:SetNWString("rpName", f:Read(f:ReadULong()))
end)

hook.Add("HRP_InitPlayerData", "HRP_IniHRPName", function (ply)
    ply:SetNWString("rpName", "")
end)