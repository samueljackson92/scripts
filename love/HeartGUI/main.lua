
require "HeartGUI/heart.lua"

function love.load()
	love.graphics.setCaption("heart Test")
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setMode(800, 600, false, true, 0)
	love.graphics.setColorMode("replace")

	--minimal button implementation
	Button1 = heart.button:new()
	Button1:addToCanvas(10, 10)
	Button1:setImage(love.graphics.newImage("button.png"))
	function Button1:click()
		print("hello from button1 click event")
	end
	
	--button with a label
	Button2 = heart.button:new()
	Button2:addToCanvas(10, 70)
	Button2.label:setTextColor(255, 0, 0, 255)
	Button2.label:setText("Hello world")
	Button2:setImage(love.graphics.newImage("button.png"))
	function Button2:click()
		print("hello from button 2")
	end
	
	--label object on its own
	Label1 = heart.label:new()
	Label1:addToCanvas(120, 10)
	Label1:setTextColor(255, 255, 255, 255)
	Label1:setText("This is Label1")
	
	Textbox1 = heart.textbox:new()
	Textbox1:addToCanvas(30, 30)
	
end

function love.draw()
	heart:drawComponents()
end

function love.mousepressed(x, y, e)
	heart:doEvents({x, y, e})
end

function love.keypressed(e)
	heart:doEvents(e)
end

function love.update(dt)
	heart:doEvents()
end

