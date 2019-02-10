local doorUiBase = {}
local doorUi = {}
doorUi[DS_FOR_SALE] = {}
doorUi[DS_UNOWNED] = {}
doorUi[DS_OWNED] = {}
local doors = {}

function DoorUiBase(identifier, Render)
	return {
		identifier = identifier,
		Render = Render
	}
end

function DoorUi(identifier, base, pos, scale)
	local result = {
		identifier = identifier,
		base = nil,
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

function AddDoorUi(ui, status)
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
	
	table.insert(doorUi[status], ui)
	
	return true
end

include("ui.lua")

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

local function InitDoorUi(door)
	local tbl = {
		id = door:EntIndex(),
		ui = {}
	}

	table.Add(tbl.ui, doorUi[GetDoorStatus(LocalPlayer(), door)])

	table.insert(doors, tbl)
end

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
			
			local curPos = CursorPos_Door(mat:GetTranslation(), mat:GetAngles())
			if curPos then
				cam.Start3D2D(mat:GetTranslation(), mat:GetAngles(), 0.05)
					local found = false
				
					for d = 1, #doors do
						if doors[d].id == ent[i]:EntIndex() then
							found = true
						
							for u = 1, #doors[d].ui do
								doors[d].ui[u].base.Render(ent[i], doors[d].ui[u], curPos / 0.05)
							end
						end
					end
					
					if !found then
						InitDoorUi(ent[i])
					end
				cam.End3D2D()
			end
        end
    end
end)