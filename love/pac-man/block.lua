
Block = {}

function Block:new()
	o = {
		  image = nil,
		  char = "",
		  x = 0,
		  y = 0,
		  h = 16,
		  w = 16,
		  col = 0,
		  row = 0
	   }

    setmetatable(o, self)
    self.__index = self
    return o
end

function Block:setImage (img)
	self.image = img
end

function Block:setPoisition(col, row)
	self.col = col
	self.row = row
	self.x = (col - 1) * 16
	self.y = (row - 1) * 16
end

function Block:setChar(chr)
	self.char = chr
end

function Block:draw()
	love.graphics.draw(self.image, self.x, self.y)
end