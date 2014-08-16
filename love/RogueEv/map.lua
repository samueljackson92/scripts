
require "block.lua"
Map = {}

function Map:init()
	self.blockList = {}
	for i = 0, 15 do
		temp = {}
		for j = 0, 15 do
			b = Block:new()
			b:setPosition(i*32, j*32)
			b:setImage("images/tiles/wall.png")
			table.insert(temp, b)
		end
		table.insert(self.blockList, temp)
	end
	
	Map:buildRoom()
end

function Map:buildRoom()
	for i,v in ipairs(self.blockList) do
		for j,w in ipairs(v) do
			x,y = w:getPosition()
			if not (x == 0 or y == 0 or x == 480 or y == 480) then
				w:setImage("images/tiles/floor.png")
			end
		end
	end
end

function Map:draw()
	for i,v in ipairs(self.blockList) do
		for j,w in ipairs(v) do
			w:draw()
		end
	end
end