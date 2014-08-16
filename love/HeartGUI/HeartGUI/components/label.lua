
Label = GUIComponent:new()

function Label:new()
	o = 
	{
		text = "",
		alignment = "center",
		color = {red = 255, green = 255, blue = 255, alpha = 255}
	}
	
    setmetatable(o, self)
    self.__index = self
    return o
end

function Label:draw()
	if self.text ~= "" and self.visible == true then
		love.graphics.setColor(self:getTextColor())
		love.graphics.setColorMode("modulate")
		--5 is line height
		love.graphics.printf(self.text, self.x, self.y + (self.height /2) - 5, 100, self.alignment)
		love.graphics.setColorMode("replace")
	end
end

function Label:setText(t)
	self.text = t
end

function Label:getText()
	return self.text
end

function Label:setAlignment(align)
	self.alignment = align
end

function Label:getAlignment()
	return self.alignment
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