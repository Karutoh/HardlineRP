local function DrawInfo()
    surface.SetDrawColor(0, 0, 0, 127)
    surface.DrawRect(10, ScrH() - 110, 200, 100)

    surface.SetFont("HUD")
    surface.SetTextColor(255, 255, 255)
    surface.SetTextPos(15, ScrH() - 105)
    surface.DrawText("Steam Name: " .. LocalPlayer():Name())

    surface.SetTextPos(15, ScrH() - 90)
    surface.DrawText("RP Name: " .. LocalPlayer():GetNWString("rpName"))
end

hook.Add("HUDPaint", "TRP_DrawHUD", function ()
    DrawInfo()
end)

local hide = {
	["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudCrosshair"] = true,
    ["CHudHealth"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true
}

hook.Add("HUDShouldDraw", "TRP_HideHUD", function (name)
    if hide[name] then
        return false
    end
end)