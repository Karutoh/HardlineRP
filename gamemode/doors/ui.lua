AddDoorUiBase(DoorUiBase("Button", nil,
function (door, ui, curPos)
	if ui.activator && ui.Activated then
		if LocalPlayer():KeyReleased(ui.activator) then
			if curPos.x >= ui.pos.x && curPos.x <= ui.pos.x + ui.scale.x && curPos.y >= ui.pos.y && curPos.y <= ui.pos.y + ui.scale.y then
				ui.Activated(door)
			end
		end
	end
end,
function (door, ui)
	surface.SetDrawColor(0, 0, 0)
	surface.DrawRect(ui.pos.x, ui.pos.y, ui.scale.x, ui.scale.y)
	
	local color = ui.color || Color(255, 255, 255)
	surface.SetDrawColor(color)
	
	surface.DrawRect(ui.pos.x + 2, ui.pos.y + 2, ui.scale.x - 4, ui.scale.y - 4)
	surface.SetFont("DoorUi")
	surface.SetTextColor(ui.textColor || Color(0, 0, 0))
	
	local x, y = surface.GetTextSize(ui.identifier)
	
	surface.SetTextPos(ui.pos.x + ui.scale.x / 2 - x / 2, ui.pos.y + ui.scale.y / 2 - y / 2)
	surface.DrawText(ui.identifier)
end))

AddDoorUiBase(DoorUiBase("Text", nil,
function (door, ui, curPos)
end,
function (door, ui)
	if !ui.text then
		return
	end
	
	surface.SetFont(ui.font || "DoorUi")
	surface.SetTextColor(ui.textColor || Color(255, 255, 255))
	
	if ui.scale.x > 0 && ui.scale.y > 0 then
		local x, y = surface.GetTextSize(ui.text)
		surface.SetTextPos(ui.pos.x + ui.scale.x / 2 - x / 2, ui.pos.y + ui.scale.y / 2 - y / 2)
	else
		surface.SetTextPos(ui.pos.x, ui.pos.y)
	end
	
	surface.DrawText(ui.text)
end))

local cost = DoorUi("Cost", "Text", DM_FOR_SALE, Vector(170, 0), Vector(250, 80))
cost.textColor = Color(0, 100, 0)
cost.font = "DoorUiMoney"
cost.text = "$400"
AddDoorUi(cost);

local buyButt = DoorUi("Buy", "Button", DM_FOR_SALE, Vector(170, 100), Vector(250, 80))
buyButt.activator = IN_ZOOM
buyButt.Activated = function (door)
	chat.AddText("You have bought the door!")
end
AddDoorUi(buyButt)