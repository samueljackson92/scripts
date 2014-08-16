

Game = {}
Game.width = 800
Game.height = 600

require"HeartGUI/heart.lua"
require "lifemanager"
require "player"


function love.load()
	love.graphics.setCaption("Conway's Game Of Life")
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setMode(Game.width, Game.height, false, true, 0)
	love.graphics.setColorMode("replace")
	
	LifeManager = LifeMan:new()
	LifeManager:init()
	
	Player1 = Player:new()
	Player2 = Player:new()
	
	Player1.lowerLimitX = 0
	Player1.upperLimitX = 391
	
	Player2.lowerLimitX = 409
	Player2.upperLimitX = 800
	
	initGUI()
	
	love.graphics.setFont(14)
	
	newGame()
end

function love.update(dt)
	if Game.showHelp ~= true then
		if Game.running == false and Game.drawingOff == false then
			if Game.currentPlayerDrawing == 1 then
				--let player1 draw
				runDrawMode(Player1)
			else
				--let player2 draw
				runDrawMode(Player2)
			end
		end
		if Game.running == true then
			tickTmr = tickTmr + dt
			if tickTmr >= Game.speed then
				LifeManager:tick(1)
				LifeManager:tick(2)
				LifeManager.generation = LifeManager.generation + 1
				tickTmr = 0
			end
		end
	end
	if LifeManager.generation == Game.generationCap  and Game.postAnalysisDone == false then
		Game.postAnalysisDone = true
		Game.running = false
		Game.over = true
		runPostGame()
	end
end

function love.draw()

	LifeManager:drawLife()
	drawHUD()
	heart:drawComponents()
	if Game.showHelp == true then
		drawHelp()
	end
	
	if Game.currentPlayerDrawing == 2 then
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("fill", 0, 0, 400, 608 )
	end

	if Game.over == true then
		drawPostGame()
	end

end

function love.keypressed(e)
	
	--Reset game completely
	if e == "f1" then
		newGame()
		for i,v in ipairs(LifeManager.blocks) do
			for j,w in ipairs(v) do
				w:makeDead(0)
			end
		end
	end
	
	--toggle drawing mode
	if e == "f2" and Game.drawingOff == false then
		if Game.drawmode == true then
			Game.drawmode = false
		else
			Game.drawmode = true
		end
	end
	
	if e == "f3" then
		if Game.speed > 0.1 then
			Game.speed = Game.speed - 0.1
		end
	end
	
	if e == "f4" then
		if Game.speed < 1.5 then
			Game.speed = Game.speed + 0.1
		end
	end
	
	--run simulation
	if e == "f5" and Game.drawingOff == true then
		Game.running = true
		Game.drawingOff = true
	end
	
	--stepforward
	if e == "f6" and Game.drawingOff == true then
		Game.running = false
		LifeManager:tick(1)
		LifeManager:tick(2)
		LifeManager.generation = LifeManager.generation + 1
	end
	
	--flag finished drawing
	if e == "f7" then
		if Game.currentPlayerDrawing == 1 then
			Game.currentPlayerDrawing = 2
			Player1.finishedDrawing = true
		elseif Game.currentPlayerDrawing == 2 then
			Game.currentPlayerDrawing = 1
			Player2.finishedDrawing = true
			Game.drawingOff = true
		end
	end
	
	if e == "f8" and Game.drawingOff == false then
		if Game.generationCap >= 100 then
			Game.generationCap = Game.generationCap - 50
		end
	end
	
	if e == "f9" and Game.drawingOff == false then
		if Game.generationCap <= 1950 then
			Game.generationCap = Game.generationCap + 50
		end
	end
	
	if e == "f10" then
		if Game.showHelp == false then
			Game.showHelp = true
		else
			Game.showHelp = false
		end
	end
	
	if e == "f11" and Game.drawingOff == false and Game.startedDrawing == false then
		if Game.startSquareCap >= 20 then
			Game.startSquareCap = Game.startSquareCap - 10
		end
	end
	
	if e == "f12" and Game.drawingOff == false and Game.startedDrawing == false then
		if Game.startSquareCap <= 200 then
			Game.startSquareCap = Game.startSquareCap + 10
		end
	end
	
	--quit game
	if e == "escape" then
		love.event.push("q")
	end
end

function love.mousepressed(x, y, e)
	heart:doEvents({x, y, e})
end

--disable Love modules that are not required by the game
function love.conf(t)
    t.modules.joystick = false
    t.modules.physics = false
end

------------------------------------------------------
--Non Love Functions
------------------------------------------------------

function newGame()
		Game.speed = 0.5
		Game.over = false
		Game.running = false
		Game.drawmode = true
		Game.drawingOff = false
		Game.showHelp = false
		Game.currentPlayerDrawing = 1
		Game.postAnalysisDone = false
		Game.startSquareCap = 50
		Game.startedDrawing = false
		Game.blueStats =
		{
			startSquares = 0,
			totaldead = 0,
			totalalive = 0,
			total = 0
		}
		Game.redStats = 
		{
			startSquares = 0,
			totaldead = 0,
			totalalive = 0,
			total = 0
		}

		Game.winner = ""
		Game.generationCap = 500
		tickTmr = 0
		LifeManager.generation = 0
		Player1.finishedDrawing = false
		Player2.finishedDrawing = false
end

function runDrawMode(p)
	if love.mouse.isDown("l") then
		local x,y = love.mouse.getPosition()
			if x > p.lowerLimitX and x < p.upperLimitX then
				LifeManager:makeLife(x,y, Game.drawmode, Game.currentPlayerDrawing)
			end
	end
	for i,v in ipairs(LifeManager.blocks) do
		for j,w in ipairs(v) do
			if w.living == true then
				Game.startedDrawing = true
				return true
			else 
				Game.startedDrawing = false
			end
		end
	end

end

function runPostGame()
	for i,v in ipairs(LifeManager.blocks) do
		for j,w in ipairs(v) do
			if w.living == true and w.player == 1 then
				Game.redStats.totalalive = Game.redStats.totalalive + 1
			end
			if w.living == true and w.player == 2 then
				Game.blueStats.totalalive = Game.blueStats.totalalive + 1
			end
			if w.living == false and w.player == 1 then
				Game.redStats.totaldead = Game.redStats.totaldead + 1
			end
			if w.living == false and w.player == 2 then
				Game.blueStats.totaldead = Game.blueStats.totaldead + 1
			end
		end
	end
	
	Game.redStats.total = Game.redStats.totalalive + Game.redStats.totaldead
	Game.blueStats.total = Game.blueStats.totalalive + Game.blueStats.totaldead
	
	if Game.redStats.total > Game.blueStats.total then
		Game.winner = "Red"
	elseif Game.redStats.total < Game.blueStats.total then
		Game.winner = "Blue"
	elseif Game.redStats.total == Game.blueStats.total then
		Game.winner = "Draw"
	end
end

------------------------------------------------------
--HUD and GUI functions
------------------------------------------------------

function drawHUD()
	love.graphics.setColor(30, 30, 30)
	love.graphics.rectangle("fill", 0, 608, 800, 50)
	love.graphics.printf("Generation: " .. LifeManager.generation, 10, 615, 300, "left" )
	
	if Game.speed < 0.1 then
		Game.speed = 0.1
	end
	
	love.graphics.printf("Speed: " .. Game.speed, 10, 635, 300, "left" )
	love.graphics.printf("Generation Cap: " .. Game.generationCap, 200, 615, 300, "left" )
	love.graphics.printf("Start Square Cap: " .. Game.startSquareCap, 200, 635, 300, "left" )
	
	if Player1.finishedDrawing == false then
		love.graphics.printf("Player 1 to Draw", 480, 615, 300, "right" )
	elseif Player2.finishedDrawing == false then
		love.graphics.printf("Player 2 to Draw", 480, 615, 300, "right" )
	elseif Game.drawingOff == true and Game.running == false then
		love.graphics.printf("Simulation Ready", 480, 615, 300, "right" )
	elseif Game.running == true then
		love.graphics.printf("Simulation Running", 480, 615, 300, "right" )
	end
	
	love.graphics.printf("Press F10 for rules and help", 480, 635, 300, "right" )
end

function drawHelp()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, 800, 658)
	
	love.graphics.setFont( 20 )
	love.graphics.printf("Help Dialogue", 150, 100, 300, "left" )
	love.graphics.printf("--------------------------------------------", 150, 120, 300, "left" )
	love.graphics.setFont( 14 )
	love.graphics.printf("Controls:", 150, 140, 300, "left" )
	love.graphics.printf("--------------------------------------------", 150, 150, 300, "left" )
	love.graphics.printf("F1 --- Reset Game", 150, 180, 300, "left" )
	love.graphics.printf("F2 --- Toggle Drawing Mode (Draw Cells/Erase Cells)", 150, 200, 500, "left" )
	love.graphics.printf("F3 --- Decrease Game Speed", 150, 220, 300, "left" )
	love.graphics.printf("F4 --- Increase Game Speed", 150, 240, 300, "left" )
	love.graphics.printf("F5 --- Run Simulation", 150, 260, 300, "left" )
	love.graphics.printf("F6 --- Step Through Simulation/Pause", 150, 280, 300, "left" )
	love.graphics.printf("F7 --- Finish Drawing", 150, 300, 300, "left" )
	love.graphics.printf("F8 --- Decrease Generation Cap", 150, 320, 300, "left" )
	love.graphics.printf("F9 --- Increase Generation Cap", 150, 340, 300, "left" )
	love.graphics.printf("F10 --- Show This Screen", 150, 360, 300, "left" )
	love.graphics.printf("F11 --- Decrease Start Square Cap", 150, 380, 300, "left" )
	love.graphics.printf("F12 --- Increase Start Square Cap", 150, 400, 300, "left" )
	love.graphics.printf("Esc --- Close Game", 150, 420, 300, "left" )
	
	love.graphics.printf("Rules:", 150, 450, 300, "left" )
	love.graphics.printf("--------------------------------------------", 150, 470, 300, "left" )
	love.graphics.printf("1) Any live cell with fewer than two live neighbours dies, as if caused by under-population.", 150, 490, 600, "left" )
	love.graphics.printf("2) Any live cell with two or three live neighbours lives on to the next generation.", 150, 530, 600, "left" )
	love.graphics.printf("3) Any live cell with more than three live neighbours dies, as if by overcrowding.", 150, 550, 600, "left" )
	love.graphics.printf("4) Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.", 150, 570, 600, "left" )
end

function drawPostGame()

	love.graphics.setColor(0, 0, 0, 150)
	love.graphics.rectangle("fill", 0, 0, 800, 658)
	
	love.graphics.setFont( 20 )
	love.graphics.printf("Post Game", 150, 150, 300, "left" )
	love.graphics.printf("--------------------------------------------", 150, 170, 300, "left" )
	
	love.graphics.setFont( 14 )
	love.graphics.printf("Red", 150, 190, 300, "left" )
	love.graphics.printf("--------------------------------------------", 150, 200, 300, "left" )
	love.graphics.printf("No. of Living Cells: " .. Game.redStats.totalalive, 150, 220, 300, "left" )
	love.graphics.printf("No. of Dead Cells: " .. Game.redStats.totaldead, 150, 240, 500, "left" )
	love.graphics.printf("Total Start Squares: " .. Game.redStats.startSquares, 150, 260, 500, "left")
	love.graphics.printf("Total Control: " .. Game.redStats.totalalive + Game.redStats.totaldead, 150, 280, 300, "left" )
	love.graphics.printf("Total % Control: " .. round(((Game.redStats.totalalive + Game.redStats.totaldead) / 3800) * 100, 1) .. "%", 150, 300, 300, "left" )
	
	love.graphics.printf("Blue", 150, 330, 300, "left" )
	love.graphics.printf("--------------------------------------------", 150, 350, 300, "left" )
	love.graphics.printf("No. of Living Cells: " .. Game.blueStats.totalalive, 150, 370, 300, "left" )
	love.graphics.printf("No. of Dead Cells: " .. Game.blueStats.totaldead, 150, 390, 500, "left" )
	love.graphics.printf("Total Squares Start: " .. Game.blueStats.startSquares, 150, 410, 500, "left" )
	love.graphics.printf("Total Control: " .. Game.blueStats.totalalive + Game.blueStats.totaldead, 150, 430, 300, "left" )
	love.graphics.printf("Total % Control: " .. round(((Game.blueStats.totalalive + Game.blueStats.totaldead) / 3800) * 100, 1) .. "%", 150, 450, 300, "left" )
	
	love.graphics.setFont( 20 )
	if Game.winner == "Draw" then
		love.graphics.printf("Game Is A Draw", 150, 480, 300, "center" )
	else
		love.graphics.printf(Game.winner .. " Wins", 150, 480, 300, "center" )
	end
	love.graphics.setFont( 14 )
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function initGUI ()
	--build the GUI
	btnIncreaseSpeed = heart.button:new()
	btnIncreaseSpeed:addToCanvas(100, 635)
	btnIncreaseSpeed:setImage("images/plus-button.png")
	function btnIncreaseSpeed:click()
		if Game.speed < 1.5 then
			Game.speed = Game.speed + 0.1
		end
	end
	
	btnDecreaseSpeed = heart.button:new()
	btnDecreaseSpeed:addToCanvas(116, 635)
	btnDecreaseSpeed:setImage("images/minus-button.png")
	function btnDecreaseSpeed:click()
		if Game.speed > 0.1 then
			Game.speed = Game.speed - 0.1
		end
	end
	
	btnIncreaseGenerationCap = heart.button:new()
	btnIncreaseGenerationCap:addToCanvas(360, 615)
	btnIncreaseGenerationCap:setImage("images/plus-button.png")
	function btnIncreaseGenerationCap:click()
		if Game.drawingOff == false then
			if Game.generationCap <= 1950 then
				Game.generationCap = Game.generationCap + 50
			end
		end
	end
	
	btnDecreaseGenerationCap = heart.button:new()
	btnDecreaseGenerationCap:addToCanvas(376, 615)
	btnDecreaseGenerationCap:setImage("images/minus-button.png")
	function btnDecreaseGenerationCap:click()
		if Game.drawingOff == false then
			if Game.generationCap >= 100 then
				Game.generationCap = Game.generationCap - 50
			end
		end
	end
	
	btnIncreaseSquareCap = heart.button:new()
	btnIncreaseSquareCap:addToCanvas(360, 635)
	btnIncreaseSquareCap:setImage("images/plus-button.png")
	function btnIncreaseSquareCap:click()
		if Game.drawingOff == false and Game.startedDrawing == false then
			if Game.startSquareCap <= 200 then
				Game.startSquareCap = Game.startSquareCap + 10
			end
		end
	end
	
	btnDecreaseSquareCap = heart.button:new()
	btnDecreaseSquareCap:addToCanvas(376, 635)
	btnDecreaseSquareCap:setImage("images/minus-button.png")
	function btnDecreaseSquareCap:click()
		if Game.drawingOff == false and Game.startedDrawing == false then
			if Game.startSquareCap >= 20 then
				Game.startSquareCap = Game.startSquareCap - 10
			end
		end
	end

end

