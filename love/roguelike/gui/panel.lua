Panel = GUIComponent:new()
function Panel:new()
	o = 
	{
		componentList = {},
		panelType = "full",
		backgroundColour = {0, 0, 0, 255},
	}
	
    setmetatable(o, self)
    self.__index = self
    return o
end

function Panel:addComponent(obj)
	obj:setParent(self)
	table.insert(self.componentList, obj)
end

function Panel:drawComponents()
	if self.visible == true then
		if self.image == nil then
			if self.panelType == "full" then
				self:drawFullWindow()
			elseif self.panelType == "scale" then
				self:drawWindow()
			end
		else
			love.graphics.draw(self.image, self.x, self.y)
		end
		for i,v in ipairs(self.componentList) do
			if type(v.draw) == "function" then
				v:draw()
			end
		end
	end
end

function Panel:doEvents(e)
	if self.visible == true then
		if type(self.eventHappened) == "function" then
			self:eventHappened(e)
		end
		for i,v in pairs (self.componentList) do
			if type(v.checkEvents) == "function" then
				v:checkEvents(e)
			end
		end
	end
end

function Panel:setPanelType(str)
	self.panelType = str
end

function Panel:drawFullWindow()
	GUI:setColour(self.backgroundColour)
	love.graphics.rectangle("fill", 0, 0, Game.windowWidth, Game.windowHeight)
	GUI:clearColour()
end

function Panel:drawWindow()
	GUI:setColour(self.backgroundColour)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	GUI:clearColour()
end

function Panel:setBackgroundColour(r, g, b, a)
	self.backgroundColour = {r, g, b, a}
end
