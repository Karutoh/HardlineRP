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
    surface.SetDrawColor(35, 39, 50, 255 * 0.75)
    surface.DrawRect(x, y, w, h)

    if mdl then
        mdl:SetPos(x + 5, y + 5)
        mdl:SetSize(w / 4, h - 10)
    end

    surface.SetDrawColor(35, 39, 50, 255)
    surface.DrawRect(x + w / 4, y, w * 0.75, 40)

    surface.SetFont("HUD")
    surface.SetTextColor(255, 255, 255)

    surface.SetTextPos(x + w / 4 + 5, y + 5)
    surface.DrawText("RP Name: " .. LocalPlayer():GetNWString("rpName"))

    surface.SetTextPos(x + w / 4 + 5, y + 20)
    surface.DrawText("AKA: " .. LocalPlayer():Name())

    surface.SetTextPos(x + w / 4 + 5, y + 45)
    surface.DrawText("Holding: $" .. LocalPlayer():GetNWInt("holding"))
    
    surface.SetTextPos(x + w / 4 + 5, y + 60)
    surface.DrawText("Bank: $" .. LocalPlayer():GetNWInt("bank"))
end

hook.Add("HUDPaint", "HRP_DrawHUD", function ()
    DrawInfo(10, ScrH() - 110, 300, 100)
end)

local hide = {
	["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudCrosshair"] = true,
    ["CHudHealth"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true
}

hook.Add("HUDShouldDraw", "HRP_HideHUD", function (name)
    if hide[name] then
        return false
    end
end)