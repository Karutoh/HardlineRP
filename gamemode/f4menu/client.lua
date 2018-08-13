local f4Menu = nil
local currentTab = 1
local tabs = {}

local FrameColor = Color(35, 39, 50, 255)
local ButtonColor = Color(35, 39, 50, 255)
local ButtonHoverColor = Color(22, 26, 37, 255)
local tabPanelColor = Color(35, 39, 50, 255)
local panelColor = Color(150, 150, 150, 255)


function HRP.AddF4MenuTab(title, cb)
	for i = 1, #tabs do
		if tabs[i].title == title then
			return false
		end
	end

	table.insert(tabs, {title = title, cb = cb})

	return true
end

local function ShowTab(panel, index)
	local children = panel:GetChildren()
	for i = 1, #children do
		children[i]:Remove()
	end

	tabs[index].cb(panel)
end

net.Receive("HRP_OpenF4Menu", function (len, ply)
	HRP.jobsTable = net.ReadTable()

	if gui.IsGameUIVisible() then
		return
	end

	if f4Menu then
		gui.EnableScreenClicker(false)
		f4Menu:Remove()
		f4Menu = nil
		return
	end

	gui.EnableScreenClicker(true)
	
	f4Menu = vgui.Create("DFrame")
	f4Menu:SetSizable(true)
	f4Menu:SetSize(ScrW() / 1.25, ScrH() / 1.25)
	f4Menu:Center()
	f4Menu:SetTitle("F4 Menu")
	f4Menu:SetDraggable(true)
	f4Menu:SetDeleteOnClose(true)
	f4Menu:ShowCloseButton(false)

	f4Menu.Paint = function()
		draw.RoundedBox(0,0,0,f4Menu:GetWide(),f4Menu:GetTall(),FrameColor)
	end

	function f4Menu:OnClose()
		gui.EnableScreenClicker(false)
		f4Menu = nil
	end

	local leftPanel = vgui.Create("DPanel", f4Menu)

	local tabPanel = vgui.Create("DPanel", leftPanel)
	function tabPanel:PerformLayout(w, h)
		local c = tabPanel:GetChildren()

		for i = 1, #c do
			c[i]:SetSize(tabPanel:GetWide() - 10, c[i]:GetTall())
		end
	end
	tabPanel:Dock(FILL)
	tabPanel.Paint = function()
		draw.RoundedBox(0,0,0,tabPanel:GetWide(),tabPanel:GetTall(),tabPanelColor)
	end

	local closeButton = vgui.Create("DButton", leftPanel)
	closeButton:SetHeight(85)
	closeButton:Dock(BOTTOM)
	closeButton:SetText("")

	closeButton.DoClick = function()
		f4Menu:Close()
	end

	closeButton.Paint = function()

		if !closeButton:IsHovered() then
			draw.RoundedBox(0, 0, 0, closeButton:GetWide(), closeButton:GetTall(), ButtonColor)
			surface.SetTextColor(162, 165, 172, 255)
		else
			draw.RoundedBox(0, 0, 0, closeButton:GetWide(), closeButton:GetTall(), ButtonHoverColor)
			surface.SetTextColor(255, 255, 255, 255)
		end

		surface.SetFont("buttonFont")
		local width, height = surface.GetTextSize("Close")
		surface.SetTextPos((closeButton:GetWide() / 2) - (width / 2), (closeButton:GetTall() / 2) - (height / 2))
		surface.DrawText("Close")
	end
	
	local panel = vgui.Create("DPanel", f4Menu)

	panel.Paint = function()
		draw.RoundedBox(0,0,0,panel:GetWide(),panel:GetTall(),panelColor)
	end

	local div = vgui.Create("DHorizontalDivider", f4Menu)
	div:Dock(FILL)
	div:SetLeft(leftPanel)
	div:SetRight(panel)
	div:SetDividerWidth(5)
	div:SetLeftWidth(f4Menu:GetWide() / 4)
	div:SetLeftMin(f4Menu:GetWide() / 4)
	div:SetRightMin(f4Menu:GetWide() / 2)

	local pad = 5

	for i = 1, #tabs do
		local tab = vgui.Create("DButton", tabPanel)
		tab.Height = 50
		tab:SetSize(f4Menu:GetWide() / 4 - pad * 2, tab.Height)
		tab:SetPos(5, (tab.Height + pad) * (i - 1) + pad)
		tab:SetText("")

		tab.Paint = function()

			if !tab:IsHovered() && currentTab != i then
				draw.RoundedBox(0, 0, 0, tab:GetWide(), tab:GetTall(), ButtonColor)
				surface.SetTextColor(162, 165, 172, 255)
			else
				draw.RoundedBox(0, 0, 0, tab:GetWide(), tab:GetTall(), ButtonHoverColor)
				surface.SetTextColor(255, 255, 255, 255)
			end

			surface.SetFont("buttonFont")
			local width, height = surface.GetTextSize(tabs[i].title)
			surface.SetTextPos((tab:GetWide() / 2) - (width / 2), (tab:GetTall() / 2) - (height / 2))
			surface.DrawText(tabs[i].title)
		end

		tab.DoClick = function ()
			ShowTab(panel, i)
			currentTab = i
		end

		if i == 1 then
			ShowTab(panel, 1)
		end
	end

end)
