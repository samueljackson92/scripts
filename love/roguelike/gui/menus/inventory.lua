Inventory = Panel:new()

function Inventory:init()
	Inventory:setPanelType("scale")
	Inventory:setCoordinates(0, 0)
	Inventory:setImage(love.graphics.newImage("images/gui/inventory.jpg"))
	Inventory:setVisible(false)
end
