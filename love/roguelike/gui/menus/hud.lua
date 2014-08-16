HUD = Panel:new()

function HUD:init()
	HUD:setPanelType("scale")
	HUD:setSize(0, 512, 562, 70)
	HUD:setBackgroundColour(100, 100, 100, 255)
	
	lblStatTitle = Label:new()
	lblStatTitle:setText("Player Stats:")
	lblStatTitle:setAlignment("left")
	lblStatTitle:setSize(5, 512, 50, 10)
	lblStatTitle:setWrapLimit(100)
	
	lblPlayerHealth = Label:new()
	lblPlayerHealth:setText("Health: 100")
	lblPlayerHealth:setAlignment("left")
	lblPlayerHealth:setSize(5, 527, 50, 10)
	lblPlayerHealth:setWrapLimit(100)
	
	lblPlayerArmor = Label:new()
	lblPlayerArmor:setText("Armor: 0")
	lblPlayerArmor:setAlignment("left")
	lblPlayerArmor:setSize(5, 542, 50, 10)
	lblPlayerArmor:setWrapLimit(100)
	
	HUD:addComponent(lblStatTitle)
	HUD:addComponent(lblPlayerHealth)
	HUD:addComponent(lblPlayerArmor)
end

function HUD:eventHappened(e)
	if e == "up" or e == "down"
	or e == "left" or e == "right"
	then
		lblPlayerHealth:setText("Health: " .. map.player:getHP())
		lblPlayerArmor:setText("Armor: " .. map.player:getArmor())
	end
end
