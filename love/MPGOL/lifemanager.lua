
require "block"

LifeMan = {}

function LifeMan:new()
	o = 
	{
		blocks = {},
		width = 100,
		height = 76,
		generation = 0
	}
    setmetatable(o, self)
    self.__index = self
    return o
end

function LifeMan:init()
	for coll = 1, self.width do
		self.blocks[coll] = {}
		for row = 1, self.height do
			if coll <= 50 then
				self:newBlock(coll, row)
			elseif coll >= 51 then
				self:newBlock(coll, row)
			end
		end
	end
end

function LifeMan:drawLife()
	for i,v in ipairs(self.blocks) do
		for j,w in ipairs(v) do
			w:draw()
		end
	end
end

function LifeMan:newBlock(coll, row)
	local newBlock = Block:new()
	newBlock:setTableVal(coll, row)
	self.blocks[coll][row] = newBlock
end

function LifeMan:makeLife(x,y,e, p)
	if y < 608 then
		x = x - (x % 8)
		y = y - (y % 8)
		coll = (x / 8) + 1
		row = (y / 8) + 1
		local block = self.blocks[coll][row]
		
		if p == 1 then
			if e == true then
				if block.player ~= 1 and Game.redStats.startSquares <= Game.startSquareCap then
					Game.redStats.startSquares = Game.redStats.startSquares + 1
					block:makeAlive(1)
				end
			else
				if block.player ~= 0 then
					Game.redStats.startSquares = Game.redStats.startSquares - 1
					block:makeDead(0)
				end
			end
		elseif p == 2 then
			if e == true then
				if block.player ~= 2 and Game.blueStats.startSquares <= Game.startSquareCap then
					Game.blueStats.startSquares = Game.blueStats.startSquares + 1
					block:makeAlive(2)
				end
			else
				if block.player ~= 0 then
					Game.blueStats.startSquares = Game.blueStats.startSquares - 1
					block:makeDead(0)
				end
			end
		end
	end
end

function LifeMan:tick(player)
local death = {}
local life ={}
	local valid
	if player == 1 then
		valid = 4
	elseif player == 2 then
		valid = 2
	end
	for i,v in ipairs(self.blocks) do
		for j,w in ipairs(v) do
				local coll = w.coll
				local row = w.row
				local liveCount = 0
				
				--build array of neighbours
				local nb = {}

				local nColl, nRow = checkPlausible(coll - 1, row - 1)
				nb[1] = self.blocks[nColl][nRow]
				local nColl, nRow = checkPlausible(coll, row - 1)
				nb[2] = self.blocks[nColl][nRow]
				local nColl, nRow = checkPlausible(coll + 1, row - 1)
				nb[3] = self.blocks[nColl][nRow]
				local nColl, nRow = checkPlausible(coll - 1, row)
				nb[4] = self.blocks[nColl][nRow]
				local nColl, nRow = checkPlausible(coll + 1, row)
				nb[5] = self.blocks[nColl][nRow]
				local nColl, nRow = checkPlausible(coll - 1, row + 1)
				nb[6] = self.blocks[nColl][nRow]
				local nColl, nRow = checkPlausible(coll, row + 1)
				nb[7] = self.blocks[nColl][nRow]
				local nColl, nRow = checkPlausible(coll + 1, row + 1)
				nb[8] = self.blocks[nColl][nRow]

				
				for p,q in ipairs(nb) do
					if q.living == true and q.player == player then
						liveCount = liveCount + 1
					end
				end
				
				if liveCount < 2 or liveCount > 3 then
					--mark for death
					table.insert(death, w)
				end
				if liveCount == 3 then
					--mark for life
					table.insert(life, w)
				end
		end
	end
	
	for i,v in ipairs(death) do
		if v.player == player then
			v:makeDead(player)
		end
	end
	for i,v in ipairs(life) do
		if v.player == player or v.player == 0 or v.blockType == valid then
			v:makeAlive(player)
		end
	end
end

function checkPlausible (coll, row)
	if coll < 1 then
		coll = 100
	elseif coll > 100 then
		coll = 1
	end
				
	if row  < 1 then
		row = 76
	elseif row > 76 then
		row = 1
	end
	
	return coll, row
end

