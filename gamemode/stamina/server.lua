maxStaminaDepletion = CreateConVar("hrp_maxstaminadepletion", 15, FCVAR_ARCHIVE)
maxStaminaRepletion = CreateConVar("hrp_maxstaminarepletion", 5, FCVAR_ARCHIVE)

local moving = {}

hook.Add("PlayerSpawn", "HRP_InitStamina", function (ply)
    ply:SetNWInt("maxStamina", 100)
    ply:SetNWInt("stamina", ply:GetNWInt("maxStamina"))
end)

hook.Add("KeyPress", "HRP_StaminaMoveP", function (ply, key)
    if key == IN_FORWARD || key == IN_BACK || IN_MOVELEFT || IN_MOVERIGHT then
        table.insert(moving, key)
    end
end)

hook.Add("KeyRelease", "HRP_StaminaMoveR", function (ply, key)
    if key == IN_FORWARD || key == IN_BACK || IN_MOVELEFT || IN_MOVERIGHT then
        table.RemoveByValue(moving, key)
    end
end)

hook.Add("Tick", "HRP_DepleteStamina", function ()
    for i = 1, #player.GetAll() do
        local ply = player.GetAll()[i]
        if ply:IsSprinting() && #moving > 1 then
            if ply:GetNWInt("stamina") > 0 then
                ply:SetRunSpeed(400)

                ply:SetNWInt("stamina", ply:GetNWInt("stamina") - (maxStaminaDepletion:GetInt() - ((ply:GetNWInt("agility") / maxSkillCount:GetInt()) * (maxStaminaDepletion:GetInt() * 0.75))) * FrameTime())
                
                if ply:GetNWInt("stamina") <= 0 then
                    ply:SetRunSpeed(ply:GetWalkSpeed())

                    ply:SetNWInt("stamina", 0)
                end
            end
        else
            if ply:GetNWInt("stamina") <= ply:GetNWInt("maxStamina") then
                ply:SetNWInt("stamina", ply:GetNWInt("stamina") + ((ply:GetNWInt("agility") / maxSkillCount:GetInt()) * maxStaminaRepletion:GetInt()) * FrameTime())

                if ply:GetNWInt("stamina") > ply:GetNWInt("maxStamina") then
                    ply:SetNWInt("stamina", ply:GetNWInt("maxStamina"))
                end
            end
        end
    end
end)