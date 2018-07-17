util.AddNetworkString("TRP_Loaded")
util.AddNetworkString("TRP_RpName")
util.AddNetworkString("TRP_New")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
--AddCSLuaFile("jobs/client.lua")
AddCSLuaFile("new_life_name/client.lua")

include("shared.lua")
--include("new_life_name/server.lua")
include("jobs/server.lua")
include("saved_data/server.lua")
include("administration/server.lua")

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