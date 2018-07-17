util.AddNetworkString( "f4menu" )

function GM:ShowSpare2( ply )
	net.Start( "f4menu" )
	net.Send( ply )
end