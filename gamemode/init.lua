util.AddNetworkString("TRP_Loaded")
util.AddNetworkString("TRP_RpName")
util.AddNetworkString("TRP_New")
util.AddNetworkString( "enablemouse" )

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
--AddCSLuaFile("jobs/client.lua")
AddCSLuaFile("new_life_name/client.lua")
AddCSLuaFile("f4menu/client.lua")

include("shared.lua")
--include("new_life_name/server.lua")
include("jobs/server.lua")
include("saved_data/server.lua")
include("administration/server.lua")
include("f4menu/server.lua")
include("entity_ownership/server.lua")

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
	net.Start( "enablemouse" )
	net.Send( ply )
end