ground = {

  	x = 0,
	y = 0,
	width = 100,
	height = 100,
	color = { 50, 50, 50 }
	
}

box = {

	x = 0,
	y = 0,
	width = worldWidth,
	height = worldHeight,
	color = { 255, 20, 20 }
	
}

function ground:new ()
  o = {
  
  	x = 0,
	y = (height * 2.5) + 50,
	width = worldWidth * 3,
	height = worldheight/2,
	color = { 50, 50, 50 },	
  
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(drawables, o)
  return o
end