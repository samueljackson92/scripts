
Button = {}
Button = GUIComponent:new()

function Button:new()
	o = 
	{
		label = Label:new()
	}
	
    setmetatable(o, self)
    self.__index = self
    return o
end

function Button:draw()
	if self.visible == true then
		if self.image ~= nil then
			love.graphics.draw(self.image, self.x, self.y)
		else
			GUI:setColour({150, 150, 150, 255})
			love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
			GUI:clearColour()
		end
		self.label:draw()
	end
end

function Button:setCoordinates(x,y)
	self.x = x
	self.y = y
	self.label:setCoordinates(x ,y + (self.height /2))
end

function Button:setDimensions(w,h)
	self.width = w
	self.height = h
	self.label:setWrapLimit(w)
end

function Button:setText(str)
	self.label:setText(str)
end

function Button:setFont(fnt)
	self.label:setFont(fnt)
end

function Button:checkEvents(args)
	--raise click event
	if type(self.click) == "function" and type(args) == "table" then
		self:eventClicked(args)
	end
	
	--raise hover event
	if type(self.hover) == "function" then
		self:eventHover()
	end
end

function Button:setImage(img)
	self.image = img
	self:setDimensions(self.image:getWidth(), self.image:getHeight())
	self.label:setWrapLimit(self.width)
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
