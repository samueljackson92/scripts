require "engine/textures.lua"
require "engine/block.lua"

Entities = {}
--------------------------------------------------------
-- Player Object ---------------------------------------
--------------------------------------------------------

Player = Block:new()
Player:setTextureCode(1)
table.insert(Entities, Player)
function Player:new()
	o = {
		tiles = {
			left = textures.player.left,
			right = textures.player.right,
			up = textures.player.up,
			down = textures.player.down,
		},
		health = 100,
		armor = 100,
	}
	
    setmetatable(o, self)
    self.__index = self
	o:setImage(o.tiles.right)
    return o
end

function Player:draw()
	love.graphics.draw(self.image, self.x -(Game.viewX), self.y -(Game.viewY))
end

function Player:setHP(int)
	self.health = int
end

function Player:getHP()
	return self.health
end

function Player:alterHP(int)
	self.armor = self.health + int
end

function Player:setArmor(int)
	self.armor = int
end

function Player:getArmor()
	return self.armor
end

function Player:alterArmor(int)
	self.armor = self.armor + int
end

function Player:move(e)
	local col, row = self:getPosition()
	
	if e == "up" then
		row = row - 1
		self:setImage(self.tiles.up)
    end
	if e == "down" then
		row = row + 1
		self:setImage(self.tiles.down)
    end
	if e == "left" then
		col = col - 1
		self:setImage(self.tiles.left)
    end
	if e == "right" then
		col = col + 1
		self:setImage(self.tiles.right)
    end
	
	self:setPosition(col, row)
end

function Player:setViewpoint(col, row)
	x = col * 32
	y = row * 32
	if Game.dimension > 512 then
		Game.viewX = x - (Game.viewSize /2)
		Game.viewY = y - (Game.viewSize / 2)
	end
end

--change the viewpoint of the map according to player position
function Player:updateViewpoint(e)
	if e == "up" then
		if (self.y - Game.viewY)  < ((Game.viewSize/2) - Game.tileSize)  then
			if Game.viewY - Game.tileSize >= 0 then
				Game.viewY = Game.viewY - Game.tileSize
			else
				Game.viewY = 0
			end
		end
    end
	
    if e == "down" then
		if (self.y - Game.viewY)  > ((Game.viewSize/2) - Game.tileSize)  then
			if Game.viewY + Game.tileSize <= Game.dimension - Game.viewSize then
				Game.viewY = Game.viewY + Game.tileSize
			else
				Game.viewY = Game.dimension - Game.viewSize
			end
		end
    end

    if e == "left" then
		if (self.x - Game.viewX)  < ((Game.viewSize/2) - Game.tileSize)  then
			if Game.viewX - Game.tileSize >= 0 then
				Game.viewX = Game.viewX - Game.tileSize
			else
				Game.viewX = 0
			end
		end
    end
	
    if e == "right" then
		if (self.x - Game.viewX)  > ((Game.viewSize/2) - Game.tileSize) then
			if Game.viewX + Game.tileSize <= Game.dimension - Game.viewSize then
				Game.viewX = Game.viewX + Game.tileSize
			else
				Game.viewX = Game.dimension - Game.viewSize
			end
		end
    end
end

-------------------------------------------------------
-- Other Game Entities
-------------------------------------------------------

DownStairs = Block:new()
DownStairs:setTextureCode(3)
table.insert(Entities, DownStairs)

function DownStairs:new()
	o = {
		lightimg = textures.light.stair,
		darkimg = textures.dark.stair,
		hiddenimg = textures.blackness,
	}
	
    setmetatable(o, self)
    self.__index = self
	o:setImage(textures.stair)
    return o
end

function DownStairs:playerCollide(map)
	map.currentLevel = map.currentLevel + 1
	
	map:buildMap()
	map.player:setPosition(map.centrecol, map.centrerow)
	map.player:setViewpoint(map.centrecol, map.centrerow)
	map:updateLighting(map.player)
end





