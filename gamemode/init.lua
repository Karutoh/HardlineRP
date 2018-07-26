AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("fonts.lua")
AddCSLuaFile("hud.lua")
--AddCSLuaFile("jobs/client.lua")
AddCSLuaFile("new_life_name/client.lua")
AddCSLuaFile("f4menu/client.lua")
AddCSLuaFile("f4menu/jobs.lua")
AddCSLuaFile("entity_ownership/shared.lua")

include("shared.lua")
include("resources.lua")

HRP.defaultJobs = true

include("network_strings.lua")
include("jobs/server.lua")
include("default_jobs.lua")
--include("new_life_name/server.lua")
include("saved_data/server.lua")
include("administration/server.lua")
include("entity_ownership/server.lua")
include("entity_ownership/shared.lua")
include("new_life_name/server.lua")
include("f4menu/server.lua")
include("money/server.lua")
include("skills/server.lua")
include("default_commands.lua")

function HRP.CheckDir()
    if !file.Exists("HRP", "DATA") then
        file.CreateDir("HRP")
        file.CreateDir("HRP/player_data")
        return false
    elseif !file.Exists("HRP/player_data", "DATA") then
        file.CreateDir("HRP/player_data")
        return false
    end

    return true
end

function GM:ShowSpare1(ply)
	net.Start( "HRP_EnableMouse" )
	net.Send( ply )
end

function GM:GravGunPunt(ply, ent)
	return false
end

function GM:PlayerDeath(victim, inflictor, attacker) 
	victim:SetNWBool("HRP_tased", false)
	victim:SetNWBool("HRP_handcuffed", false)
	victim:SetNWString("HRP_PlayerCuffedWeapons", "")
end

function GM:PlayerInitialSpawn(ply)
	ply:SetNWBool("HRP_tased", false)
	ply:SetNWBool("HRP_handcuffed", false)
	ply:SetNWString("HRP_PlayerCuffedWeapons", "")

end

function GM:AllowPlayerPickup(ply, ent)
	if ply:GetNWBool("HRP_handcuffed") == true then
		ply:PrintMessage(HUD_PRINTTALK, "You are currently handcuffed!")
		return false 
	end
	return true
end

function GM:PlayerCanPickupItem( ply, item )
	if ply:GetNWBool("HRP_handcuffed") == true then
		ply:PrintMessage(HUD_PRINTTALK, "You are currently handcuffed!")
		return false 
	end
	return true
end

function GM:PlayerCanPickupWeapon( ply, wep )
	if ply:GetNWBool("HRP_handcuffed") == true then
		ply:PrintMessage(HUD_PRINTTALK, "You are currently handcuffed!")
		return false 
	end
	return true
end

function GM:PlayerSpawnProp( ply, model )
	if ply:GetNWBool("HRP_handcuffed") == true then
		ply:PrintMessage(HUD_PRINTTALK, "You are currently handcuffed!")
		return false 
	end
	return true
end