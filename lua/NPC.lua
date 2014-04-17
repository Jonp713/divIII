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
	
	speed = 80,
	
	count = 0
		
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(drawables, o)
  table.insert(collidables, o)
  table.insert(chars, o)
  return o
end

function npc:newEvent(secIn, endSecIn, sequenceIn, repeatIn)
	
	new = event:new(secIn, endSecIn, sequenceIn, self, repeatIn)
	setmetatable(new, event)
  	table.insert(self.events, new)

end

function npc:newDialogue(secIn, endSecIn, sequenceIn, repeatIn, secretTypeIn, secretSeqIn)
	
	new = dialogue:new(secIn, endSecIn, sequenceIn, self, repeatIn, secretTypeIn, secretSeqIn)
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

			if(self.events[i].started and self.events[i].finished == false)then
			
				self.events[i]:draw()
		
			end	
		
		end
		
	end
end

function chars:events()

	--scroll through characters
	for i = 1, #chars do

		--scroll through character events
		for j = 1, #chars[i].events do
			--checking to see if conditional
			if(chars[i].events[j].isCondition)then
			
				--checking condition
				if(chars[i].events[j].condition)then
				
					chars[i].events[j]:trigger()
				
				end
				--reset for editor mode
				if(editorMode and chars[i].events[j].condition == false)then
	
					chars[i].events[j].started = false
					chars[i].events[j].finished = false
					chars[i].events[j].state = 1
					chars[i].events[j].resetslope = true

				end
		
			--check for movement events triggered by time, enact them
			else
			
				if(chars[i].events[j].startSec <= currentSec and chars[i].events[j].finished == false)then
				
					chars[i].events[j]:trigger()
		
				end
				
				--reset for editor mode
				if(editorMode and chars[i].events[j].startSec > currentSec)then
		
					chars[i].events[j].started = false
					chars[i].events[j].finished = false
					chars[i].events[j].state = 1
					chars[i].events[j].resetslope = true
	
				end
				
				--checking to see if next event has started and ending the current event
				if(chars[i].events[j+1])then
					if(chars[i].events[j+1].started and chars[i].events[j+1].finished == false and chars[i].events[j].started)then
		
						chars[i].events[j].finished = true
		
					end
				end
			
			end
			
		end
	
	end

end

function chars:dialogues ()

	--scroll through characters
	for i = 1, #chars do

		--scroll through their dialogues
		for j = 1, #chars[i].dialogues do
			
			--check if condition or dialogue and check if its true
			if(chars[i].dialogues[j].isCondition)then
				
				--checking condition
				if(chars[i].dialogues[j].condition)then
					
					chars[i].dialogues[j]:trigger()
					
				end
				
				--reset for editor mode
				if(editorMode and chars[i].dialogues[j].condition == false)then
			
					chars[i].dialogues[j].started = false
					chars[i].dialogues[j].finished = false
					chars[i].dialogues[j].state = 1
					chars[i].dialogues[j].resetslope = true
		
				end
			
			
			else
				--check for dialogue events triggered by time, enact them
				if(chars[i].dialogues[j].startSec <= currentSec and chars[i].dialogues[j].finished == false)then
					chars[i].dialogues[j]:trigger()
			
				end
				--finishing a dialogue if endsec has passed
				if(chars[i].dialogues[j].repeatdo and chars[i].dialogues[j].finished == false and currentSec > chars[i].dialogues[j].endSec)then
			
					chars[i].dialogues[j].finished = true
				
				end
				
				--reset for editor mode
				if(editorMode and chars[i].dialogues[j].startSec > currentSec)then
			
					chars[i].dialogues[j].started = false
					chars[i].dialogues[j].finished = false
					chars[i].dialogues[j].state = 1
					chars[i].dialogues[j].resetslope = true
		
				end
			end
			
		
		end
		
	end
	
end

function chars:set(numberQ)
	
	for i = 1, #chars do
		--need to find NEXT EVENT and set char location equal to its first member of the sequence
		for e = 1, #chars[i].events do
			
			if(chars[i].events[e].startSec <= currentSec)then	
					
				toprint = chars[i].events[e].startSec
				toprint2 = currentSec
				
				chars[i].events[e].finished = true
				chars[i].count = e

			end

		end
				
		
		--make sure the character actually has events stored
		if(#chars[i].events > 0)then		
			
			if(numberQ == 1)then
				
				if(chars[i].count > 0)then
				--set the char to the last spot they would be at -- this is nuts im not going to explain it to you asshole
			chars[i].x = chars[i].events[chars[i].count].sequence[#chars[i].events[chars[i].count].sequence].x - chars[i].width/2
			chars[i].y = chars[i].events[chars[i].count].sequence[#chars[i].events[chars[i].count].sequence].y - chars[i].height
			
				end
			elseif(numberQ == 2)then
				
				toprint = 'ok'
				
				chars[i].x = chars[i].events[1].sequence[1].x - chars[i].width/2
				chars[i].y = chars[i].events[1].sequence[1].y - chars[i].height
				
			end
		
		end	
		
		
		for d = 1, #chars[i].dialogues do
			
					
			if(chars[i].dialogues[d].startSec <= currentSec)then
			
				chars[i].dialogues[d].finished = true
			
			end
			
		end
	
	end
	
end


