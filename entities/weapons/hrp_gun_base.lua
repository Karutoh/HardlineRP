SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.PrintName = "HRP Gun Base"
SWEP.Base = "weapon_base"
SWEP.m_WeaponDeploySpeed = 1
SWEP.Author = "Arron (Karutoh) David Nelson"
SWEP.Contact = "Red-XIII@outlook.com"
SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.Slot = 0
SWEP.SlotPos = 10
SWEP.m_bPlayPickupSound = true
SWEP.aimingDownSights = false
SWEP.sightPos = Vector(-4.7, 0, 0.7)
SWEP.sightAng = Angle(-0.2, 0, -0.17)
SWEP.sightFOV = 40
SWEP.hipPos = Vector(0, 0, 0)
SWEP.hipAng = Angle(0, 0, 0)
SWEP.hipFOV = 62

SWEP.Primary.AttackSound = Sound("Weapon_357.Single")
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

if SERVER then
    SWEP.AutoSwitchFrom = false
    SWEP.AutoSwitchTo = true
    SWEP.Weight = 5
    SWEP.DisableDuplicator = true
end

if CLIENT then
    SWEP.Category = "HRP Sweps"
    SWEP.Purpose = "To be used as a base for Hardline RP."
    SWEP.Instructions = ""
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFlip1 = false
    SWEP.ViewModelFlip2 = false
    SWEP.ViewModelFOV = SWEP.hipFOV
    SWEP.BobScale = 2
    SWEP.SwayScale = 2
    SWEP.BounceWeaponIcon = true
    SWEP.DrawWeaponInfoBox = false
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
    SWEP.RenderGroup = RENDERGROUP_OPAQUE
    SWEP.SpeechBubbleLid = surface.GetTextureID("weapons/swep")
    SWEP.CSMuzzleFlashes = false
    SWEP.CSMuzzleX = false
    SWEP.AccurateCrosshair = false
    SWEP.ScriptedEntityType = "weapon"
    SWEP.UseHands = true

    function SWEP:CalcViewModelView(vm, oldPos, oldAng, pos, ang)
        local vec = self.hipPos
        local a = self.hipAng

        if self.aimingDownSights then
            vec = self.sightPos
            a = self.sightAng
        end

        pos = pos + ang:Right() * vec.x + ang:Forward() * vec.y + ang:Up() * vec.z
        ang:RotateAroundAxis(ang:Right(), a.x)
        ang:RotateAroundAxis(ang:Forward(), a.y)
        ang:RotateAroundAxis(ang:Up(), a.z)

        return pos, ang
    end
end

function SWEP:PrimaryAttack()
    self:EmitSound(self.Primary.AttackSound)
    self.Owner:ViewPunch(Angle(-20, 0, 0))
    self:ShootBullet(25, 1, 0)
    self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
end

function SWEP:SecondaryAttack()
    self.aimingDownSights = !self.aimingDownSights

    if CLIENT then
        if self.aimingDownSights then
            self.ViewModelFOV = self.sightFOV
        else
            self.ViewModelFOV = self.hipFOV
        end
    end

    self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
end