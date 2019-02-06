local doorUiBase = {}
local doorUi = {}

DM_FOR_SALE = 1
DM_UNOWNED = 2
DM_OWNED = 3

function DoorUiBase(identifier, base, Update, Render)
	local result = {
		identifier = identifier,
		base = nil,
		Update = Update,
		Render = Render
	}
	
	if base then
		for i = 1, #doorUiBase do
			if doorUiBase[i].identifier == base then
				result.base = doorUiBase[i]
			end
		end
	end

	return result
end

function DoorUi(identifier, base, doorMenu, pos, scale)
	local result = {
		identifier = identifier,
		base = nil,
		doorMenu = doorMenu,
		pos = pos,
		scale = scale
	}
	
	for i = 1, #doorUiBase do
		if doorUiBase[i].identifier == base then
			result.base = doorUiBase[i]
			
			return result
		end
	end
	
	return nil
end

function AddDoorUiBase(ui)
	for i = 1, #doorUiBase do
		if doorUiBase[i].identifier == ui.identifier then
			return false
		end
	end
	
	table.insert(doorUiBase, ui)
	
	return true
end

function AddDoorUi(ui)
	for i = 1, #doorUi do
		if doorUi[i].identifier == ui.identifier then
			return false
		end
	end
	
	if base then
		for i = 1, #doorUiBase do
			if doorUiBase[i].identifier == ui.base then
				ui.base = doorUiBase[i]
			end
		end
	end
	
	table.insert(doorUi, ui)
	
	return true
end

local function UpdateDoorUi(door, ui, curPos, base)
	if !base then
		UpdateDoorUi(door, ui, curPos, ui.base)
		
		return
	end
	
	if base.base then
		UpdateDoorUi(door, ui, curPos, base.base)
	end
	
	base.Update(door, ui, curPos)
end

local function RenderDoorUi(door, ui, base)
	if !base then
		RenderDoorUi(door, ui, ui.base)
		
		return
	end
	
	if base.base then
		RenderDoorUi(door, ui, base.base)
	end
	
	base.Render(door, ui)
end

local function CursorPos_Door(pos, angle)
	local p = util.IntersectRayWithPlane(LocalPlayer():EyePos(), LocalPlayer():GetAimVector(), pos, angle:Up())
	
	if !p then
		return nil
	end
	
	if WorldToLocal(LocalPlayer():GetShootPos(), Angle(0, 0, 0), pos, angle).z < 0 then
		return nil
	end
	
	local curP = WorldToLocal(p, Angle(0, 0, 0), pos, angle)
	
	return Vector(curP.x, -curP.y)
end

hook.Add("Tick", "HRP_DoorUiUpdate", function ()
	local ent = ents.FindByClass("prop_door_rotating")

    for i = 1, #ent do
        local dis = LocalPlayer():GetPos():Distance(ent[i]:GetPos())

        if dis <= 250 then
            local ang = ent[i]:GetForward():Dot((ent[i]:GetPos() - LocalPlayer():GetPos()):GetNormalized())

            local pos = Matrix()
            local rot = Matrix()
            if ang > 0 then
                pos:Translate(Vector(-2, 37, 15))
                rot:Rotate(Angle(0, -90, 90))
            else
                pos:Translate(Vector(2, 8, 15))
                rot:Rotate(Angle(0, 90, 90))
            end

            local mat = ent[i]:GetWorldTransformMatrix()
            mat = mat * pos * rot
			
			local curPos = CursorPos_Door(mat:GetTranslation(), mat:GetAngles())
			if curPos then
				local menu = DM_FOR_SALE
				local owner = ent[i]:GetNWString("owner", "")
				
				if #owner > 0 then
					if owner == LocalPlayer():SteamID64() then
						menu = DM_OWNED
					else
						menu = DM_UNOWNED
					end
				end
			
				for c = 1, #doorUi do
					if menu == doorUi[c].doorMenu then
						UpdateDoorUi(ent[i], doorUi[c], curPos / 0.05)
					end
				end
			end
        end
    end
end)

hook.Add("PostDrawTranslucentRenderables", "HRP_DoorUiRender", function (bDepth, bSkybox)
    if bSkybox then
        return
    end
    
    local ent = ents.FindByClass("prop_door_rotating")

    for i = 1, #ent do
        local dis = LocalPlayer():GetPos():Distance(ent[i]:GetPos())

        if dis <= 250 then
            local ang = ent[i]:GetForward():Dot((ent[i]:GetPos() - LocalPlayer():GetPos()):GetNormalized())

            local pos = Matrix()
            local rot = Matrix()
            if ang > 0 then
                pos:Translate(Vector(-2, 37, 15))
                rot:Rotate(Angle(0, -90, 90))
            else
                pos:Translate(Vector(2, 8, 15))
                rot:Rotate(Angle(0, 90, 90))
            end

            local mat = ent[i]:GetWorldTransformMatrix()
            mat = mat * pos * rot
			
			cam.Start3D2D(mat:GetTranslation(), mat:GetAngles(), 0.05)
				local menu = DM_FOR_SALE
				local owner = ent[i]:GetNWString("owner", "")
				
				if #owner > 0 then
					if owner == LocalPlayer():SteamID64() then
						menu = DM_OWNED
					else
						menu = DM_UNOWNED
					end
				end
			
				for c = 1, #doorUi do
					if menu == doorUi[c].doorMenu then
						RenderDoorUi(ent[i], doorUi[c])
					end
				end
			cam.End3D2D()
        end
    end
end)

--print(LocalPlayer():GetEyeTrace().Entity:GetClass())

include("ui.lua")