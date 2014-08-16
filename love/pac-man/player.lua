
Player = {}

function Player:new()
	o = {
		  image = nil,
		  x = 0,
		  y = 0,
		  h = 32,
		  w = 32
	   }

    setmetatable(o, self)
    self.__index = self
    return o
end

function Player:setImage(img)
	self.image = img
end

function Player:setPosition(x, y)
	self.x = x
	self.y = y
end

function Player:getPosition()
	return self.x, self.y
end

function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end