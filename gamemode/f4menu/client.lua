local f4Menu = nil
local currentTab = 1
local tabs = {}

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
	f4Menu:SetTitle("Primary Menu")
	f4Menu:SetDraggable(true)
	f4Menu:SetDeleteOnClose(true)

	function f4Menu:OnClose()
		gui.EnableScreenClicker(false)
		f4Menu = nil
	end

	local tabPanel = vgui.Create("DPanel", f4Menu)
	function tabPanel:PerformLayout(w, h)
		local c = tabPanel:GetChildren()

		for i = 1, #c do
			c[i]:SetSize(tabPanel:GetWide() - 10, c[i]:GetTall())
		end
	end

	local panel = vgui.Create("DPanel", f4Menu)

	local div = vgui.Create("DHorizontalDivider", f4Menu)
	div:Dock(FILL)
	div:SetLeft(tabPanel)
	div:SetRight(panel)
	div:SetDividerWidth(5)
	div:SetLeftWidth(f4Menu:GetWide() / 4)
	div:SetLeftMin(f4Menu:GetWide() / 4)
	div:SetRightMin(f4Menu:GetWide() / 2)

	local pad = 5

	for i = 1, #tabs do
		local tab = vgui.Create("DButton", tabPanel)
		tab:SetSize(f4Menu:GetWide() / 4 - pad * 2, 30)
		tab:SetPos(5, (30 + pad) * (i - 1) + pad)
		tab:SetText(tabs[i].title)

		tab.DoClick = function ()
			ShowTab(panel, i)
		end

		if i == currentTab then
			ShowTab(panel, i)
		end
	end

	PrintTable(f4Menu:GetChildren())
end)

HRP.AddF4MenuTab("Jobs", function (panel)
	local button = vgui.Create("DButton", panel)
	button:SetText("Hello World")
	button:SetSize(100, 30)
end)

HRP.AddF4MenuTab("Test #1", function (panel)
	local button = vgui.Create("DButton", panel)
	button:SetText("Fuck You")
	button:SetSize(100, 30)
	button:SetPos(100, 100)
end)

HRP.AddF4MenuTab("Test #2", function (panel)
	local button = vgui.Create("DButton", panel)
	button:SetText("You Bitch")
	button:SetSize(100, 30)
	button:SetPos(200, 200)
end)