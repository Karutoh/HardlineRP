local frame = nil
local tabs = {}

function AddAdminMenuTab(title, icon, cb)
	
	for i = 1, #tabs do
		if tabs[i].title == title then
			return false
		end
	end

	table.insert(tabs, {title = title, icon = icon, cb = cb})

	return true
end

net.Receive("HRP_OpenAdminMenu", function (len, ply)
	if gui.IsGameUIVisible() then
		return
	end

	if frame then
		gui.EnableScreenClicker(false)
		frame:Remove()
		frame = nil
		return
	end

	gui.EnableScreenClicker(true)
	
	frame = vgui.Create("DFrame")
	frame:SetSizable(true)
	frame:SetSize(ScrW() / 1.25, ScrH() / 1.25)
	frame:Center()
	frame:SetTitle("Admin Menu")
	frame:SetDraggable(true)
	frame:SetDeleteOnClose(true)
	frame:ShowCloseButton(true)

	function frame:OnClose()
		gui.EnableScreenClicker(false)
		frame = nil
	end

	local sheet = vgui.Create("DPropertySheet", frame)
	sheet:Dock(FILL)
	sheet:InvalidateParent(true)

	for i = 1, #tabs do
		local panel = vgui.Create("DPanel", sheet)
		panel:Dock(FILL)
		panel:InvalidateParent(true)

		sheet:AddSheet(tabs[i].title, panel, tabs[i].icon)

		tabs[i].cb(panel)
	end
end)

AddAdminMenuTab("Commands", "icon16/cog.png", function(panel)
	
end)

AddAdminMenuTab("User Management", "icon16/wrench.png", function(panel)

end)