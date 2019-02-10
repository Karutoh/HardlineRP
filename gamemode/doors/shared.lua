DM_FOR_SALE = 1
DM_UNOWNED = 2
DM_OWNED = 3

function GetDoorStatus(ply, door)
	local status = DM_FOR_SALE
	local owner = door:GetNWString("owner", "")
				
	if #owner > 0 then
		if owner == ply:SteamID64() then
			status = DM_OWNED
		else
			status = DM_UNOWNED
		end
	end
	
	return status
end