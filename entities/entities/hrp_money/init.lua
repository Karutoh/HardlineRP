AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:OnInitialize()
	self:SetNWInt("amount", 100)
end

function ENT:OnUse(ply)
	ply:SetNWInt("holding", ply:GetNWInt("holding") + self:GetNWInt("amount"))
	NotifyPlayer(ply, "You have picked up $" .. self:GetNWInt("amount") .. "!", 2, "hint")
	self:Remove()
end