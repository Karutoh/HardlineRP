include("shared.lua")
include("fonts.lua")
--include("jobs/client.lua")
include("new_life_name/client.lua")
include("f4menu/client.lua")
include("entity_ownership/shared.lua")

function CreateMsgBox(msg)
    local infoF = vgui.Create("DFrame")
    infoF:SetDeleteOnClose(true)
    infoF:SetBackgroundBlur(true)
    infoF:SetTitle("Information")
    infoF:SetSize(300, 100)
    infoF:Center()
    infoF:SetVisible(true)
    infoF:ShowCloseButton(true)
    infoF:MakePopup()

    local msgL = vgui.Create("DLabel", infoF)
    msgL:SetText(msg)
    msgL:SetSize(infoF:GetWide() - 10, 60)
    msgL:SetPos(infoF:GetWide() / 2 - msgL:GetWide() / 2, 10)
    msgL:SetWrap(true)

    return infoF
end

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

function GM:HUDPaint()
    DrawInfo()
end

local hide = {
	["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudCrosshair"] = true,
    ["CHudHealth"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end
end )

local mouseActive = false

net.Receive( "enablemouse", function( len, ply ) 
	if(!mouseActive) then
		gui.EnableScreenClicker( true )
		mouseActive = true
	else
		gui.EnableScreenClicker( false )
		mouseActive = false
	end
end)