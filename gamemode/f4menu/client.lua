surface.CreateFont( "headerFont", {
	font = "Arial",
	extended = false,
	size = 16,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local isCreated = false
local isVisible = false

local PANEL = {}
PANEL.width = 800
PANEL.height = 600

function PANEL:Init()
	self:SetPos( ( ScrW() / 2 ) - ( self.width / 2 ), ( ScrH() / 2 ) - ( self.height / 2 ) ) 
	self:SetSize( self.width, self.height )
end



function PANEL:Paint( w, h )
	if(!isVisible) then return false end
	draw.RoundedBox( 0, 0, 0, w, h, Color( 20, 20, 20, 150 ) )
	
	header(self)
end

function header(self)

	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( 0, 0, self.width, 20 )

	surface.SetFont( "headerFont" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( 10, 2 )
	surface.DrawText( "f4menu" )
end

function showMenu()
	if(!isCreated) then
		vgui.Create( "f4menu" )
		isCreated = true
	end
	
	if(!isVisible) then
		isVisible = true
		gui.EnableScreenClicker( true )
	else
		isVisible = false
		gui.EnableScreenClicker( false )
	end
end

vgui.Register( "f4menu", PANEL, "DPanel" )

net.Receive( "TRP_F4Menu", function() 
	
	showMenu()

end)