local rpName = ""

local function OpenNewLifeName()
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
            if name:GetText() == LocalPlayer():GetNWString("rpName") then
                frame:SetVisible(false)

                local infoF = CreateMsgBox("You cannot use the last rp name.")
    
                function infoF:OnClose()
                    frame:SetVisible(true)
                end
            else
                frame:Close()

                net.Start("TRP_RpName")
                net.WriteString(LocalPlayer():SteamID64())
                net.WriteString(name:GetText())
                net.SendToServer()
            end
        else
            frame:SetVisible(false)

            local infoF = CreateMsgBox("You must enter a name to continue.")

            function infoF:OnClose()
                frame:SetVisible(true)
            end
        end
    end
end

net.Receive("TRP_New", OpenNewLifeName)