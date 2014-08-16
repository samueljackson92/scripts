Player = {}

function Player:new()
	o = 
	{
		lowerLimitX = 0,
		upperLimitX = 0,
		lowerLimitY = 0,
		upperLimitY = 0,
		finishedDrawing = false
	}
    setmetatable(o, self)
    self.__index = self
    return o
end