hook.Add("PostDrawTranslucentRenderables", "HRP_DoorOwnership", function (bDepth, bSkybox)
    if bSkybox then
        return
    end
    
    local ent = ents.FindByClass("func_door")
    table.Add(ent, ents.FindByClass("prop_door_rotating"))

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
                pos:Translate(Vector(2, 12, 15))
                rot:Rotate(Angle(0, 90, 90))
            end

            local mat = ent[i]:GetWorldTransformMatrix()
            mat = mat * pos * rot

            cam.Start3D2D(mat:GetTranslation(), mat:GetAngles(), 0.1)
                surface.SetDrawColor(0, 0, 0, 200)
                surface.DrawRect(0, 0, 250, 250)
            cam.End3D2D()
        end
    end
end)

--print(LocalPlayer():GetEyeTrace().Entity:GetClass())