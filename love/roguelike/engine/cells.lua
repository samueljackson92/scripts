Cell = {}

function Cell:new()
	o = {
		  used = false,
		  d = 8,
		  col = 0,
		  row = 0,
		  centrecol = 0,
		  centrerow = 0,
		  lcol = 0,
		  lrow = 0,
	   }

    setmetatable(o, self)
    self.__index = self
    return o
end

function Cell:setLogicalPosition(lcol, lrow)
	self.lcol = lcol
	self.lrow = lrow
end

function Cell:getPosition()
	return self.col, self.row
end

function Cell:setDimension(d)
	self.d = d
end

function Cell:setPosition(col, row)
	self.col = col
	self.row = row
end

function Cell:getCentres()
	return self.centrecol, self.centrerow
end