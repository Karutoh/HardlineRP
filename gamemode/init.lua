AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("fonts.lua")
AddCSLuaFile("hud.lua")
--AddCSLuaFile("jobs/client.lua")
AddCSLuaFile("new_life_name/client.lua")
AddCSLuaFile("f4menu/client.lua")
AddCSLuaFile("entity_ownership/shared.lua")

include("shared.lua")
include("resources.lua")

TRP.defaultJobs = true

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

function TRP.CheckDir()
    if !file.Exists("trp", "DATA") then
        file.CreateDir("trp")
        file.CreateDir("trp/player_data")
        return false
    elseif !file.Exists("trp/player_data", "DATA") then
        file.CreateDir("trp/player_data")
        return false
    end

    return true
end

function GM:ShowSpare1(ply)
	net.Start( "TRP_EnableMouse" )
	net.Send( ply )
end

function GM:GravGunPunt(ply, ent)
	return false
end

function GM:PlayerDeath(victim, inflictor, attacker) 
	victim:SetNWBool("TRP_tased", false)
	victim:SetNWBool("TRP_handcuffed", false)
	victim:SetNWString("TRP_PlayerCuffedWeapons", "")
end

function GM:PlayerInitialSpawn(ply)
	ply:SetNWBool("TRP_tased", false)
	ply:SetNWBool("TRP_handcuffed", false)
	ply:SetNWString("TRP_PlayerCuffedWeapons", "")

end

function GM:AllowPlayerPickup(ply, ent)
	if ply:GetNWBool("TRP_handcuffed") == true then
		ply:PrintMessage(HUD_PRINTTALK, "You are currently handcuffed!")
		return false 
	end
	return true
end

function GM:PlayerCanPickupItem( ply, item )
	if ply:GetNWBool("TRP_handcuffed") == true then
		ply:PrintMessage(HUD_PRINTTALK, "You are currently handcuffed!")
		return false 
	end
	return true
end

function GM:PlayerCanPickupWeapon( ply, wep )
	if ply:GetNWBool("TRP_handcuffed") == true then
		ply:PrintMessage(HUD_PRINTTALK, "You are currently handcuffed!")
		return false 
	end
	return true
end

function GM:PlayerSpawnProp( ply, model )
	if ply:GetNWBool("TRP_handcuffed") == true then
		ply:PrintMessage(HUD_PRINTTALK, "You are currently handcuffed!")
		return false 
	end
	return true
end