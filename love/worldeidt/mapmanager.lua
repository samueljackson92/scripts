MapMan = {}
BlockImages = {}
BlockImages[1] = love.graphics.newImage("images/pman.png")
BlockImages[2] = love.graphics.newImage("images/'.png")
BlockImages[3] = love.graphics.newImage("images/#.png")

function MapMan:new(w, h)
	o = 
	{
		blocks = {}
	}
    setmetatable(o, self)
    self.__index = self
    return o
end

function MapMan:drawMap()
	for i,v in ipairs(self.blocks) do
		for j,w in ipairs(v) do
			love.graphics.draw(BlockImages[w], (j - 1) * 16, (i - 1) * 16)
		end
	end
end

function MapMan:loadMap (mapname)
	local linecount = 0
	
	if love.filesystem.isFile(mapname) then
		for line in love.filesystem.lines(mapname) do
		
			local temparray = {}
			
			for i = 1, #line do 
				local chr = string.sub(line, i, i)
				local num
				
				if chr == "'" then
					num = 2
				elseif chr == "#" then
					num = 3
				end
				
				table.insert(temparray, num)
			end
			table.insert(self.blocks, temparray)
			linecount = linecount + 1
		end
	end
	
end

function MapMan:saveMap(name)
	local line, data, chr
	data = ""
	for i,v in ipairs(self.blocks) do
		line = ""
		for j,w in ipairs(v) do
			if w == 2 then
				chr = "'"
			elseif w == 3 then
				chr = "#"
			end
			line = line .. chr
		end
		line = line .. "\n"
		data = data .. line
	end

	love.filesystem.write(name, data)
end


function MapMan:playerDraw()
	if love.mouse.isDown("l") then
		local x,y = love.mouse.getPosition()
		if x < Game.width and y < Game.height then
			x = x - (x % 16)
			y = y - (y % 16)
			local coll = (x / 16) + 1
			local row = (y / 16) + 1
			if Game.brushSize == 1 then
				self.blocks[row][coll] = Game.brush
			elseif Game.brushSize == 2 then
				if coll - 1 > 0 or row - 1 > 0 then
					self.blocks[row][coll] = Game.brush
					self.blocks[row - 1][coll] = Game.brush
					self.blocks[row][coll - 1] = Game.brush
					self.blocks[row - 1][coll - 1] = Game.brush
				end
			elseif Game.brushSize == 3 then
				if coll - 1 > 0 and row - 1 > 0 and coll + 1 < Game.noColls + 1 and row + 1 < Game.noRows then
					self.blocks[row][coll] = Game.brush
					self.blocks[row - 1][coll] = Game.brush
					self.blocks[row][coll - 1] = Game.brush
					self.blocks[row - 1][coll - 1] = Game.brush
					self.blocks[row - 1][coll + 1] = Game.brush
					self.blocks[row][coll + 1] = Game.brush
					self.blocks[row + 1][coll + 1] = Game.brush
					self.blocks[row + 1][coll] = Game.brush
					self.blocks[row + 1][coll - 1] = Game.brush
				end
			elseif Game.brushSize == 4 then
				if coll - 2 > 0 and row - 2 > 0 and coll + 2 < Game.noColls and row + 2 < Game.noRows then
					self.blocks[row][coll] = Game.brush
					self.blocks[row - 1][coll] = Game.brush
					self.blocks[row][coll - 1] = Game.brush
					self.blocks[row - 1][coll - 1] = Game.brush
					self.blocks[row - 1][coll + 1] = Game.brush
					self.blocks[row][coll + 1] = Game.brush
					self.blocks[row + 1][coll + 1] = Game.brush
					self.blocks[row + 1][coll] = Game.brush
					self.blocks[row + 1][coll - 1] = Game.brush
					self.blocks[row - 2 ][coll - 2] = Game.brush
					self.blocks[row - 1 ][coll - 2] = Game.brush
					self.blocks[row][coll - 2] = Game.brush
					self.blocks[row + 1][coll - 2] = Game.brush
					self.blocks[row + 2][coll - 2] = Game.brush
					self.blocks[row - 2][coll - 1] = Game.brush
					self.blocks[row + 2][coll - 1] = Game.brush
					self.blocks[row - 2][coll] = Game.brush
					self.blocks[row + 2][coll] = Game.brush
					self.blocks[row - 2][coll + 1] = Game.brush
					self.blocks[row + 2][coll + 1] = Game.brush
					self.blocks[row - 2][coll + 2] = Game.brush
					self.blocks[row - 1][coll + 2] = Game.brush
					self.blocks[row][coll + 2] = Game.brush
					self.blocks[row + 1][coll + 2] = Game.brush
					self.blocks[row + 2][coll + 2] = Game.brush
				end
			end
		end
	end
end