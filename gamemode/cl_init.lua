include("shared.lua")
include("fonts.lua")
include("hud.lua")
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

local mouseActive = false

net.Receive( "TRP_EnableMouse", function( len, ply ) 
	if(!mouseActive) then
		gui.EnableScreenClicker( true )
		mouseActive = true
	else
		gui.EnableScreenClicker( false )
		mouseActive = false
	end
end)