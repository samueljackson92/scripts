
require "map.lua"
map = Map:new()
require "pacman.lua"



function love.load()
	love.graphics.setCaption("Pac-Man")
	love.graphics.setMode(608, 608, false, true, 0)

	map:buildMap()
end

function love.draw()
	map:draw()
	Pacman:draw()
end

function love.update(dt)
	Pacman:move(dt)
end

function love.keypressed(e)

	if e == "up" or e == "down" or
	e == "left" or e == "right" 
	then
		Pacman:setNextDir(e)
	end
end

