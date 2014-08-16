-----------------------------------------------------------------------
-- GUI Super Global
-----------------------------------------------------------------------
heart = 
{
	theme = "default_images",
	currentComponents = {}
}

require "HeartGUI/components/guicomponent.lua"
heart.GUIComponent = GUIComponent
require "HeartGUI/components/label.lua"
heart.label = Label
require "HeartGUI/components/button.lua"
heart.button = Button

function heart:drawComponents()
	for i,v in ipairs(self.currentComponents) do
		if type(v.draw) == "function" and v.visible == true then
			v:draw()
		end
	end
end

function heart:doEvents(e)
	for i,v in pairs (self.currentComponents) do
		if type(v.checkEvents) == "function" then
			v:checkEvents(e)
		end
	end
end

function heart:getTheme()
	return self.imagelib
end

function heart:setTheme(path)
	self.imagelib = path
end

