
Button = GUIComponent:new()

function Button:new()
	o = 
	{
		image = love.graphics.newImage("HeartGUI/components/".. heart.theme .."/button.png"),
		imageDepressed = nil,
		imageHover = nil,
		imageDisabled = nil,
		text = heart.label:new()
	}
	
    setmetatable(o, self)
    self.__index = self
	o.width = o.image:getWidth()
	o.height = o.image:getHeight()
	o.text:init(o)
	o.text:setDimensions(o.width, o.height)
    return o
end

function Button:draw()
		love.graphics.draw(self.image, self.x, self.y)
		if self.text.toString ~= nil then
			self.text:draw()
		end
end

function Button:setCoordinates(x,y)
	self.x = x
	self.y = y
	self.text:setCoordinates(x,y)
end

function Button:checkEvents(args)

	--raise click event
	if type(self.click) == "function" and args ~= nil then
		self:eventClicked(args)
	end
	
	--raise hover event
	if type(self.hover) == "function" then
		self:eventHover()
	end
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
