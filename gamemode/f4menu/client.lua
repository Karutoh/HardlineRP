local menuActive = false
local currentTab = 1
local tabs = {}

local function ShowTab(panel, index)
	local children = panel:GetChildren()
	for i = 1, #children do
		children[i]:Remove()
	end

	tabs[index].cb(panel)
end

function TRP.AddF4MenuTab(title, cb)
	for i = 1, #tabs do
		if tabs[i].title == title then
			return false
		end
	end

	table.insert(tabs, {title = title, cb = cb})

	return true
end

net.Receive("TRP_OpenF4Menu", function (len, ply)
	if menuActive then
		return
	end

	menuActive = true

	gui.EnableScreenClicker(true)
	
	local f4Menu = vgui.Create("DFrame")
	f4Menu:SetSize(ScrW() / 1.25, ScrH() / 1.25)
	f4Menu:Center()
	f4Menu:SetTitle("Primary Menu")
	f4Menu:SetDraggable(true)
	f4Menu:SetDeleteOnClose(true)

	function f4Menu:OnClose()
		gui.EnableScreenClicker(false)
		menuActive = false
	end

	local panel = vgui.Create("DPanel", f4Menu)
	panel:SetSize(f4Menu:GetWide() * 0.75 - 5, f4Menu:GetTall() - 35)
	panel:SetPos(f4Menu:GetWide() / 4, 30)

	local pad = 5

	for i = 1, #tabs do
		local tab = vgui.Create("DButton", f4Menu)
		tab:SetSize(f4Menu:GetWide() / 4 - pad * 2, 30)
		tab:SetPos(5, (30 + pad) * (i - 1) + pad + 25)
		tab:SetText(tabs[i].title)

		tab.DoClick = function ()
			ShowTab(panel, i)
		end

		if i == currentTab then
			ShowTab(panel, i)
		end
	end
end)

TRP.AddF4MenuTab("Jobs", function (panel)
	local button = vgui.Create("DButton", panel)
	button:SetText("Hello World")
	button:SetSize(100, 30)
end)

TRP.AddF4MenuTab("Test #1", function (panel)
	local button = vgui.Create("DButton", panel)
	button:SetText("Fuck You")
	button:SetSize(100, 30)
	button:SetPos(100, 100)
end)

TRP.AddF4MenuTab("Test #2", function (panel)
	local button = vgui.Create("DButton", panel)
	button:SetText("You Bitch")
	button:SetSize(100, 30)
	button:SetPos(200, 200)
end)