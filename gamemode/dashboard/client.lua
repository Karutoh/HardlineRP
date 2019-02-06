AddF4MenuTab("Dashboard", function (panel)

	local welcomeMessage = vgui.Create("DPanel", panel)
	welcomeMessage:SetPos(0, 0)
	welcomeMessage:SetSize(panel:GetWide(), 50)
	welcomeMessage.Paint = function()
		draw.RoundedBox(0, 0, 0, welcomeMessage:GetWide(), welcomeMessage:GetTall(), Color(51, 195, 255, 255))

		surface.SetFont("buttonFont")
		surface.SetTextColor(255, 255, 255, 255)

		local name = LocalPlayer():GetNWString("rpName")

		if name == nil || name == "" then
			name = "Unknown"
		end

		local message = "Welcome back, " .. name .. "!"
		local width, height = surface.GetTextSize(message)
		surface.SetTextPos(5, (welcomeMessage:GetTall() / 2) - (height / 2))
		surface.DrawText(message)
	end

end)