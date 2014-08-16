
require "engine/drawable.lua"

Block = Drawable:new()

function Block:new()
	o = {
		  dark = true,
		  code = 0,
		  issolid = true,
		  islit = false,
		  isInMaze = false,
	   }

    setmetatable(o, self)
    self.__index = self
    return o
end

function Block:draw()
	if self:getDark() == true then
		love.graphics.draw(self.hiddenimg, self.x -(Game.viewX), self.y -(Game.viewY))
	else
		if self:getLit() == true then
			love.graphics.draw(self.lightimg, self.x -(Game.viewX), self.y -(Game.viewY))
		else
			love.graphics.draw(self.darkimg, self.x -(Game.viewX), self.y -(Game.viewY))
		end
	end
end

function Block:setTextureCode(tex)
	self.code = tex
end

function Block:getTextureCode()
	return self.code
end

function Block:isSolid()
	return self.issolid
end

function Block:setDark(bool)
	self.dark = bool
end

function Block:getDark()
	return self.dark
end

function Block:setLit(lit)
	self.islit = lit
end

function Block:getLit()
	return self.islit
end
