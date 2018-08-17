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

hook.Add("HRP_SavePlayerData", "HRP_CacheSkills", function (f, ply)
    f:WriteULong(ply:GetNWInt("level"))
    f:WriteULong(ply:GetNWInt("maxExp"))
    f:WriteULong(ply:GetNWInt("exp"))

	for i = 1, #skills do
		f:WriteByte(ply:GetNWInt(skills[i]))
	end
end)

hook.Add("HRP_LoadPlayerData", "HRP_CacheSkills", function (f, ply)
    ply:SetNWInt("level", f:ReadULong())
    ply:SetNWInt("maxExp", f:ReadULong())
    ply:SetNWInt("exp", f:ReadULong())
    
	for i = 1, #skills do
		ply:SetNWInt(skills[i], f:ReadByte())
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