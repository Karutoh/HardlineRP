local function JobPanelClick(category, title, rank)
	net.Start("HRP_F4MenuSetJob")
		net.WriteString(category)
		net.WriteString(title)
		net.WriteString(rank)
	net.SendToServer()
end

HRP.AddF4MenuTab("Jobs", function (panel)
	
	for i = 1, #HRP.jobsTable do
		local cat = vgui.Create("DPanel", panel)
		cat:SetSize(panel:GetWide(), 50)
		cat:Dock(TOP)

		cat.Paint = function()
			
			draw.RoundedBox(0, 0, 0, cat:GetWide(), cat:GetTall(), Color(93, 48, 148, 255))

			surface.SetFont("buttonFont")
			surface.SetTextColor(255, 255, 255, 255)
			local width, height = surface.GetTextSize(HRP.jobsTable[i].title)
			surface.SetTextPos(10, (cat:GetTall() / 2) - (height / 2))
			surface.DrawText(HRP.jobsTable[i].title)

		end

		for j = 1, #HRP.jobsTable[i].jobTitles do
			local job = vgui.Create("DButton", panel)
			job:SetSize(panel:GetWide(), 100)
			job:Dock(TOP)
			job:SetText("")

			job.Paint = function()
				
				if !job:IsHovered() then
					draw.RoundedBox(0, 0, 0, job:GetWide(), job:GetTall(), Color(0, 0, 0, 255))
				else
					draw.RoundedBox(0, 0, 0, job:GetWide(), job:GetTall(), Color(255, 255, 255, 255))
				end
				draw.RoundedBox(0, 2, 2, job:GetWide()-4, job:GetTall()-4, Color(18, 6, 64, 255))

				surface.SetFont("buttonFont")
				surface.SetTextColor(255, 255, 255, 255)
				local width, height = surface.GetTextSize(HRP.jobsTable[i].jobTitles[j].title)
				surface.SetTextPos((job:GetWide() / 2) - (width / 2), 10)
				surface.DrawText(HRP.jobsTable[i].jobTitles[j].title)

			end

			job.DoClick = function()
				JobPanelClick(HRP.jobsTable[i].title, HRP.jobsTable[i].jobTitles[j].title, HRP.jobsTable[i].jobTitles[j].jobRanks[1].title)
			end
		end
	end
end)