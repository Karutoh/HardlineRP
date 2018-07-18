function GM:ShowSpare2(ply)
	net.Start("TRP_F4Menu")
		local table = TRP.GetJobsTable()
		if !table then
			table = {}
		end

		net.WriteTable(table)
	net.Send(ply)
end