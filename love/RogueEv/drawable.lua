Drawable = {}

function Drawable:new()
	o = 
	{
		x = 0,
		y = 0,
		image = nil,
	}

	setmetatable(o, self)
	self.__index = self
	return o
end


function Drawable:setPosition(x,y)
	self.x = x
	self.y = y
end

function Drawable:getPosition()
	return self.x, self.y
end

function Drawable:setImage(img)
	self.image = love.graphics.newImage(img)
end