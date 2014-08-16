
Button = GUIComponent:new()

function Button:new()
	o = 
	{
		label = heart.label:new()
	}
	
    setmetatable(o, self)
    self.__index = self
	o.label:init(o)
    return o
end

function Button:draw()
		if self.visible == true then
			love.graphics.draw(self.image, self.x, self.y)
		end
		self.label:draw()
end

function Button:setCoordinates(x,y)
	self.x = x
	self.y = y
	self.label:setCoordinates(x,y)
end

function Button:checkEvents(args)
	--raise click event
	if type(self.click) == "function" and args ~= nil and type(args) == "table" then
		self:eventClicked(args)
	end
	
	--raise hover event
	if type(self.hover) == "function" then
		self:eventHover()
	end
end

function Button:setImage(img)
	self.image = img
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.label:setDimensions(self.widht, self.height)
end

function Button:eventClicked(args)
	local x = args[1]
	local y = args[2]
	local e = args[3]
	if e == "l" then
		if (x >= self.x and x <= self.x + self.width) and
			(y >= self.y and y <= self.y + self.height)
		then
			self:click()
		end
	end
end

function Button:eventHover()
	local x,y = love.mouse.getPosition()
	if (x >= self.x and x <= self.x + self.width) and
		(y >= self.y and y <= self.y + self.height)
	then
		self:hover()
	end
end
