include("shared.lua")
include("fonts.lua")
include("hud.lua")
include("database/shared.lua")
include("new_life_name/client.lua")
include("f4menu/client.lua")
include("dashboard/client.lua")
include("jobs/client.lua")
include("entity_ownership/shared.lua")
include("doors/shared.lua")
include("doors/client.lua")
include("skills/client.lua")
include("skills/shared.lua")
include("administration/client.lua")

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

net.Receive("HRP_EnableMouse", function(len, ply) 
	if(!mouseActive) then
		gui.EnableScreenClicker( true )
		mouseActive = true
	else
		gui.EnableScreenClicker( false )
		mouseActive = false
	end
end)

net.Receive("HRP_Notify", function()
	local str = net.ReadString()
	local duration = net.ReadInt(32)
	local NotifyType = string.lower(net.ReadString())

	if NotifyType == "error" then
		notification.AddLegacy(str, NOTIFY_ERROR, duration)
	elseif NotifyType == "undo" then
		notification.AddLegacy(str, NOTIFY_UNDO, duration)
	elseif NotifyType == "hint" then
		notification.AddLegacy(str, NOTIFY_HINT, duration)
	elseif NotifyType == "cleanup" then
		notification.AddLegacy(str, NOTIFY_CLEANUP, duration)
	else
		notification.AddLegacy(str, NOTIFY_GENERIC, duration)
	end
end)