
--Game variables must be above imports so they are avalible to all files
Game = {}
Game.viewSize = 512
Game.tileSize = 32
Game.logicalCellWidth = 8
Game.dimension = Game.viewSize * 1
Game.windowHeight = Game.viewSize + 70
Game.windowWidth = Game.viewSize
Game.MAIN_MENU = true
Game.PAUSED = false
Game.viewX = 0
Game.viewY = 0

--imports
require "engine/map.lua"
map = Map:new()

require "engine/entities.lua"
require "gui/gui.lua"

function love.load()
	love.graphics.setCaption("Roguelike")
	love.graphics.setMode(Game.viewSize, Game.viewSize + 70, false, true, 0)
	
	map:setNumRooms(256)
	map:setRoomSizes(3, 6)
	map:setNumHyperCorridors(3)
	map:setCorridorType("b")
	map:setLayout("maze")
	
	GUI:init()
end

function love.draw()
	if Game.MAIN_MENU == false then
		map:draw()
		map.player:draw()
	end
	GUI:draw()
end

function love.update(dt)
	print (love.timer.getFPS( ))
end

function love.keypressed(e)
	if Game.MAIN_MENU == false then
		if map:checkWallCollision(map.player, e) == false then
			map.player:move(e)
			map.player:updateViewpoint(e)
			map:updateEntities()
		end
	end
	GUI:doEvents(e)
end

function love.mousepressed(x, y, e)
	GUI:doEvents({x,y,e})
end

function love.quit()
	map:saveVisMap("level.txt")
end

function love.conf(t)
    t.vsync = false
end

