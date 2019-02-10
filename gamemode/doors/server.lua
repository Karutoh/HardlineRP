hook.Add("InitPostEntity", "HRP_DoorOwnership", function ()
	local doors = ents.FindByClass("prop_door_rotating")
	
	for i = 1, #doors do
		doors[i]:SetNWString("owner", "")
	
		local other = ents.FindByName(doors[i]:GetName())
		if #other > 1 then
			for o = 1, #other do
				if doors[i] != other[o] then
					doors[i]:SetNWInt("other", other[o]:EntIndex())
					
					break
				end
			end
		else
			doors[i]:SetNWInt("other", "")
		end
	end
end)