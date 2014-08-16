require "drawable.lua"

Entity = Drawable:new()

function Entity:new()
	o = 
	{
		r = 0,
		maxSpeed = 1.5,
		minSpeed = 0.5,
	}

	setmetatable(o, self)
	self.__index = self
	return o
end

function Entity:setRotation(r)
	self.r = r
end

function Entity:getRotation()
	return self.r
end

function Entity:draw()
	love.graphics.draw(self.image, self.x, self.y, self.r, 1, 1, 16, 16)
end

function Entity:rotate()
	x1 = self.x
	y1 = self.y
	
	x2 = love.mouse.getX( )
	y2 = love.mouse.getY( )
	r = -(math.atan2((x1-x2),(y1-y2)))
	
	self:setRotation(r)
end

function Entity:move()
	x1 = self.x
	y1 = self.y
	
	x2 = love.mouse.getX( )
	y2 = love.mouse.getY( )
	
	dt = love.timer.getDelta()
	
	deltax = dt*(x1-x2)
	deltay = dt*(y1-y2)
		
	if (math.abs(deltax) > self.maxSpeed) then deltax = self.maxSpeed * sign(deltax) end
	if (math.abs(deltay) > self.maxSpeed) then deltay = self.maxSpeed * sign(deltay) end
	
	if (math.abs(deltax) < self.minSpeed) then deltax = self.minSpeed * sign(deltax) end
	if (math.abs(deltay) < self.minSpeed) then deltay = self.minSpeed * sign(deltay) end
	
	if love.keyboard.isDown("up") then
		--entity is moving forward
		self.x = self.x - deltax
		self.y = self.y - deltay
	elseif love.keyboard.isDown("down") then
		self.x = self.x + deltax
		self.y = self.y + deltay
	end
end

function sign(num)
	if num < 0 then
		return -1
	else
		return 1
	end
end