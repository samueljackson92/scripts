function love.load()
	love.graphics.setCaption("Cube Chaser")
	love.graphics.setBackgroundColor(100, 100, 200)
	love.graphics.setMode(800, 600, false, true, 0)
	love.graphics.setColorMode("replace")
	
	blue = {
		image = love.graphics.newImage("blue.png"),
		x = 100,
		y = 100
	}
	green = {
		image = love.graphics.newImage("green.png"),
		x = 0,
		y = 0
	}
	tmr = 0
	tmr2 = 0
end

function love.draw()
	drawObjects()
end

function love.update(dt)
 tmr = tmr + dt
 tmr2 = tmr2 + dt
	 if tmr >= 0.1 then
		if love.keyboard.isDown("left") then
			blue.x = blue.x - 10
		end
		if love.keyboard.isDown("right") then
			blue.x = blue.x + 10
		end
		if love.keyboard.isDown("up") then
			blue.y = blue.y - 10
		end
		if love.keyboard.isDown("down") then
			blue.y = blue.y + 10
		end
		tmr = 0
	end
	
	--green follows
	local diffx = blue.x - green.x
	local diffy = blue.y - green.y
	
	if tmr2 >= 0.1 then
		green.x = green.x + 0.1 * diffx
		green.y = green.y + 0.1 * diffy
		tmr2 = 0
	end
	
end

function drawObjects()
	love.graphics.draw(blue.image, blue.x, blue.y)
	love.graphics.draw(green.image, green.x, green.y)
end
