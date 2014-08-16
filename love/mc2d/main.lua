---------------------------------------------------------------------
--SUPER GLOBALS
---------------------------------------------------------------------
Game = {}
Game.init = false
---------------------------------------------------------------------
--REQUIREMENTS
---------------------------------------------------------------------
require "map"
---------------------------------------------------------------------
--GLOBALS
---------------------------------------------------------------------
Mp = Map:new()
Mp:init()
function love.load()
	love.graphics.setCaption("MC2D")
	love.graphics.setBackgroundColor(104, 136, 248)
	love.graphics.setMode(512, 512)
	
	print("Beginning Map Generation")
	Mp:generateMap()
end

function love.update(dt)
		--move the camera viewpoint and check bounds of camera
	if love.keyboard.isDown( "up") then
		if Mp.viewY - 16 >= 0 then
			Mp.viewY = Mp.viewY - 16
		else
			Mp.viewY = 0
		end
    end
	
    if love.keyboard.isDown("down" )then
		if Mp.viewY + 16 <= (Mp.height * 16) - 512 then
			Mp.viewY = Mp.viewY + 16
		else
			Mp.viewY = (Mp.height * 16) - Mp.viewSize
		end
    end

    if love.keyboard.isDown("left" )then
		if Mp.viewX - 16 >= 0 then
			Mp.viewX = Mp.viewX - 16
		else
			Mp.viewX = 0
		end
    end
	
    if love.keyboard.isDown("right" )then
		if Mp.viewX + 16 <= (Mp.width * 16) - Mp.viewSize then
			Mp.viewX = Mp.viewX + 16
		else
			Mp.viewX = (Mp.width * 16) - Mp.viewSize
		end
    end
end

function love.draw()
	Mp:drawMap()
end

function love.keypressed(e)
	if e == "escape" then
		love.event.push("q")
	end
end

