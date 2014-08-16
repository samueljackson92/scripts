
require "player.lua"

Pacman = Player:new()
Pacman:setImage(love.graphics.newImage("pman.png"))
Pacman:setPosition(272, 272)
Pacman.currentDir = "left"
Pacman.nextDir = "left"
Pacman.speed = 2-- ensure this is divisible by 16

function Pacman:setNextDir(e)
	self.nextDir = e
end

function Pacman:checkChangeDir(x, y)
	local e = self.nextDir
	local col, row = getTableVal(x, y)
	local b1, b2
		
	if e == "up" then
		b1 = map:getBlock(col, row - 1)
		b2 = map:getBlock(col + 1, row - 1)
	elseif e == "down" then
		b1 = map:getBlock(col, row + 2)
		b2 = map:getBlock(col + 1, row + 2)	
	elseif e == "left" then
		b1 = map:getBlock(col - 1, row)
		b2 = map:getBlock(col - 1, row + 1)	
	elseif e == "right" then
		b1 = map:getBlock(col + 2, row)
		b2 = map:getBlock(col + 2, row + 1)
	end
		
	if b1.char ~= "#" and b2.char ~= "#" then
		return true
	end
	
	return false
end

function Pacman:move(dt)
	local x, y = self:getPosition()
	
	--check if needs to wrap offscreen
	if y < -32 then
		y = 608
	end
	if y > 608 then
		y = -32
	end
	if x < -32 then
		x = 608
	end
	if x > 608 then
		x = -32
	end
	
	local col, row = getTableVal(x, y)
	local b1, b2, velocity
	--move pman
	if self.currentDir == "up" then
		b1 = map:getBlock(col, row - 1)
		b2 = map:getBlock(col + 1, row - 1)
		
		velocity = y - self.speed
		if (b1.char == "#" and velocity < b1.y + b1.h) or 
		(b2.char == "#" and velocity < b2.y + b2.h) then
			y = math.max((b1.y + b1.h), (b2.y + b2.h))
			self.currentDir = self.nextDir
		else
			if self.currentDir ~= self.nextDir and
			(y % 16 == 0) and self:checkChangeDir(x, y) == true then
				self.currentDir = self.nextDir
			else
				y = velocity
			end
		end
	end
	
	if self.currentDir == "down" then
		b1 = map:getBlock(col, row + 2)
		b2 = map:getBlock(col + 1, row + 2)
		
		velocity = y + self.speed
		if (b1.char == "#" and velocity + self.h > b1.y) or 
		(b2.char == "#" and velocity + self.h > b2.y) then
			y = math.min((b1.y - self.h), (b2.y - self.h))
			self.currentDir = self.nextDir
		else
			if self.currentDir ~= self.nextDir and 
			(y % 16 == 0) and self:checkChangeDir(x, y) == true then
				self.currentDir = self.nextDir
			else
				y = velocity
			end
		end
	end
	if self.currentDir == "left" then
		b1 = map:getBlock(col - 1, row)
		b2 = map:getBlock(col - 1, row + 1)
		
		velocity = x - self.speed
		if (b1.char == "#" and velocity < b1.x + b1.w) or 
		(b2.char == "#" and velocity < b2.x + b2.w) then
			x = math.max((b1.x + b1.w), (b2.x + b2.w))
			self.currentDir = self.nextDir
		else
			if self.currentDir ~= self.nextDir and 
			(x % 16 == 0) and self:checkChangeDir(x, y) == true then
				self.currentDir = self.nextDir
			else
				x = velocity
			end
		end
	end
	if self.currentDir == "right" then
		b1 = map:getBlock(col + 2, row)
		b2 = map:getBlock(col + 2, row + 1)
		
				
		velocity = x + self.speed
		if (b1.char == "#" and velocity + self.w > b1.x) or 
		(b2.char == "#" and velocity + self.w > b2.x) then
			x = math.min((b1.x - self.w), (b2.x - self.w))
			self.currentDir = self.nextDir
		else
			if self.currentDir ~= self.nextDir and 
			(x % 16 == 0) and self:checkChangeDir(x, y) == true then
				self.currentDir = self.nextDir
			else
				x = velocity
			end
		end
	end

	self:setPosition(x, y)
end

function getTableVal(x, y)
	local col = ((x - (x % 16)) / 16) + 1
	local row = ((y - (y % 16)) / 16) + 1
	
	return col, row
end


