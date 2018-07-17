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
            if string.len(name:GetText()) > 64 then
                frame:SetVisible(false)

                local infoF = CreateMsgBox("You cannot use a name larger than 64 characters.")
    
                function infoF:OnClose()
                    frame:SetVisible(true)
                end
            else
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

hook.Add("PostPlayerDraw", "TRP_RpNameplate", function (ply)
    if !IsValid(ply) then
        return
    end

    if ply == LocalPlayer() then
        return
    end

    if !ply:Alive() then
        return
    end

	local Distance = LocalPlayer():GetPos():Distance(ply:GetPos())

	if Distance < 1000 then

		local offset = Vector(0, 0, 85)
		local ang = LocalPlayer():EyeAngles()
		local pos = ply:GetPos() + offset + ang:Up()

		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), 90)


        cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.25)
            local plate = ply:GetNWString("rpName")
            if ply:GetFriendStatus() == "friend" then
                plate = plate .. " - (a.k.a. " .. ply:Name() .. ")"
            end
			
			local w, h = surface.GetTextSize(plate)
			
            surface.SetDrawColor(0, 0, 0, 127)
            surface.DrawRect(-w / 2 - 5, -5, w + 10, h + 10)

            surface.SetFont("HudSelectionText")
            local w, h = surface.GetTextSize(plate)

            surface.SetTextColor(255, 255, 255)
            surface.SetTextPos(-w / 2, 0)
            surface.DrawText(plate)

		cam.End3D2D()
	end
end)