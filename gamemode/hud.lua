local mdl = mdl or nil

hook.Add("InitPostEntity", "HRP_InitHUD", function ()
    mdl = vgui.Create("DModelPanel")
    mdl:SetModel(LocalPlayer():GetModel())

    --[[
    function mdl:LayoutEntity(Entity)
        return
    end
    ]]--

    function mdl.Entity:GetPlayerColor()
        return LocalPlayer():GetPlayerColor()
    end
end)

local function DrawInfo(x, y, w, h)
    surface.SetFont("Level")
    surface.SetTextColor(255, 255, 255)

    local lvl = "Lvl. " .. LocalPlayer():GetNWInt("level")
    local lStrW, lStrH = surface.GetTextSize(lvl)

    surface.SetTextPos(x, y - lStrH)
    surface.DrawText("Lvl. " .. LocalPlayer():GetNWInt("level"))

    surface.SetFont("HUD")

    surface.SetDrawColor(35, 39, 50, 255 * 0.75)
    surface.DrawRect(x, y, w, h)

    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawOutlinedRect(x, y, w / 4, h - 55)

    if mdl then
        mdl:SetPos(x + 5, y + 5)
        mdl:SetSize(w / 4, h - 55)
    end

    surface.SetDrawColor(35, 39, 50, 255)
    surface.DrawRect(x + w / 4, y, w * 0.75, 40)

    surface.SetTextPos(x + w / 4 + 5, y + 5)
    surface.DrawText("RP Name: " .. LocalPlayer():GetNWString("rpName"))

    surface.SetTextPos(x + w / 4 + 5, y + 20)
    surface.DrawText("AKA: " .. LocalPlayer():Name())

    surface.SetTextPos(x + w / 4 + 5, y + 45)
    surface.DrawText("Holding: $" .. LocalPlayer():GetNWInt("holding"))
    
    surface.SetTextPos(x + w / 4 + 5, y + 60)
    surface.DrawText("Bank: $" .. LocalPlayer():GetNWInt("bank"))

    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(x + 5, y + (h - 50), w - 10, 20)

    local hW = (LocalPlayer():Health() / LocalPlayer():GetMaxHealth()) * (w - 14)

    surface.SetDrawColor(255, 0, 0, 255)
    surface.DrawRect(x + 7, y + (h - 48), hW, 16)

    local health = LocalPlayer():Health() .. " / " .. LocalPlayer():GetMaxHealth() .. " [" .. (LocalPlayer():Health() / LocalPlayer():GetMaxHealth()) * 100 .. "%]"
    local hStrW, hStrH = surface.GetTextSize(health)

    surface.SetTextPos(x + w / 2 - hStrW / 2, y + (h - 50) + hStrH / 4)
    surface.DrawText(health)

    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(x + 5, y + (h - 25), w - 10, 20)

    local sW = (LocalPlayer():GetNWInt("stamina") / LocalPlayer():GetNWInt("maxStamina")) * (w - 14)

    surface.SetDrawColor(0, 255 * 0.75, 0, 255)
    surface.DrawRect(x + 7, y + (h - 23), sW, 16)

    local stamina = math.Round(LocalPlayer():GetNWInt("stamina")) .. " / " .. math.Round(LocalPlayer():GetNWInt("maxStamina")) .. " [" .. math.Round((LocalPlayer():GetNWInt("stamina") / LocalPlayer():GetNWInt("maxStamina")) * 100) .. "%]"
    local sStrW, sStrH = surface.GetTextSize(stamina)

    surface.SetTextPos(x + w / 2 - sStrW / 2, y + (h - 25) + sStrH / 4)
    surface.DrawText(stamina)
end

local function DrawExpBar(x, y, w, h)
    surface.SetDrawColor(35, 39, 50, 255 * 0.75)
    surface.DrawRect(x, y, w, h)

    local expW = (LocalPlayer():GetNWInt("exp") / LocalPlayer():GetNWInt("maxExp")) * (w - 4)

    surface.SetDrawColor(255, 211, 0, 255)
    surface.DrawRect(x + 2, y + 2, expW, h - 4)

    surface.SetFont("ExpBar")

    local exp = LocalPlayer():GetNWInt("exp") .. " / " .. LocalPlayer():GetNWInt("maxExp") .. " [" .. (LocalPlayer():GetNWInt("exp") / LocalPlayer():GetNWInt("maxExp")) * 100 .. "%]"
    local eStrW, eStrH = surface.GetTextSize(exp)

    surface.SetTextPos(x + w / 2 - eStrW / 2, y - eStrH - 10)
    surface.DrawText(exp)
end

hook.Add("HUDPaint", "HRP_DrawHUD", function ()
    DrawInfo(10, ScrH() - 180, 300, 150)
    DrawExpBar(10, ScrH() - 20, ScrW() - 20, 10)
end)

local hide = {
	["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudCrosshair"] = true,
    ["CHudHealth"] = true,
    --["CHudAmmo"] = true,
    --["CHudSecondaryAmmo"] = true
}

hook.Add("HUDShouldDraw", "HRP_HideHUD", function (name)
    if hide[name] then
        return false
    end
end)