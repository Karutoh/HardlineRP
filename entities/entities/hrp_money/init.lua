AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:OnInitialize()
	
end

function ENT:OnUse(ply)
	ply:SetNWInt("money", ply:GetNWInt("money") + (self:GetNWInt("amount") or 0))
	HRP.NotifyPlayer(ply, "You have picked up $" .. (self:GetNWInt("amount") or 0) .. "!", 2, "hint")
	self:Remove()
end