include("shared.lua")
include("new_life_name/client.lua")

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