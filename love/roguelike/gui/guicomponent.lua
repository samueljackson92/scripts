
GUIComponent = {}

function GUIComponent:new()
	o = 
	{
		name = "",
		visible = true,
		x = 0,
		y = 0,
		parent = nil,
		image = nil,
		height = 0,
		width = 0,
		rect = nil
	}
	setmetatable(o, self)
    self.__index = self
    return o
end

function GUIComponent:addToCanvas(x, y, p)
	self:setCoordinates(x, y)
	self:init(p)
end

function GUIComponent:draw()
	if self.image ~= nil then
		love.graphics.draw(self.image, self.x, self.y)
	end
end

function GUIComponent:setSize(x,y,w,h)
	self:setCoordinates(x,y)
	self:setDimensions(w,h)
end

function GUIComponent:setCoordinates(x,y)
	self.x = x
	self.y = y
end

function GUIComponent:getCoordinates()
	return self.x, self.y
end

function GUIComponent:setDimensions(w, h)
	self.width = w
	self.height = h
end

function GUIComponent:getDimensions() 	
	return self.width, self.height
end

function GUIComponent:setVisible(e)
	self.visible = e
end

function GUIComponent:getVisible()
	return self.visible
end

function GUIComponent:toggleVisible()
	self.visible = not self.visible
end

function GUIComponent:setImage(img)
	self.image = img
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function GUIComponent:getImage()
	return self.image
end

function GUIComponent:setParent(obj)
	self.parent = obj
end

function GUIComponent:getParent()
	return self.parent
end
