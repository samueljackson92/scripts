GUI = 
{
	fonts =
	{
		DEFAULT = love.graphics.getFont(),
		MAIN_HEADING = love.graphics.newFont("images/GODOFWAR.TTF", 50),
		MENU_LARGE = love.graphics.newFont("images/GODOFWAR.TTF", 20),
		MAIN_SUBHEADING = love.graphics.newFont("images/MORPHEUS.TTF", 20),
	},
}

-- Basic UI Components
require "gui/guicomponent.lua"
require "gui/panel.lua"
require "gui/label.lua"
require "gui/button.lua"

--Complex UI Components
require "gui/menus/mainmenu.lua"
require "gui/menus/hud.lua"
require "gui/menus/inventory.lua"

function GUI:init()
	MainMenu:init()
	HUD:init()
	Inventory:init()
end

function GUI:draw()
	if Game.MAIN_MENU then
		MainMenu:drawComponents()
	else
		HUD:drawComponents()
		Inventory:drawComponents()
	end
end

function GUI:doEvents(e)
	if Game.MAIN_MENU then
		MainMenu:doEvents(e)
	else
		if e == "i" then
			Inventory:toggleVisible()
		end
		HUD:doEvents(e)
		Inventory:doEvents(e)
	end
end

function GUI:setColour(tbl)
	love.graphics.setColor(tbl[1], tbl[2], tbl[3], tbl[4])
end

function GUI:clearColour()
	love.graphics.setColor(255, 255, 255, 255)
end
