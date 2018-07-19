function GM:ShowSpare2(ply)
	net.Start("TRP_F4Menu")
		local table = TRP.GetJobsTable()
		if !table then
			table = {}
		end

		net.WriteTable(table)
	net.Send(ply)
end

net.Receive("TRP_F4MenuSetJob", function(len, ply)
	local category = net.ReadString()
	local title = net.ReadString()
	local rank = net.ReadString()

	if ply:GetNWString("jobRank") != rank then
		if TRP.SetPlayerJob(ply, category, title, rank) then
			ply:PrintMessage(HUD_PRINTTALK, "You have successfully switched jobs to " .. title .. ", rank " .. rank)
		else
			ply:PrintMessage(HUD_PRINTTALK, "There was an error switching to that job!")
		end		
	else
		ply:PrintMessage(HUD_PRINTTALK, "You are already set to that job!")
	end
end)