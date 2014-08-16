Textbox = GUIComponent:new()

function Textbox:new()
	o = 
	{
		image = nil,
		numericInput = true,
		alphaInput = true,
		readOnly = false,
		charLimit = 0,
		label = heart.label:new(),	
	}
	
	o.label:init(o)
	o.label:setAlignment("left")
	
    setmetatable(o, self)
    self.__index = self
    return o
end

function Textbox:checkEvents(e)
	if type(e) == "string" then
		local alpha = {"a", "b", "c", "d", "e", "f", "g", "h", 
		"i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
		
		local numeric = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}
		
		if e == "backspace" or e == "delete" then
			self:removeText()
		else
			if self.alphaInput == true then
				for i,v in ipairs(alpha) do
					if v == e or v == string.upper(e) then
						self:addText(e)
						break
					end
				end
			end
			if self.numericInput == true then
				for i,v in ipairs(numeric) do
					if v == e then
						self:addText(e)
					end
				end
			end
		end
	end
end

function Textbox:isReadOnly(bool)
	if bool ~= nil then
		self.readOnly = bool
	end
	return self.readOnly
end

function Textbox:isAlpha(bool)
	if bool ~= nil then
		self.alphaInput = bool
	end
	return self.alphaInput
end

function Textbox:isNumeric(bool)
	if bool ~= nil then
		self.numericInput = bool
	end
	return self.numericInput
end

function Textbox:setCharLimit(int)
	self.charLimit = int
end

function Textbox:getCharLimit()
	return self.charLimit
end

function Textbox:addText(chr)
	if (string.len(self.label:getText()) < self.charLimit or self.charLimit == 0) and self.readOnly == false then
		self.label:setText(self.label:getText() .. chr) 
	end
end

function Textbox:removeText()
	local str = self.label:getText()
	self.label:setText(string.sub(str, 1, string.len(str)-1))
end

function Textbox:draw()
	if self.image ~= nil and self.visible == true then
		love.graphics.draw(self.image, self.x, self.y)
	end
	self.label:draw()
end