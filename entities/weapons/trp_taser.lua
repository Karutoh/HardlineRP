AddCSLuaFile()

SWEP.ViewModel = Model("models/weapons/v_pistol.mdl")
SWEP.WorldModel = Model("models/weapons/w_pistol.mdl")

SWEP.Author = "Scott"
SWEP.Contact = "N/A"
SWEP.Purpose = "N/A"

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 256
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "256"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo	= "none"

SWEP.Category = "TRP Sweps"

SWEP.PrintName = "Taser"

SWEP.Slot = 5
SWEP.SlotPos = 1
SWEP.Base = "weapon_base"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.TaserSound = Sound("taser.wav")
SWEP.DropWeapon = true
SWEP.Duration = 15
SWEP.Distance = 256

function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace()
	local ent = trace.Entity
	if ent:IsWorld() || !ent:IsPlayer() || !ent:IsNPC() || trace.StartPos:Distance(trace.HitPos) > self.Distance then return false end

	if CLIENT then
		if(IsFirstTimePredicted())then
			local data = EffectData()
			data:SetOrigin(trace.HitPos)
			data:SetNormal(trace.HitNormal)
			data:SetMagnitude(1.3)
			data:SetScale(2)
			data:SetRadius(1.2)
			util.Effect("Sparks", data)
		end
	end

	if CLIENT then return end

    self:SetNextPrimaryFire(CurTime() + 5)

	self.Owner:EmitSound(self.TaserSound)

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    if ent:IsWorld() then return end

	local dist = trace.StartPos:Distance(trace.HitPos)
	if ent:IsNPC() then
		if ent:GetNWBool("TRP_tased") then return end
		if dist > self.Distance then return end
		ent:SetNWBool("TRP_tased", true)
		local weapon = ent:GetActiveWeapon()
		ent:TakeDamage(0, self.Owner, self)
		weapon:SetNextPrimaryFire(CurTime() + self.Duration)
		local ragdoll = ents.Create("prop_ragdoll")
		ragdoll:SetPos(ent:GetPos())
		ragdoll:SetAngles(ent:GetAngles())
		ragdoll:SetModel(ent:GetModel())
		ragdoll:SetVelocity(ent:GetVelocity())
		ragdoll:Spawn()
		ragdoll:Activate()
		ent:SetParent(ragdoll)
		ent:SetNoDraw(true)
		timer.Simple(self.Duration, function()
			ent:SetParent()
			ent:Spawn()
			local pos = ragdoll:GetPos()
			pos.z = pos.z + 10
			ent:SetPos(pos)
			ragdoll:Remove()
			weapon:SetNextPrimaryFire(CurTime())
			ent:SetNoDraw(false)
			ent:SetNWBool("TRP_tased", false)
		end)
	end

	if ent:IsNPC() then return end

    if ent:IsPlayer() then
        if ent:GetNWBool("TRP_tased") then return end
        if dist > self.Distance then return end
        local weapon = ent:GetActiveWeapon()
        
        ent:SetNWBool("TRP_tased", true)
       
        ent:ViewPunch( Angle(-10, 0, 0))
        ent:PrintMessage(HUD_PRINTTALK, "You have been tased, you will be disabled temporarily")

        ent:TakeDamage(0, self.Owner, self)

        if(self.DropWeapon) then
            ent:DropWeapon(ent:GetActiveWeapon())
        end

        weapon:SetNextPrimaryFire(CurTime() + self.Duration)

        ent:EmitSound(Sound("player/pl_pain" .. math.random(5, 7) .. ".wav"))

        ent:DrawViewModel(false)
        
        local ragdoll = ents.Create("prop_ragdoll")
        ragdoll:SetPos(ent:GetPos())
        ragdoll:SetAngles(ent:GetAngles())
        ragdoll:SetModel(ent:GetModel())
        ragdoll:SetVelocity(ent:GetVelocity())
        ragdoll:Spawn()
        ragdoll:Activate()
        
        ent:SetParent(ragdoll)
        
        ent:ScreenFade(SCREENFADE.IN, Color(230, 230, 230), 0.7, 1.4)
        
        ent:Spectate(OBS_MODE_CHASE)
        ent:SpectateEntity(ragdoll)
        if timer.Exists("TaserTimer") then timer.Destroy("TaserTimer") end
        timer.Simple(self.Duration, function()
            
            ent:UnSpectate()
            ent:SetParent()
            
            ent:Spawn()
            local pos = ragdoll:GetPos()
          
            pos.z = pos.z + 10
            ent:SetPos(pos)
          
            ragdoll:Remove()
         
            ent:DrawViewModel(true)
          
            if IsValid(weapon) then
				weapon:SetNextPrimaryFire(CurTime())
			end
       
            ent:SetNWBool("TRP_tased", false)
        end)
    end
end

function SWEP:SecondaryAttack()
	return false
end