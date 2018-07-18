util.AddNetworkString( "TRP_F4Menu" )

function GM:ShowSpare2( ply )
	net.Start( "TRP_F4Menu" )
	net.Send( ply )
end