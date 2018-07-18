util.AddNetworkString( "f4menu" )

function GM:ShowSpare2( ply )
	net.Start( "f4menu" )
		local table = TRP.GetJobsTable()
		if(table == nil) then table = {} end
		net.WriteTable(table)
	net.Send( ply )
end