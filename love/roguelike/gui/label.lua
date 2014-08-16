Label = GUIComponent:new()

function Label:new()
	o = 
	{
		text = "",
		font = GUI.fonts.DEFAULT,
		lineHeightOffset = 0,
		alignment = "center",
		color = {red = 255, green = 255, blue = 255, alpha = 255},
		wrap = Game.windowWidth,
	}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Label:draw()
	if self.text ~= "" then
		love.graphics.setColor(self:getTextColor())
		love.graphics.setColorMode("modulate")
		--5 is line height
		love.graphics.setFont(self.font)
		love.graphics.printf(self.text, self.x, self.y + (self.height /2) - self.lineHeightOffset, self.wrap, self.alignment)
		love.graphics.setFont(GUI.fonts.DEFAULT)
		love.graphics.setColorMode("replace")
	end
end

function Label:setText(t)
	self.text = t
end

function Label:getText()
	return self.text
end

function Label:setFont(font)
	self.font = font
	self.lineHeightOffset = ((self.font:getLineHeight() * self.font:getHeight()) /2)
end

function Label:setAlignment(align)
	self.alignment = align
end

function Label:getAlignment()
	return self.alignment
end

function Label:setWrapLimit(int)
	self.wrap = int
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
