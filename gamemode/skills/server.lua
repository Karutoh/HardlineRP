local skills = {
    "strength", 
    "perception", 
    "endurance",
    "charisma", 
    "intelligence", 
    "agility",
	"luck"
}

function GetSkills()
	return skills
end

hook.Add("HRP_SavePlayerData", "HRP_CacheSkills", function (ply)
    WriteVar(ply.data, DatabaseType.UL, "level", ply:GetNWInt("level"))
    WriteVar(ply.data, DatabaseType.UL, "maxExp", ply:GetNWInt("maxExp"))
    WriteVar(ply.data, DatabaseType.UL, "exp", ply:GetNWInt("exp"))

    for i = 1, #skills do
        WriteVar(ply.data, DatabaseType.UL, skills[i], ply:GetNWInt(skills[i]))
	end
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheSkills", function (ply)
    ply:SetNWInt("level", ReadVar(ply.data, DatabaseType.UL, "level", 1))
    ply:SetNWInt("maxExp", ReadVar(ply.data, DatabaseType.UL, "maxExp", 100))
    ply:SetNWInt("exp", ReadVar(ply.data, DatabaseType.UL, "exp", 0))
    
	for i = 1, #skills do
		ply:SetNWInt(skills[i], ReadVar(ply.data, DatabaseType.UL, skills[i], 1))
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