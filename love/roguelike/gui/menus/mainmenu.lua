MainMenu = Panel:new()

function MainMenu:init()
	btnPlayGame = Button:new()
	btnPlayGame:setText("Play Game")
	btnPlayGame:setFont(GUI.fonts.MENU_LARGE)
	btnPlayGame:setDimensions(150, 50)
	btnPlayGame:setCoordinates((Game.windowWidth /2) - (btnPlayGame.width /2), 125 )
	
	btnExitGame = Button:new()
	btnExitGame:setText("Exit Game")
	btnExitGame:setFont(GUI.fonts.MENU_LARGE)
	btnExitGame:setDimensions(150, 50)
	btnExitGame:setCoordinates((Game.windowWidth /2) - (btnExitGame.width /2), 200 )

	lblTitle = Label:new()
	lblTitle:setText("ROGUELIKE")
	lblTitle:setFont(GUI.fonts.MAIN_HEADING)
	lblTitle:setCoordinates(0, 40)
	
	lblSubTitle = Label:new()
	lblSubTitle:setText("By Samuel Jackson")
	lblSubTitle:setFont(GUI.fonts.MAIN_SUBHEADING)
	lblSubTitle:setCoordinates(0, 80)
	
	self:addComponent(btnPlayGame)
	self:addComponent(btnExitGame)
	self:addComponent(lblTitle)
	self:addComponent(lblSubTitle)
	self:setBackgroundColour(100, 100, 100, 255)
	
	-- Component Callbacks
	function btnPlayGame:click()
		Game.MAIN_MENU = false
		map:buildMap()
	end

	function btnExitGame:click()
		love.event.push("q")
	end
end


