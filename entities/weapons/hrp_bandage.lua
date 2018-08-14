AddCSLuaFile()

SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
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

SWEP.PrintName = "Bandage"

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
	local max = self.Owner:GetMaxHealth()
	local amount = 20 * (self.Owner:GetNWInt("intelligence") / HRP.maxSkillCount:GetInt())
	local newHealth = self.Owner:Health() + amount

	if newHealth > max then newHealth = max end

	self.Owner:SetHealth(newHealth)

	self:Remove()
	
end

function SWEP:SecondaryAttack()
	return false
end
