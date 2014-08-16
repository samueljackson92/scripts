--Items File
--Instatiate all of the different types of objects in the game
require "engine/textures.lua"
require "engine/block.lua"

Blocks = {}
-------------------------------
--Wall type blocks ------------
-------------------------------
Wall = Block:new()
function Wall:new()
	o =
	{
		lightimg = textures.light.wall,
		darkimg = textures.dark.wall,
		hiddenimg = textures.blackness,
		issolid = true,
	}
	
    setmetatable(o, self)
    self.__index = self
    return o
end
table.insert(Blocks, Wall)
Wall:setTextureCode(#Blocks)

--------------------------------
--Floor type blocks ------------
--------------------------------
Stone = Block:new()
function Stone:new()
	o =
	{
		lightimg = textures.light.stone,
		darkimg = textures.dark.stone,
		hiddenimg = textures.blackness,
		issolid = false,
	}

    setmetatable(o, self)
    self.__index = self
    return o
end
table.insert(Blocks, Stone)
Stone:setTextureCode(#Blocks)
