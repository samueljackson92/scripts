
Label = GUIComponent:new()

function Label:new()
	o = 
	{
		toString = nil, 
		walign = 0,
		color = {red = 255, green = 255, blue = 255, alpha = 255}
	}
	
    setmetatable(o, self)
    self.__index = self
    return o
end

function Label:draw()
	if self.toString ~= nil then
		love.graphics.setColor(self:getTextColor())
		love.graphics.setColorMode("modulate")
		--5 is line height
		love.graphics.printf(self.toString, self.x, self.y + (self.height /2) - 5, 100, self.walign)
		love.graphics.setColorMode("replace")
	end
end

function Label:setText(text, walign, valign)
	self.toString = text
	self.walign = walign
end

function Label:drawText()
	if self.toString ~= nil then
		love.graphics.setColor(self:getTextColor())
		love.graphics.setColorMode("modulate")
		--5 is line height
		love.graphics.printf(self.toString, self.x, self.y + (self.height /2) - 5, 100, self.walign)
		love.graphics.setColorMode("replace")
	end
end

function Label:setTextColor(r, g, b, a)
	self.color = {red = r, green = g, blue = b, alpha = a}
end

function Label:getTextColor(r, g, b, a)
	return self.color
end

function Label:getTextColor()
	return self.color.red, self.color.green, self.color.blue, self.color.alpha
end