sound = {}
sounds = {}

function sound:new (xIn, yIn, sourceIn, memoryIn)
  o = {
	  x = xIn,
	  y = yIn,

	  file = love.audio.newSource(sourceIn, memoryIn),
	 
	  played = false,
	  
	  xrel = 0,
	  yrel = 0,

	  
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(sounds, o)
  return o
end

function sound:move(xIn, yIn)
	self.x = xIn
	self.y = yIn

end

function sound:play()
	
	self.xrel = ((player.x/self.x) - 1) * - 1
	
	self.yrel = ((player.y/self.y) - 1) * - 1
	
	self.file:setPosition(self.xrel, self.yrel, 0)
	
	self.file:rewind(self.file)
	self.file:play(self.file)	
	
	self.played = true
	
end
