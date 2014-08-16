require "drawable.lua"
Block = Drawable:new()

function Block:new()
	o = 
	{
		x = 0,
		y = 0,
		r = 0,
		image = nil,
	}

	setmetatable(o, self)
	self.__index = self
	return o
end

function Block:draw()
	love.graphics.draw(self.image, self.x, self.y)
end