util.AddNetworkString( "TRP_F4Menu" )

function GM:ShowSpare2( ply )
<<<<<<< HEAD
	net.Start( "f4menu" )
		local table = TRP.GetJobsTable()
		if(table == nil) then table = {} end
		net.WriteTable(table)
=======
	net.Start( "TRP_F4Menu" )
>>>>>>> 0f40f86f45d1a214fd6f2d89bb79a02b9cdf5c4d
	net.Send( ply )
end