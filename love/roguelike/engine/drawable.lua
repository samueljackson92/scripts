Drawable = {}

function Drawable:new()
	o = {
		  image = nil,
		  x = 0,
		  y = 0,
		  d = 32,
		  col = 0,
		  row = 0,
		  lightRange = 3,
		  feildView = {},
	   }

    setmetatable(o, self)
    self.__index = self
    return o
end

function Drawable:setImage (img)
	self.image = img
end

function Drawable:setDimension(d)
	self.d = d
end

function Drawable:setLightRange(int)
	self.lightRange = int
end

function Drawable:getLightRange()
	return self.lightRange
end

function Drawable:setPosition(col, row)
	self.col = col
	self.row = row
	self.x = (col - 1) * self.d
	self.y = (row - 1) * self.d
end

function Drawable:getPosition()
	return self.col, self.row, self.x, self.y
end

function Drawable:draw()
	love.graphics.draw(self.image, self.x -(Game.viewX), self.y -(Game.viewY))
end