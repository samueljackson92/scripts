Overlay = GUIComponent:new()

function Overlay:new()
	o = 
	{
		rect = nil
	}
	setmetatable(o, self)
    self.__index = self
    return o
end

function Overlay:draw()
	if self.image ~= nil then
		love.graphics.draw(self.image, self.x, self.y)
	else
		love.graphics.rectangle("fill", self.x, self.y, self.height, self.width)
	end
end
