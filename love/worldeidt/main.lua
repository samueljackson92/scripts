
Game = {}
Game.height = 608
Game.width = 608
Game.noColls = (Game.width / 16) + 1
Game.noRows = (Game.height / 16) + 1
Game.brush = 1
Game.brushSize = 1

require "mapmanager.lua"
require "HeartGUI/heart.lua"

function love.load ()
	love.graphics.setCaption("Map Maker")
	love.graphics.setBackgroundColor(100, 100, 100)
	love.graphics.setMode(Game.width, Game.height + 50, false, true, 0)
	love.graphics.setColorMode("replace")
	
	Map = MapMan:new(Game.noColls, Game.noRows)
	Map:loadMap("default.txt")
	loadGUI()
end

function love.update(dt)
	Map:playerDraw()
end

function love.draw()
	Map:drawMap()
	heart:drawComponents()
end

function love.keypressed(e)
	if e == "f1" then
		writeFile()
	end
	if e == "f2" then
		loadFile()
	end
end
function loadGUI()

	btnPman = heart.button:new()
	btnPman:addToCanvas(10, Game.height + 10)
	btnPman:setImage("images/pman.png")
	function btnPman:click()
		Game.brush = 1
	end
	
	btnFloor = heart.button:new()
	btnFloor:addToCanvas(31, Game.height + 10)
	btnFloor:setImage("images/'.png")
	function btnFloor:click()
		Game.brush = 2
	end
		
	btnWall = heart.button:new()
	btnWall:addToCanvas(52, Game.height + 10)
	btnWall:setImage("images/#.png")
	function btnWall:click()
		Game.brush = 3
	end
	
	btnSize1 = heart.button:new()
	btnSize1:addToCanvas(10, Game.height + 31)
	btnSize1:setImage("images/buttons/size1.png")
	function btnSize1:click()
		Game.brushSize = 1
	end	
	
	btnSize2 = heart.button:new()
	btnSize2:addToCanvas(31, Game.height + 31)
	btnSize2:setImage("images/buttons/size2.png")
	function btnSize2:click()
		Game.brushSize = 2
	end
	
	btnSize3 = heart.button:new()
	btnSize3:addToCanvas(52, Game.height + 31)
	btnSize3:setImage("images/buttons/size3.png")
	function btnSize3:click()
		Game.brushSize = 3
	end
	
	btnSize4 = heart.button:new()
	btnSize4:addToCanvas(73, Game.height + 31)
	btnSize4:setImage("images/buttons/size4.png")
	function btnSize4:click()
		Game.brushSize = 4
	end
	
	btnSize1 = heart.button:new()
	btnSize1:addToCanvas(94, Game.height + 31)
	btnSize1:setImage("images/buttons/size1.png")
	function btnSize1:click()
		Map:saveMap("newmap.txt")
	end	
end

function love.mousepressed(x,y,e)
	heart:doEvents({x, y, e})
end
