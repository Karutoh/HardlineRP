AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "HRP Base Entity"
ENT.Author = "Scott"
ENT.Spawnable = false

ENT.Model = "models/xqm/boxfull.mdl"

function ENT:Initialize()
	if SERVER then
		self:SetModel( self.Model )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetPos(self:GetPos() + Vector(0, 0, 100))
	end

	if self.OnInitialize then
		self:OnInitialize()
	end
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnInitialize()
end

function ENT:Use(ply)
	if !ply:KeyPressed(IN_USE) then return end
	self:OnUse(ply)
end

function ENT:Wake()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() end
end

function ENT:Freeze()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then phys:EnableMotion(false) end
end

function ENT:OnTakeDamage(dmg)
	self:TakePhysicsDamage(dmg)
end

function ENT:OnUse(ply)
end
