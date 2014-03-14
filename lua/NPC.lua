npc = {}

function npc:new (xIn, yIn, colorIn)
  o = {
  
	x = xIn,
	y = yIn,
	width = 30,
	height = 50,
	color = colorIn,
	
	events = {},
	dialogues = {},
	
	selected = false,
	
	speed = 80
		
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(drawables, o)
  table.insert(collidables, o)
  table.insert(chars, o)
  return o
end

function npc:newEvent(secIn, sequenceIn, repeatIn)
	
	new = event:new(secIn, sequenceIn, self, repeatIn)
	setmetatable(new, event)
  	table.insert(self.events, new)

end

function npc:newDialogue(secIn, sequenceIn, repeatIn)
	
	new = dialogue:new(secIn, sequenceIn, self, repeatIn)
  	table.insert(self.dialogues, new)

end

function npc:draw ()

	love.graphics.setColor(self.color)
	
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
	
	love.graphics.setColor(0,0,0)
	
	love.graphics.rectangle('line', self.x, self.y, self.width, self.height)

	love.graphics.setColor(255,255,255)
	
	if(self.selected and editorMode)then

		love.graphics.setColor(0, 0, 0, 75)
		love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
		love.graphics.setColor(255,255,255, 255)
		
		for i = 1, #self.events do

			if(self.events[i].started)then
			
				self.events[i]:draw()
		
			end	
		
		end
		
	end
end