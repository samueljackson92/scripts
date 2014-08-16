
require "block"

Map = {}

function Map:new()

	o = {
			blocks = {},
			height = 128,
			width = 96,
			viewX = 32 * 16,
			viewY = 32 * 16,
			viewSize = 512
		  }
		  
	setmetatable(o, self)
	self.__index = self
	return o
end

function Map:init()
	for coll = 1, self.width do
		self.blocks[coll] = {}
		for row = 1, self.height do
			self:newBlock(coll, row, 1)
		end
	end
end

function Map:generateMap()

	math.randomseed(os.time())
	math.random()
	
	--generate a map of blocks
	print("Building Sea Level...........")
	for row = 1, self.height do
		for coll = 1, self.width do
			if row >= 62 then
			
				local bType = 1
				local chance = math.random(5)
				
				if chance == 1 then
					bType = 4
				else
					bType = 3
				end
				
				self:newBlock(coll, row, bType)
			end
		end
	end
	
	local mtNum = math.random(3)
	
	print("Making Mountains...........")
	for i = 1, mtNum do
		self:makeMountain()
	end
	
	self:growGrass()
end

function Map:drawMap()
	
	--store the true x/y values of the blocks while they are drawn offset for the camera
	local tempX = 0
	local tempY = 0
	
	--interate through blocks array, draw those which are on screen
	for i,v in ipairs(self.blocks) do
		for j, w in ipairs(v) do
			if w.x >= self.viewX and w.x <= self.viewX + self.viewSize
				and w.y >= self.viewY and w.y <= self.viewY + self.viewSize
				then
					tempX = w.x
					tempY = w.y
					w.x = w.x -(self.viewX) --offset the x/y position for the camera
					w.y = w.y -(self.viewY)
					w:draw()
					w.x = tempX --set there x/y positions back to there 'true' position
					w.y = tempY
			end
		end
	end
end

function Map:newBlock(coll, row, bType)
	local newBlock = Block:new()
	newBlock:setTableVal(coll, row)
	newBlock:setType(bType)
	if coll >= 1 and coll <= 96 then
		self.blocks[coll][row] = newBlock
	end
end

function Map:makeMountain()
	local collIncretment = 0
	local widthIncretment = 0
	local mtColl = math.random(96)
	local mtWidth = math.random(5)
	local mtHeight = math.random(40)
	
	--j == coll
	--i == row
	for i = (62 - mtHeight), 62 do
		collIncretment = math.random(3)
		widthIncretment = math.random(3)
		
		widthIncretment =  collIncretment + widthIncretment
		mtColl = mtColl - collIncretment
		mtWidth = mtWidth + widthIncretment
		
		for j = mtColl, (mtColl + mtWidth) do
				local bType = 1
				local chance = math.random(5)
				
				if chance == 1 then
					bType = 4
				else
					bType = 3
				end
				
				if j <= 96 and j >= 1 then
					self:newBlock(j, i, bType)
				end
		end
	end
end

function Map:growGrass()
	for i,v in ipairs(self.blocks) do
		for j,w in ipairs(v) do
			if (w.bkType == 3 or w.bkType == 4 ) and self.blocks[w.coll][w.row - 1].bkType == 1 then
				local p = math.random(2)
				p  = p + 4
				w:setType(p)
			end
		end
	end
end

