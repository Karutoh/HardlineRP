util.AddNetworkString("TRP_Loaded")
util.AddNetworkString("TRP_RpName")
util.AddNetworkString("TRP_New")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("new_life_name/client.lua")
AddCSLuaFile("jobs/client.lua")

include("shared.lua")
include("new_life_name/server.lua")
include("saved_data/server.lua")
include("jobs/server.lua")