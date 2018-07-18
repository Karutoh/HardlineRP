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

surface.CreateFont( "buttonFont", {
	font = "Arial",
	extended = false,
	size = 24,
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

local tabs = {
	
	{
		name = "Jobs"
	},
	{
		name = "filler"
	},
	{
		name = "filler2"
	}

}

local jobstbl = {}

local isCreated = false
local isVisible = false

local PANEL = {}
PANEL.width = 800
PANEL.height = 600

function PANEL:Init()
	self:SetPos( ( ScrW() / 2 ) - ( self.width / 2 ), ( ScrH() / 2 ) - ( self.height / 2 ) ) 
	self:SetSize( self.width, self.height )

	self.tabPanel = vgui.Create("DPanel", self)
	self.tabPanel:SetPos( 0, 20 )
	self.tabPanel:SetSize( 200, self.height-20 )

	self.displayPanel = vgui.Create("DPanel", self)
	self.displayPanel:SetPos( 201, 20 )
	self.displayPanel:SetSize( self.width-201, self.height-20 )

	tabContent(self)
end


function PANEL:Paint( w, h )
	if(!isVisible) then return false end
	draw.RoundedBox( 0, 0, 0, w, h, Color( 20, 20, 20, 150 ) )
	
	header(self)

	self.tabPanel.Paint = function()
	if(!isVisible) then return false end
		draw.RoundedBox( 0, 0, 0, self.tabPanel:GetWide(), self.tabPanel:GetTall(), Color( 20, 20, 20, 180 ) )
	end

	self.displayPanel.Paint = function()
		if(!isVisible) then return false end
		draw.RoundedBox( 0, 0, 0, self.displayPanel:GetWide(), self.displayPanel:GetTall(), Color( 20, 20, 20, 180 ) )
	end
end

function header(self)

	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( 0, 0, self.width, 20 )

	surface.SetFont( "headerFont" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( 10, 2 )
	surface.DrawText( "f4menu" )
end

function tabContent(PANEL)
	
	local button

	for i = 1, #tabs do
		button = vgui.Create("DButton", PANEL.tabPanel)
		button:SetSize(PANEL.tabPanel:GetWide(), 50)
		button:SetPos(0, (i-1)*50)
		button:SetText( "" )

		button.DoClick = function()



		end

		button.Paint = function()
		
			if(!isVisible) then return false end

			draw.RoundedBox( 0, 0, 0, button:GetWide(), button:GetTall(), Color( 0, 0, 0, 255 ) )
			draw.RoundedBox( 0, 1, 1, button:GetWide()-2, button:GetTall()-2, Color( 220, 220, 220, 255 ) )

			surface.SetFont( "buttonFont" )
			surface.SetTextColor( 0, 0, 0, 255 )
			local tWidth, tHeight = surface.GetTextSize( tabs[i]['name'] )
			surface.SetTextPos( (button:GetWide()/2)-(tWidth/2), (button:GetTall()/2)-(tHeight/2) )
			surface.DrawText( tabs[i]['name'] )
		end
	end
	
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

net.Receive( "f4menu", function() 
	jobstbl = net.ReadTable()
	showMenu()

end)