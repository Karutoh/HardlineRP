AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("fonts.lua")
AddCSLuaFile("hud.lua")
--AddCSLuaFile("jobs/client.lua")
AddCSLuaFile("new_life_name/client.lua")
AddCSLuaFile("f4menu/client.lua")
AddCSLuaFile("entity_ownership/shared.lua")

include("shared.lua")
include("network_strings.lua")
--include("new_life_name/server.lua")
include("jobs/server.lua")
include("saved_data/server.lua")
include("administration/server.lua")
include("entity_ownership/server.lua")
include("entity_ownership/shared.lua")
include("jobs.lua")
include("f4menu/server.lua")

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

function GM:ShowSpare1( ply )
	net.Start( "TRP_EnableMouse" )
	net.Send( ply )
end

function GM:GravGunPunt( ply, ent )
	return false
end