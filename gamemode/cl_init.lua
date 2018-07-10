include("shared.lua")

local rpName = ""

local function CreateMsgBox(msg)
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

local function OpenNewLifeName()
    local infoMsg = ""

    local frame = vgui.Create("DFrame")
    frame:SetDeleteOnClose(true)
    frame:SetTitle("New Life Name")
    frame:SetSize(320, 160)
    frame:Center()
    frame:SetVisible(true)
    frame:ShowCloseButton(false)
    frame:MakePopup()

    local info = vgui.Create("DLabel", frame)
    info:SetText("New life name is a role playing name for each life. After you have died you will be assigned a new name. It cannot be the same as your last.")
    info:SetSize(frame:GetWide() - 10, 40)
    info:SetPos(frame:GetWide() / 2 - info:GetWide() / 2, 30)
    info:SetWrap(true)

    local name = vgui.Create("DTextEntry", frame)
    name:SetSize(frame:GetWide() - 10, 30)
    name:SetPos(frame:GetWide() / 2 - name:GetWide() / 2, 80)

    local submit = vgui.Create("DButton", frame)
    submit:SetText("Submit")
    submit:SetSize(frame:GetWide() / 2, 30)
    submit:SetPos(frame:GetWide() / 2 - submit:GetWide() / 2, 120)
    function submit:DoClick()
        if string.len(name:GetText()) > 0 then
            rpName = name:GetText()
            frame:Close()
        else
            frame:SetVisible(false)

            local infoF = CreateMsgBox("You must enter a name to continue.")

            function infoF:OnClose()
                frame:SetVisible(true)
            end
        end
    end
end

hook.Add("Initialize", "NewLifeName", OpenNewLifeName)