local skills = {
    "strength", 
    "perception", 
    "endurance",
    "charisma", 
    "intelligence", 
    "agility",
	"luck"
}

function HRP.GetSkills()
	return skills
end

hook.Add("HRP_SavePlayerData", "HRP_CacheSkills", function (ply)
    HRP.WriteVar(ply.data, HRP.DatabaseType.UL, "level", ply:GetNWInt("level"))
    HRP.WriteVar(ply.data, HRP.DatabaseType.UL, "maxExp", ply:GetNWInt("maxExp"))
    HRP.WriteVar(ply.data, HRP.DatabaseType.UL, "exp", ply:GetNWInt("exp"))

    for i = 1, #skills do
        HRP.WriteVar(ply.data, HRP.DatabaseType.UL, skills[i], ply:GetNWInt(skills[i]))
	end
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheSkills", function (ply)
    ply:SetNWInt("level", HRP.ReadVar(ply.data, HRP.DatabaseType.UL, "level", 1))
    ply:SetNWInt("maxExp", HRP.ReadVar(ply.data, HRP.DatabaseType.UL, "maxExp", 100))
    ply:SetNWInt("exp", HRP.ReadVar(ply.data, HRP.DatabaseType.UL, "exp", 0))
    
	for i = 1, #skills do
		ply:SetNWInt(skills[i], HRP.ReadVar(ply.data, HRP.DatabaseType.UL, skills[i], 1))
	end
end)

hook.Add("HRP_InitPlayerData", "HRP_InitSkills", function (ply)
    ply:SetNWInt("level", 1)
    ply:SetNWInt("maxExp", 100)
    ply:SetNWInt("exp", 0)
    
	for i = 1, #skills do
		ply:SetNWInt(skills[i], 1)
	end
end)