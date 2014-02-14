hater = {}

function hater:new (xIn, yIn)
  o = {
  
	x = xIn,
	y = yIn,
	width = 20,
	height = 20,
	color = { 255, 20, 20 },
		
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(drawables, o)
  table.insert(collidables, o)
  return o
end


function hater:draw ()

	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

end