AddCSLuaFile()

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.UseHands = true
SWEP.isDroppable = false

SWEP.Author = "Scott"
SWEP.Contact = "N/A"
SWEP.Purpose = "N/A"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Category = "HRP Sweps"

SWEP.PrintName = "Handcuffs"

SWEP.Slot = 5
SWEP.SlotPos = 1
SWEP.Base = "weapon_base"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Distance = 256
SWEP.Delay = 2

function SWEP:Initialize()

	self:SetHoldType( "fist" )

end

function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace()
	local ent = trace.Entity

	if ent:GetNWFloat("HRP_handcuffedDelay") != nil && ent:GetNWFloat("HRP_handcuffedDelay") > CurTime() then
		return false
	end

	if !ent:IsPlayer() || trace.StartPos:Distance(trace.HitPos) > self.Distance then return false end

	if !ent:GetNWBool("HRP_handcuffed") then
		if SERVER then 
			ent:SetNWBool("HRP_handcuffed", true) 
			ent:SetNWFloat("HRP_handcuffedDelay", CurTime() + self.Delay)
		end

		if CLIENT then
			self.Owner:PrintMessage(HUD_PRINTTALK, "Player has been cuffed!")
		end

		if SERVER then 
			tbl = ent:GetWeapons()
			ent:SetNWString("HRP_PlayerCuffedWeapons", createString(tbl))
			ent:StripWeapons() 
			ent:PrintMessage(HUD_PRINTTALK, "You have been handcuffed!")
		end
	else
		if SERVER then 
			ent:SetNWBool("HRP_handcuffed", false)
			ent:SetNWFloat("HRP_handcuffedDelay", CurTime() + self.Delay)
		end

		if CLIENT then
			self.Owner:PrintMessage(HUD_PRINTTALK, "Player has been uncuffed!")
		end

		if SERVER then

			tbl = string.Split(ent:GetNWString("HRP_PlayerCuffedWeapons"), ",")

			for i = 1, #tbl do
				ent:Give(tbl[i])
			end

			ent:PrintMessage(HUD_PRINTTALK, "You have been uncuffed and all your weapons have been restored!")
		end

		
	end
	
end

function SWEP:SecondaryAttack()
	return false
end

function createString(tbl) 
	local text = ""
	for i = 1, #tbl do
		if i == #tbl then
			text = text .. tbl[i]:GetClass()
		else
			text = text .. tbl[i]:GetClass() .. ","
		end
	end
	return text
end

