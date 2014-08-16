Game = {}
Game.debug = true
Game.delta = 0
Game.fps = 0

require "entity.lua"
require "map.lua"

player = Entity:new()
function love.load()
	love.graphics.setCaption("Roguelike Evolution")
	love.graphics.setMode(512, 512, false, true, 0)
	
	
	player:setPosition(256,256)
	player:setImage("test.png")
	Map:init()
end

function love.draw()
	Map:draw()
	player:draw()
	
	--debug code
	if Game.debug then
		love.graphics.print(Game.fps, 10, 10)
	end
end

function love.update(dt)
	
	--debug code
	if Game.debug then
		updateFPS(dt)
	end
	player:rotate()
	player:move()
end

function love.keypressed(e)
	if e == "f1" then
		Game.debug = not Game.debug
	end
end

function updateFPS(dt)
	Game.delta = Game.delta + dt
	if Game.delta > 3 then
		Game.fps = love.timer.getFPS()
	end
end
