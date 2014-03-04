hater = {}

function hater:new (xIn, yIn, colorIn)
  o = {
  
	x = xIn,
	y = yIn,
	width = 30,
	height = 50,
	color = colorIn,
		
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(drawables, o)
  table.insert(collidables, o)
  return o
end


function hater:draw ()
	love.graphics.setColor(unpack(self.color))
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
	love.graphics.setColor(255,255,255)
end