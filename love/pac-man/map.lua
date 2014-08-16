require "block.lua"

Map = {}

function Map:new()
	o = {
			blockList = {},
			charPics = {},
			level = 1
		}

    setmetatable(o, self)
    self.__index = self
	  
	local ascii = {"#", "'"}
	  
	for i,v in ipairs(ascii) do
		local filename = v .. ".png"
		if love.filesystem.exists(filename) then
			local img = love.graphics.newImage(filename)
			o.charPics[v] = img
		else
			print("IO Error: File cannot be found")
		end
	end
	  
    return o
end

function Map:buildMap ()
	local mapname = "map" .. self.level .. ".txt"
	local linecount = 1
	
	if love.filesystem.isFile(mapname) then
		for line in love.filesystem.lines(mapname) do
		
			local temparray = {}
			
			for i = 1, #line do 
				local nb = Block:new()
				local chr = string.sub(line, i, i)
				
				nb:setChar(chr)
				nb:setImage(self.charPics[chr])
				nb:setPoisition(i, linecount)
				table.insert(temparray, nb)
			end
			
			table.insert(self.blockList, temparray)
			linecount = linecount + 1
		end
		self.level = self.level + 1
	end
	
end

function Map:getBlock(col, row)
	if row < 1 then
		row = 38
	end
	if row > 38 then
		row = 1
	end
	if col < 1 then
		col = 38
	end
	if col > 38 then
		col = 1
	end
	return self.blockList[row][col]
end

function Map:draw()
	for i,v in ipairs(self.blockList) do
		for j,w in ipairs(v) do
			w:draw()
		end
	end
end