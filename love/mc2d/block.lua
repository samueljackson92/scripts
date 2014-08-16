
BlockList = {}

BlockList[1] = love.graphics.newImage("images/16x16test.png")
BlockList[2] = love.graphics.newImage("images/cave.png")
BlockList[3] = love.graphics.newImage("images/dirt1.png")
BlockList[4] = love.graphics.newImage("images/dirt2.png")
BlockList[5] = love.graphics.newImage("images/grass1.png")
BlockList[6] = love.graphics.newImage("images/grass2.png")

Block = {}

function Block:new()
	  o = {
			  row = 1,
			  coll = 1,
			  x = 0,
			  y = 0,
			  isSolid = false
		   }
	--slect block image from list
	  o.bkType = 1
	  o.image = BlockList[o.bkType]

      setmetatable(o, self)
      self.__index = self
      return o
end

function Block:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, 0, 0)
end

function Block:setTableVal(coll, row)
	--set the x/y and coll/row values together
	self.coll = coll
	self.row = row
	self.x = (coll -1) * 16
	self.y = (row -1) * 16
end

function Block:setType(index)
	self.bkType = index
	self.image = BlockList[index]
end