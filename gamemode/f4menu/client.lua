local tabs = {
	
	{
		name = "Jobs"
	},
	{
		name = "filler"
	},
	{
		name = "filler2"
	}

}

local jobstbl = {}

local isCreated = false
local isVisible = false

local PANEL = {}
PANEL.width = 800
PANEL.height = 600
PANEL.currentTab = 1

function PANEL:Init()
	self:SetPos((ScrW() / 2) - (self.width / 2), (ScrH() / 2) - (self.height / 2)) 
	self:SetSize(self.width, self.height)

	self.tabPanel = vgui.Create("DPanel", self)
	self.tabPanel:SetPos(0, 20)
	self.tabPanel:SetSize(200, self.height - 20)

	self.sheet = vgui.Create("DPanel", self)
	self.sheet:SetPos(201, 20)
	self.sheet:SetSize(self.width - 201, self.height - 20)

	self.displayPanel = vgui.Create( "DScrollPanel", self.sheet )
	self.displayPanel:SetSize(self.width - 201, self.height - 20)

	tabContent(self)
	setupDisplay(self, 1)
end


function PANEL:Paint(w, h)
	if !isVisible then return false end
	draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 20, 150))
	
	header(self)


	self.sheet.Paint = function()
		if !isVisible then return false end
		draw.RoundedBox(0, 0, 0, self.sheet:GetWide(), self.sheet:GetTall(), Color(220, 220, 220, 255))
	end

	self.tabPanel.Paint = function()
	if !isVisible then return false end
		draw.RoundedBox(0, 0, 0, self.tabPanel:GetWide(), self.tabPanel:GetTall(), Color(20, 20, 20, 180))
	end

	self.displayPanel.Paint = function()
		if !isVisible then return false end
		draw.RoundedBox(0, 0, 0, self.displayPanel:GetWide(), self.displayPanel:GetTall(), Color(20, 20, 20, 180))
	end

	local sbar = self.displayPanel:GetVBar()

	sbar.Paint = function()
		if !isVisible then return false end
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
	end

	sbar.btnUp.Paint = function()
		if !isVisible then return false end

		draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 100 ) )
	end

	sbar.btnDown.Paint = function()
		if !isVisible then return false end
		draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 100 ) )
	end

	sbar.btnGrip.Paint = function()
		if !isVisible then return false end
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
	end
end

function header(self)

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, self.width, 20)

	surface.SetFont("headerFont")
	surface.SetTextColor(255, 255, 255, 255)
	surface.SetTextPos(10, 2)
	surface.DrawText("F4 Menu")
end

function tabContent(PANEL)
	
	local button

	for i = 1, #tabs do
		button = vgui.Create("DButton", PANEL.tabPanel)
		button:SetSize(PANEL.tabPanel:GetWide(), 50)
		button:SetPos(0, (i - 1) * 50)
		button:SetText("")

		button.DoClick = function()

		PANEL.currentTab = i

		setupDisplay(PANEL, i)

		end

		button.Paint = function()
		
			if !isVisible then return false end

			draw.RoundedBox(0, 0, 0, button:GetWide(), button:GetTall(), Color(0, 0, 0, 255))
			draw.RoundedBox(0, 1, 1, button:GetWide() - 2, button:GetTall() - 2, Color(220, 220, 220, 255))

			surface.SetFont("buttonFont")
			surface.SetTextColor(0, 0, 0, 255)
			local tWidth, tHeight = surface.GetTextSize(tabs[i]['name'])
			surface.SetTextPos((button:GetWide() / 2)-(tWidth / 2), (button:GetTall() / 2) - (tHeight / 2))
			surface.DrawText(tabs[i]['name'])
		end
	end
	
end

function setupDisplay(PANEL, tabIndex)
	PANEL.displayPanel:Clear()

	if tabs[tabIndex]['name'] == "Jobs" then
		if jobstbl == nil || #jobstbl == 0 then
			local nojobsText = vgui.Create("DPanel", PANEL.displayPanel)
			nojobsText:SetSize(PANEL.displayPanel:GetWide(), 150)
			nojobsText:SetPos(0, 0)

			nojobsText.Paint = function()
				if !isVisible then return false end

				local nojobs = "There are currently no jobs that can be found!";

				surface.SetFont("buttonFont")
				local tWidth, tHeight = surface.GetTextSize(nojobs)

				surface.SetTextColor(0, 0, 0, 255)
				surface.SetTextPos((PANEL.displayPanel:GetWide() / 2) - (tWidth / 2), 20)
				surface.DrawText(nojobs)
			end
		else
			for i = 1, #jobstbl do

				local jobPanel = vgui.Create("DButton", PANEL.displayPanel)
				jobPanel:SetText("")
				jobPanel:SetSize(PANEL.displayPanel:GetWide(), 150)
				jobPanel:SetPos(0, (i - 1) * jobPanel:GetTall())

				local jobDescription = vgui.Create("DButton", jobPanel)
				jobDescription:SetText("")
				jobDescription:SetSize(jobPanel:GetWide() / 2, jobPanel:GetTall() / 2)
				jobDescription:SetPos((jobPanel:GetWide() / 2) - (jobDescription:GetWide() / 2), jobPanel:GetTall() - jobDescription:GetTall())

				local jdLabel = vgui.Create("DLabel", jobDescription)
				jdLabel:SetAutoStretchVertical(true);
				jdLabel:SetWide(jobDescription:GetWide());
				jdLabel:SetWrap(true);
				jdLabel:SetMouseInputEnabled(true)
				jdLabel:SetCursor("hand")

				jobPanel.Paint = function()
					if !isVisible || tabs[tabIndex]['name'] != "Jobs" then return false end

					if jobPanel:IsHovered() || jobDescription:IsHovered() || jdLabel:IsHovered() then
						draw.RoundedBox(0, 0, 0, jobPanel:GetWide(), jobPanel:GetTall(), Color(255, 255, 255, 255))
						draw.RoundedBox(0, 2, 2, jobPanel:GetWide()-4, jobPanel:GetTall()-4, Color(80, 80, 80, 255))
					else
						draw.RoundedBox(0, 0, 0, jobPanel:GetWide(), jobPanel:GetTall(), Color(0, 0, 0, 255))
						draw.RoundedBox(0, 2, 2, jobPanel:GetWide()-4, jobPanel:GetTall()-4, Color(80, 80, 80, 255))
					end

					surface.SetFont("buttonFont")
					surface.SetTextColor(0, 0, 0, 255)
					local tWidth, tHeight = surface.GetTextSize(jobstbl[i].jobTitles[1].title)
					surface.SetTextPos((jobPanel:GetWide() / 2) - (tWidth / 2), 5)
					surface.DrawText(jobstbl[i].jobTitles[1].title)
				end

				jobPanel.DoClick = function()
					jobPanelClick()
				end

				jobDescription.Paint = function()
					if !isVisible then return false end
				end

				jobDescription.DoClick = function()
					jobPanelClick()
				end

				jdLabel.Paint = function()
					if !isVisible then 
						jdLabel:SetText("")
						return false 
					end
					jdLabel:SetFont("Default")
					jdLabel:SetText(jobstbl[i].jobTitles[1].description)
				end

				jdLabel.DoClick = function()
					jobPanelClick()
				end

			end
		end

	else

	end
end

function jobPanelClick()
	print("CLICKED")
end

function showMenu()
	if !isCreated then
		vgui.Create("f4menu")
		isCreated = true
	end
	
	if !isVisible then
		isVisible = true
		gui.EnableScreenClicker(true)
	else
		isVisible = false
		gui.EnableScreenClicker(false)
	end
end

vgui.Register("f4menu", PANEL, "DPanel")

net.Receive("TRP_F4Menu", function() 
	jobstbl = net.ReadTable()
	showMenu()
end)