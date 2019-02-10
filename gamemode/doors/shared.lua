DS_FOR_SALE = 1
DS_UNOWNED = 2
DS_OWNED = 3

function GetDoorStatus(ply, door)
	local status = DS_FOR_SALE
	local owner = door:GetNWString("owner", "")
				
	if #owner > 0 then
		if owner == ply:SteamID64() then
			status = DS_OWNED
		else
			status = DS_UNOWNED
		end
	end
	
	return status
end