require "engine/blocks.lua"
require "engine/entities.lua"
require "engine/cells.lua"

require "engine/textures.lua"

Map = {}

function Map:new()
	o = {
			blockList = {},
			currentLevel = 0,
			entityList = {},
			cells = {},
			unusedcells = {},
			usedcells = {},
			roomLinks = {},
			level = 1,
			height = 0,
			width = 0,
			cols = 0,
			rows = 0,
			celld = 8,
			centrecol = 57,
			centrerow = 57,
			cellNumd = 16,
			minRoomSize = 3,
			maxRoomSize = 7,
			minRooms = 0,
			maxRooms = 0,
			rooms = {},
			minHyperCorridors = 5,
			maxHyperCorridors = 10,
			layout = "maze",
			corridorType = "z",
			hyperCorridorType = "z",
			srooms = false,
			player = nil,
		}

    setmetatable(o, self)
    self.__index = self
	  
    return o
end

--------------------------------------------------------------------------------------------
--Map Options ------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

function Map:setRoomSizes(rmin, rmax)
	if rmax == nil then
		self.minRoomSize = rmin
		self.maxRoomSize = rmin
	else
		self.minRoomSize = rmin
		self.maxRoomSize = rmax
	end
end

function Map:setNumRooms(rmin, rmax)
	if rmax == nil then
		self.minRooms = rmin
		self.maxRooms = rmin
	else
		self.minRooms = rmin
		self.maxRooms = rmax
	end
end

function Map:setNumHyperCorridors(rmin, rmax)
	if rmax == nil then
		self.minHyperCorridors = rmin
		self.maxHyperCorridors = rmin
	else
		self.minHyperCorridors = rmin
		self.maxHyperCorridors = rmax
	end
end

function Map:setCorridorType(str)
	self.corridorType = str
end

function Map:setHyperCorridorType(str)
	self.hyperCorridorType = str
end

function Map:squareRooms(bool)
	self.srooms = bool
end

function Map:setLayout(str)
	self.layout = str
end

function Map:setWorldSize(int)
	Game.dimension = Game.viewSize * int
end
--------------------------------------------------------------------------------------------
--Main Map Generation Algorithm-------------------------------------------------------------
--------------------------------------------------------------------------------------------

function Map:buildMap ()
	self:wipe()
	
	
	math.randomseed(os.time())
	math.random()
	
	self.player = Player:new()
	self.player:setLit(true)
	self.player:setLightRange(3)
	
	self:setWorldSize(math.random(1, 4))
	self.tableSize = (Game.dimension / Game.tileSize)
	self.cellNumd = self.tableSize / Game.logicalCellWidth
	
	self.celld = Game.logicalCellWidth
	
	self:addEntity(self.player)
	
	walls = love.graphics.newSpriteBatch(textures.light.wall, math.pow(self.tableSize, 2))
	floors = love.graphics.newSpriteBatch(textures.light.stone, math.pow(self.tableSize, 2))

	--populate self with walls
	for i = 1, self.tableSize do
		local temparr = {}
		for j = 1, self.tableSize do
			local nb = Wall:new()
			nb:setPosition(j, i)
			table.insert(temparr, nb)
		end
		table.insert(self.blockList, temparr)
	end
	
	self.layout = nil
	
	local maptype = math.random(2)
	--begin generating the map
	if self.layout == "grid" or maptype == 1 then
	
		
		--build logical cells
		for i = 1, self.cellNumd  do
			local temparr = {}
			for j = 1, self.cellNumd  do
				local nc = Cell:new()
				nc:setPosition((i  * self.celld) - (self.celld -1), (j * self.celld) - (self.celld - 1))
				nc:setLogicalPosition(i, j)
				nc:setDimension(self.celld)
				table.insert(temparr, nc)
				table.insert(self.unusedcells, nc)
			end
			table.insert(self.cells, temparr)
		end
	
		local newcol, newrow = 0, 0
		local numRooms = math.random(self.minRooms, self.maxRooms)
		
		if numRooms > math.pow(self.cellNumd, 2) then
			numRooms = math.pow(self.cellNumd, 2)
		end
		
		if self.maxRoomSize > self.celld - 1 then
			self.maxRoomSize = self.celld - 1
		end
		
		local col, row = (self.tableSize/2), (self.tableSize/2)
		local newcell = self:getCell(((col - (col % self.celld)) /self.celld), ((row - (row % self.celld)) /self.celld))
		col, row = newcell.col + self.celld/2, newcell.row + self.celld/2	
		
		self.centrecol = col
		self.centrerow = row
		
		newcell.centrecol = col
		newcell.centrerow = row
		newcell.used = true
		table.insert(self.usedcells, newcell)
		
		local oldcell = newcell	
		local rooms = 0
		local newcell
		
		--build rooms
		while (rooms < numRooms -1) do
			newcell = self:pickRandomDirection(oldcell.lcol, oldcell.lrow)
			if newcell == nil then
				while (true) do
					oldcell = self:getRandomCell()
					newcell = self:pickRandomDirection(oldcell.lcol, oldcell.lrow)
					if newcell ~= nil then
						break
					else
						table.insert(self.usedcells, oldcell)
					end
				end
			end
			while (true) do
				newcol = math.random(newcell.col, newcell.col + self.celld)
				newrow = math.random(newcell.row, newcell.row + self.celld)
				neww, newh = self:getNewRoomDimensions()

				if self:checkRoomFits(newcol, newrow, neww, newh, newcell) == true then
					newcell.centrecol = newcol
					newcell.centrerow = newrow
					self:buildRoom(newcol, newrow, neww, newh)
					table.insert(self.roomLinks, {olc = oldcell.centrecol, olr = oldcell.centrerow, nc = newcell.centrecol, nr = newcell.centrerow})
					table.insert(self.usedcells, newcell)
					newcell.used = true
					oldcell = newcell
					rooms = rooms + 1
					break
				end
			end
		end
		
		--link rooms
		if self.corridorType == "z" then
			for i,v in ipairs(self.roomLinks) do
				self:buildCorridor(v.olc, v.olr, v.nc, v.nr)
			end
		elseif self.corridorType == "s" then
			for i,v in ipairs(self.roomLinks) do
				self:buildStraightCorridor(v.olc, v.olr, v.nc, v.nr)
			end
		elseif self.corridorType == "b" then
			for i,v in ipairs(self.roomLinks) do
				local rnd = math.random(2)
				if rnd == 1 then
					self:buildStraightCorridor(v.olc, v.olr, v.nc, v.nr)
				else
					self:buildCorridor(v.olc, v.olr, v.nc, v.nr)
				end
			end	
		end
		
		local rnd = math.random(self.minHyperCorridors, self.maxHyperCorridors)
		
		if self.hyperCorridorType == "z" then
			for i = 1, rnd do
				local ac, ar = self:getRandomRoomCentre()
				local bc, br = self:getRandomRoomCentre()
				self:buildCorridor(ac, ar, bc, br)
			end
		elseif self.hyperCorridorType == "s" then
			for i = 1, rnd do
				local ac, ar = self:getRandomRoomCentre()
				local bc, br = self:getRandomRoomCentre()
				self:buildStraightCorridor(ac, ar, bc, br)
			end
		elseif self.hyperCorridorType == "b" then
			for i = 1, rnd do
				local weight = math.random(2)
				if weight == 1 then
					local ac, ar = self:getRandomRoomCentre()
					local bc, br = self:getRandomRoomCentre()
					self:buildStraightCorridor(ac, ar, bc, br)
				else
					local ac, ar = self:getRandomRoomCentre()
					local bc, br = self:getRandomRoomCentre()
					self:buildCorridor(ac, ar, bc, br)
				end
			end	
		end
		
		self:buildStartRoom(self:getCentre())
		
		col, row = math.random(2, self.tableSize -1), math.random(2, self.tableSize -1)
		self:buildTeleportRoom(col, row)
		self:buildCorridor(oldcell.centrecol, oldcell.centrerow, col, row)
		

	elseif self.layout == "maze" or maptype == 2 then
	
		self.frontier = {}
		
		local start = self:getBlock(math.floor(self.tableSize/2), math.floor(self.tableSize/2))
		local col, row = start:getPosition()
		
		self:getNeighbors(start)
		
		start = Stone:new()
		start.isInMaze = true
		self:setBlock(start, col, row)
		
		math.randomseed(os.time())
		
		while #self.frontier > 0 do	
			local nextBlock = table.remove(self.frontier, math.random(#self.frontier))
			local col, row = nextBlock:getPosition()
			
			self:findNeighbor(nextBlock)
			self:getNeighbors(nextBlock)
			
			local nb = Stone:new()
			nb.isInMaze = true
			self:setBlock(nb, col, row)
		end

		self:buildStartRoom()
		self:buildTeleportRoom(math.random(2, self.tableSize -1), math.random(2, self.tableSize -1))
		
	elseif self.layout == "open" or maptype == 3 then
		
		for i = 2, self.tableSize - 1 do
			for j = 2, self.tableSize - 1 do
				local nb = Stone:new()
				self:setBlock(nb, i, j)
			end
		end
		self:buildStartRoom()
		self:buildTeleportRoom(math.random(2, self.tableSize -1), math.random(2, self.tableSize -1))
	end
	
	self.player:setPosition(self:getCentre())
	self.player:setViewpoint(self:getCentre())
	
	for i,v in ipairs(self.blockList) do
		for j,w in ipairs(v) do
			if w.lightimg == textures.light.wall then
				walls:add(w.x, w.y)
			else
				floors:add(w.x,w.y)
			end
		end
	end
	
	self:updateEntities()
end

function Map:findNeighbor(obj)
	local col, row = obj:getPosition()
	local rnd = math.random(4)
	
	while true do
		if rnd == 1 then
			if col +2 < self.tableSize then
				local oldBlock = self:getBlock(col +2, row)
				if oldBlock.isInMaze == true then
					local nb = Stone:new()
					nb.isInMaze = true
					self:setBlock(nb, col + 1, row)
					return true
				end
			end
			rnd = 2
		end
		if rnd == 2 then
			if col -2 > 1 then
				local oldBlock = self:getBlock(col -2, row)
				if oldBlock.isInMaze == true then
					local nb = Stone:new()
					nb.isInMaze = true
					self:setBlock(nb, col - 1, row)
					return true
				end
			end
			rnd = 3
		end
		if rnd == 3 then
			if row + 2 < self.tableSize then
				local oldBlock = self:getBlock(col, row + 2)
				if oldBlock.isInMaze == true then
					local nb = Stone:new()
					nb.isInMaze = true
					self:setBlock(nb, col, row + 1)
					return true
				end
			end
			rnd = 4
		end
		if rnd == 4 then
			if row -2 > 1 then
				local oldBlock = self:getBlock(col, row - 2)
				if oldBlock.isInMaze == true then
					local nb = Stone:new()
					nb.isInMaze = true
					self:setBlock(nb, col, row - 1)
					return true
				end
			end
			rnd = 1
		end
	end
end

function Map:getNeighbors(obj)
	local col, row = obj:getPosition()
	
	if col +2 < self.tableSize then
		local b = self:getBlock(col +2, row)
		if b.isInMaze == false then
			if self:checkInFrontier (b) == false then
				table.insert(self.frontier, b)
			end
		end
	end
	
	if col -2 > 1 then
		local b = self:getBlock(col -2, row)
		if b.isInMaze == false then
			if self:checkInFrontier (b) == false then
				table.insert(self.frontier, b)
			end
		end
	end
	
	if row + 2 < self.tableSize then
		local b = self:getBlock(col, row +2)
		if b.isInMaze == false then
			if self:checkInFrontier (b) == false then
				table.insert(self.frontier, b)
			end
		end
	end
	
	if row -2 > 1 then
		local b = self:getBlock(col, row -2)
		if b.isInMaze == false then
			if self:checkInFrontier(b) == false then
				table.insert(self.frontier, b)
			end
		end
	end
end

function Map:checkInFrontier(obj)
	for i,v in ipairs(self.frontier) do
		if obj == v then
			return true
		end
	end
	
	return false
end


--------------------------------------------------------------------------------------------
--Various Utility Functions-----------------------------------------------------------------
--------------------------------------------------------------------------------------------
function Map:wipe()
	self.blockList = {}
	self.entityList = {}
	self.cells = {}
end

function Map:addPlayer(obj)
	self.player = obj
end

function Map:addEntity(obj)
	table.insert(self.entityList, obj)
end

function Map:getEntity(index)
	return self.entityList[index]
end

function Map:removeEntity(index)
	table.remove(self.entityList, index)
end

function Map:updateEntities()
	--self:updateLighting(self.player)
	for i,v in ipairs(self.entityList) do
		if type(v.playerCollide) == "function" and self.player.col == v.col and self.player.row == v.row then
			v:playerCollide(self)
		end
	end
end

function Map:getCentre()
	return self.centrecol, self.centrerow
end

function Map:getRoom(col, row)
	for i,v in ipairs(self.rooms) do
		if v.centreCol == col and v.centreRow == row then
			return v
		end
	end
end

function Map:getRooms()
	return self.rooms
end

function Map:getBlock(col, row)
	return self.blockList[row][col]
end

function Map:setBlock(obj, col, row)
	obj:setPosition(col, row)
	self.blockList[row][col] = obj
end

function Map:getCell(col, row)
	return self.cells[col][row]
end

function Map:getRandomCell()
	math.random()
	local len = #self.usedcells
	return table.remove(self.usedcells, math.random(len))
end

function Map:getRandomRoomCentre()
	math.random()
	local c = self:getCell(math.random(self.cellNumd), math.random(self.cellNumd))
	return c:getCentres()
end

function Map:checkWallCollision(obj, e)
	local col, row = obj:getPosition()
	
	if e == "up" then
		row = row - 1
    end
	if e == "down" then
		row = row + 1
    end
	if e == "left" then
		col = col - 1
    end
	if e == "right" then
		col = col + 1
    end
	
	local b = self:getBlock(col, row)
	if b:isSolid() then
		return true
	end
	return false
end

function Map:draw()
	--interate through blocks array, draw those which are on screen
	love.graphics.draw(walls, 0 - Game.viewX, 0 - Game.viewY)
	love.graphics.draw(floors, 0 - Game.viewX,0 - Game.viewY)
	
	for i,v in ipairs(self.entityList) do
		if v.x >= Game.viewX and v.x <= Game.viewX + Game.viewSize
			and v.y >= Game.viewY and v.y <= Game.viewY + Game.viewSize
			then
			v:draw()
		end
	end
end

--------------------------------------------------------------------------------------------
--Room Building Functions-------------------------------------------------------------------
--------------------------------------------------------------------------------------------
function Map:buildStartRoom(col, row)
	if col == nil or row ==  nil then
		col, row = math.floor(self.tableSize / 2), math.floor(self.tableSize /2)
	end
	
	self:buildRoom(col, row, 7, 7)
	self.centrecol = col
	self.centrerow = row
	
end

function Map:buildTeleportRoom(col, row)

	if col == self.centrecol and row == self.centrerow then
		col= col -1
	end
	
	if col < 5 then
		col = 5
	elseif col > self.tableSize - 4 then
		col = self.tableSize - 4
	end
	
	if row < 5 then
		row = 5
	elseif row > self.tableSize - 4 then
		row = self.tableSize - 4
	end
	
	self:buildRoom(col, row, 7, 7)
	
	local down = DownStairs:new()
	down:setPosition(col, row)
	self:addEntity(down)
end

function Map:pickRandomDirection(col, row)
	
	math.random()
	local pass = 0
	local c
	local rnd = math.random(1,4)
	
	while (true) do
		if rnd == 1 then
			if row - 1 >= 1 then
				c = self:getCell(col, row -1)
				if c.used == false then
					return c
				end
			end
		rnd = 2
		end
		if rnd == 2 then
			if row + 1 <= self.cellNumd then
				c = self:getCell(col, row + 1)
				if c.used == false then
					return c
				end
			end
		rnd = 3
		end
		if rnd == 3 then
			if col - 1 >= 1 then
				c = self:getCell(col -1 , row)
				if c.used == false then
					return c
				end
			end
		rnd = 4
		end
		if rnd == 4 then
			if col + 1 <= self.cellNumd then
				c = self:getCell(col + 1, row)
				if c.used == false then
					return c
				end
			end
		rnd = 1
		end
		pass = pass + 1
		if pass >= 4 then
			return nil
		end
	end
end

function Map:getNewRoomDimensions()
	if self.srooms == true then
		while (true) do
			rnd = math.random(self.minRoomSize, self.maxRoomSize)
			if rnd % 2 ~= 0 then
				return rnd, rnd
			end
		end
	else
		return math.random(self.minRoomSize, self.maxRoomSize), math.random(self.minRoomSize, self.maxRoomSize)
	end
end

function Map:checkRoomFits(col, row, w, h, c)
	local pw, nw, ph, nh
	if w % 2 == 0 then
		pw = w /2
		nw = (w /2) -1
	else
		pw = math.floor(w/2)
		nw = math.floor(w/2)
	end
	if h % 2 == 0 then
		ph = h /2
		nh = (h /2) -1
	else
		ph = math.floor(h/2)
		nh = math.floor(h/2)
	end
	for i = col -nw -1, col+pw + 1 do
		for j = row -nh -1, row +ph + 1 do
			if i <= 0 or j <= 0 or i > self.tableSize or j > self.tableSize then
				return false
			elseif i < c.col or j < c.row or i > c.col + self.celld or j > c.row + self.celld then
				return false
			else
				local b = self:getBlock(i, j)
				if b:isSolid() == false then
					return false
				end
			end
		end
	end
	return true
end

function Map:checkRoomFitsTrueRandom(col, row, w, h)
	local pw, nw, ph, nh
	if w % 2 == 0 then
		pw = w /2
		nw = (w /2) -1
	else
		pw = math.floor(w/2)
		nw = math.floor(w/2)
	end
	if h % 2 == 0 then
		ph = h /2
		nh = (h /2) -1
	else
		ph = math.floor(h/2)
		nh = math.floor(h/2)
	end
	
	for i = col -nw - 1, col+pw + 1 do
		for j = row -nh - 1, row +ph + 1 do
			if i <= 0 or j <= 0 or i > self.tableSize or j > self.tableSize then
				return false
			else
				local b = self:getBlock(i, j)
				if b:isSolid() == false then
					return false
				end
			end
		end
	end
	return true
end

function Map:buildRoom(col, row, w, h)
	--if even number, it will take the lowest median value
	local room = {}
	local roomtiles = {}
	local pw, nw, ph, nh
	
	if w % 2 == 0 then
		pw = w /2
		nw = (w /2) -1
	else
		pw = math.floor(w/2)
		nw = math.floor(w/2)
	end
	if h % 2 == 0 then
		ph = h /2
		nh = (h /2) -1
	else
		ph = math.floor(h/2)
		nh = math.floor(h/2)
	end
	
	for i = col -nw, col +pw do
		for j = row -nh, row +ph do
			self:setBlock(Stone:new(), i, j)
			table.insert(roomtiles, b)
		end
	end

	room.centrecol = col
	room.centrerow = row
	room.tiles = roomtiles
	table.insert(self.rooms, room)
end

--------------------------------------------------------------------------------------------
--Corridor Building Functions---------------------------------------------------------------
--------------------------------------------------------------------------------------------

function Map:buildCorridor(olc, olr, nc, nr)
	if math.abs(nc - olc) >= math.abs(nr - olr) then
		if (nc - olc) < 0 then
			self:buildXPath(olc, olr, nc, nr, -1)
		else
			self:buildXPath(olc, olr, nc, nr, 1)
		end
	else
		if (nr - olr) < 0 then
			self:buildYPath(olc, olr, nc, nr, -1)
		else
			self:buildYPath(olc, olr, nc, nr, 1)
		end
	end
end

function Map:checkBlockInRoom(b, col, row)
	local room = self:getRoom(col, row)
	for i,v in ipairs(room.tiles) do
		if b.col == v.col and b.row == v.row then
			return true
		end
	end
	return false
end

function Map:buildXPath(olc, olr, nc, nr, step)
	--x is bigger
	local halfway = olc + math.floor((nc - olc) /2)
	
	--halfway through x
	for i = olc, halfway, step do
		self:setBlock(Stone:new(), i, olr)
	end
	
	--build y
	if (nr - olr) < 0 then
		for j = olr, nr, -1 do
			self:setBlock(Stone:new(), halfway, j)
		end
	else
		for j = olr, nr do
			self:setBlock(Stone:new(), halfway, j)
		end
	end
	
	--build other half x
	for i = halfway, nc, step do
		self:setBlock(Stone:new(), i, nr)
	end
end

function Map:buildYPath(olc, olr, nc, nr, step)
	local halfway = olr + math.floor((nr - olr) /2)
	for i = olr, halfway, step do
		self:setBlock(Stone:new(), olc, i)
	end
	
	if (nc - olc) < 0 then
		for j = olc, nc, -1 do
			self:setBlock(Stone:new(), j, halfway)
		end
	else
		for j = olc, nc do
			self:setBlock(Stone:new(), j, halfway)
		end
	end
	
	for i = halfway, nr, step do
		self:setBlock(Stone:new(), nc, i)
	end
end

function Map:buildStraightCorridor(olc, olr, nc, nr)
	local stepc, stepr = 1, 1
	if olc > nc then
		stepc = -1
	end
	if olr > nr then
		stepr = -1
	end
	local rnd = math.random(2)
	if rnd == 1 then
		for i = olc, nc, stepc do
			self:setBlock(Stone:new(), i, olr)
		end
		
		for i = olr, nr, stepr do
			self:setBlock(Stone:new(), nc, i)
		end
	else
		for i = olr, nr, stepr do
			self:setBlock(Stone:new(), olc, i)
		end
		for i = olc, nc, stepc do
			self:setBlock(Stone:new(), i, nr)
		end
	end
end

--------------------------------------------------------------------------------------------
--Lighting Logic----------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

function Map:updateLighting(obj)
	self:removeLighting(obj)
	self:applyLighting(obj)
end

function Map:checkInView(tbl, b)
	for i,v in ipairs(tbl) do
		if v.col == b.col and v.row == b.row then
			return true
		end
	end
	return false
end

function Map:applyLighting(obj)
	local col, row = obj:getPosition()
	local lightRange = obj:getLightRange()
	obj.feildView = {}

	for i = col - lightRange, col + lightRange do
		for j = row - lightRange, row + lightRange do
			if (i == col - lightRange or j == row - lightRange
			or i == col + lightRange or j == row + lightRange)
			then
				local x0, x1, y0, y1 = col, i, row, j
				local dx, dy = math.abs(x1-x0), math.abs(y1-y0) 
				local sx, sy
				local hitSolid = false
				
				if x0 < x1 then sx = 1 else sx = -1 end
				if y0 < y1 then sy = 1 else sy = -1 end
				
				err = dx-dy
				
				while not ((x0 == x1) and (y0 == y1)) do
					if hitSolid == true then break end
					
					local b = self:getBlock(x0,y0)
					
					if not ((x0 == col - lightRange + 1 and y0 == row - lightRange + 1)
					or (x0 == col + lightRange -1 and y0 == row + lightRange -1)
					or (x0 == col - lightRange + 1 and y0 == row + lightRange  -1)
					or (x0 == col + lightRange -1 and y0 == row - lightRange +1))
					then
						self:lightTile(b)
						if self:checkInView(obj.feildView, b) == false then
							table.insert(obj.feildView, b)
						end
					end
					
					hitSolid = b:isSolid()
					

					
					e2 = 2*err
					if e2 > -dy then 
						err = err - dy
						x0 = x0 + sx
					end
					if e2 <  dx then 
						err = err + dx
						y0 = y0 + sy
					end
				end
			end
		end
	end
	
	for i,v in ipairs(self.entityList) do
		if self:checkInView(obj.feildView, v) == true then
			self:lightTile(v)
		end
	end
end

function Map:removeLighting(obj)
	for i,v in ipairs(obj.feildView) do
		self:darkenTile(v)
	end
	for i,v in ipairs(self.entityList) do
		self:darkenTile(v)
	end
end

function Map:lightTile(b)
	b:setDark(false)
	b:setLit(true)
end

function Map:darkenTile(b)
	b:setLit(false)
end

--------------------------------------------------------------------------------------------
--Map Loading/Saving Functions--------------------------------------------------------------
--------------------------------------------------------------------------------------------
function Map:saveVisMap(name)
	local line, data
	data = ""
	for i,v in ipairs(self.blockList) do
		line = ""
		for j,w in ipairs(v) do
			local chr
			if w:isSolid() == true then
				chr = "#"
			else
				chr = "."
			end
			line = line .. chr
		end
		line = line .. "\n"
		data = data .. line
	end
	love.filesystem.write(name, data)
end
