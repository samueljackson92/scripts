Block = {}
BlockImages = {}
BlockImages[1] = love.graphics.newImage("images/redalive.png")
BlockImages[2] = love.graphics.newImage("images/reddead.png")
BlockImages[3] = love.graphics.newImage("images/bluealive.png")
BlockImages[4] = love.graphics.newImage("images/bluedead.png")
BlockImages[5] = love.graphics.newImage("images/black8.png")

function Block:new()
	o = 
	{
		living = false,
		image = BlockImages[5],
		player = 0,
		blockType = 0,
		row = 1,
		coll = 1,
		x = 0,
		y = 0
	}

      setmetatable(o, self)
      self.__index = self
      return o
end

function Block:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

function Block:setImage(e)
	self.blockType = e
	self.image = BlockImages[e]
end

function Block:setTableVal(coll, row)
	self.coll = coll
	self.row = row
	self.x = (coll - 1) * 8
	self.y = (row - 1) * 8
end

function Block:makeAlive(e)
	self.living = true
	self.player = e
	if e == 1 then
		self.image = BlockImages[1]
		self.blockType = 1
	elseif e == 2 then
		self.image = BlockImages[3]
		self.blockType = 3
	end
end

function Block:makeDead(e)
	self.player = e
	self.living = false
	if e == 1 then
		self.image = BlockImages[2]
		self.blockType = 2
	elseif e == 2 then
		self.image = BlockImages[4]
		self.blockType = 4
	elseif e == 0 then
		self.image = BlockImages[5]
		self.blockType = 0
	end
end
