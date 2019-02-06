AddF4MenuTab("Skills", function (panel)

local directory = "skills/"

local scroll = vgui.Create("DScrollPanel", panel)
scroll:Dock(FILL)
scroll:SetVerticalScrollbarEnabled(true)
scroll:InvalidateParent(true)

local fillerScrollBar = vgui.Create("DPanel", scroll)
fillerScrollBar:SetSize(15, scroll:GetTall())
fillerScrollBar:SetPos(scroll:GetWide() - 15, 0)
fillerScrollBar.Paint = function()
	draw.RoundedBox(0, 0, 0, fillerScrollBar:GetWide(), fillerScrollBar:GetTall(), Color(181, 181, 181))
end

local List = vgui.Create("DIconLayout", scroll)
List:Dock(FILL)

local AmountPerRow = 5

for i = 1, #skillsTable do
	local ListItem = List:Add("DPanel")
	ListItem:SetSize(scroll:GetWide() / AmountPerRow - 3, scroll:GetWide() / AmountPerRow)

	ListItem.Paint = function()
			
		-- background
		draw.RoundedBox(0, 0, 0, ListItem:GetWide(), ListItem:GetTall(), Color(10, 10, 10, 255))
		draw.RoundedBox(0, 2, 2, ListItem:GetWide() - 4, ListItem:GetTall() - 4, Color(35, 39, 50, 255))

		-- skill level
		local level = tostring(LocalPlayer():GetNWInt(skillsTable[i]))

		surface.SetFont("buttonFont")
		surface.SetTextColor(255, 255, 255, 255)

		local width, height = surface.GetTextSize(level)

		surface.SetTextPos(ListItem:GetWide() - width - 5, ListItem:GetTall() - height - 5)
		surface.DrawText(level)

	end

	local path = directory .. skillsTable[i] .. ".png"

	if !file.Exists(path, "GAME") then
		print("File at path " .. path .. " does not exist!")
	else
		local image = vgui.Create("DImage", ListItem)
		image:SetSize(100, 100)
		image:SetImage(path)
		image:SetPos((ListItem:GetWide() / 2) - (image:GetWide() / 2), (ListItem:GetTall() / 2) - (image:GetTall() / 2))
			
	end

end

end)