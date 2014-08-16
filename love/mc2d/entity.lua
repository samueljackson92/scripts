
EntitiesList = {}

Entity = {}

function Entity:new()
	  o = {
			  row = 0,
			  coll = 0,
			  height = 0,
			  width = 0,
			  x = 0,
			  y = 0,
			  image,
			  eType,
		   }
	--select block image from list
      setmetatable(o, self)
      self.__index = self
      return o
end

function Entity:draw()
	love.graphics.draw(self.image, self.x + 8, self.y + 8, 0, 1, 1, self.image:getWidth()/2, self.image:getHeight() / 2)
end

function Entity:setType(index)
	self.eType = index
	self.image = EntitiesList[index]
end