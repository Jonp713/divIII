dialogue = {}

function dialogue:new (secIn, endSecIn, sequenceIn, objectIn, repeatIn, secretTypeIn, secretSeqIn)
  o = {
  
  	state = 1,
  	sequence = sequenceIn,
	startTime = 0,
	endTime = 0,
	workingTime = 0,
	workTime = 0,
	started = false,
	restarted = false,
	isCondition = false,
	condition = function() return true end,
	
	targetObject = objectIn,
	
	finished = false,
	
	startSec = secIn,
	endSec = endSecIn,

	repeatdo = repeatIn,
	secretType = secretTypeIn,
  	secretSeq = secretSeqIn,
	
	safe = true,
	
  	
  	modx = 0,
  	modx2 = 0,
  	mody = 0
  
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(timeevents, o)
  return o
end

function dialogue:checkSafe()
	--bottom
	if(self.secretType == 1)then
		if(player.drawy > self.targetObject.y + 80)then
			
			if(player.drawx < self.targetObject.x + 150 and player.drawx > self.targetObject.x - 150)then
				self.safe = true
			else
			
				self.safe = false

			end
			
		else
		
			self.safe = false
		
		end

	end
	--top
	if(self.secretType == 2)then


	end
	--left
	if(self.secretType == 3)then


	end
	--right
	if(self.secretType == 4)then


	end
	
end


function dialogue:talk (dia)

	count = #dia
		
	if(count > 26)then
	
		found = false
	
		for i = count/2, count do
		
			j = dia:sub(i,i)
			
			if(j == ' ' and found == false)then
			
				foundcount = i
				found = true
			end
		
		end
		
		if(found == false)then
		
			foundcount = count
			
		end
	
		count2 = foundcount
		
		self.modx = count2 * 3

		self.modx2 = count2 * 3
		
	end
	
	if(count <= 26)then
		
		count = #dia
	
		self.modx = count * 3
		
	end
	
	self.mody = 20	
	
	if(count > 26)then
	
		love.graphics.setColor(255,255,255, 200)

		love.graphics.rectangle('fill', (self.targetObject.x - self.modx) + (self.targetObject.width/2) - 15, self.targetObject.y - self.mody - 47, (count2 * 7.3) + 30, 52)

		love.graphics.setColor(0, 0, 0, 255)
	
		love.graphics.print(dia:sub(0, count2), (self.targetObject.x - self.modx) + (self.targetObject.width/2), self.targetObject.y - self.mody - 35)
		love.graphics.print(dia:sub(count2 + 1, count), (self.targetObject.x - self.modx2) + (self.targetObject.width/2), self.targetObject.y - self.mody - 20)

  	end
  	if(count <= 26 and count ~= 0)then
  	
  		love.graphics.setColor(255,255,255, 200)

		love.graphics.rectangle('fill', (self.targetObject.x - self.modx) + (self.targetObject.width/2) - 15, self.targetObject.y - self.mody - 28, (count * 7) + 30, 35)

		love.graphics.setColor(0, 0, 0, 255)
  	
  	  	love.graphics.print(dia, (self.targetObject.x - self.modx) + (self.targetObject.width/2), self.targetObject.y - self.mody - 20)
  	
  	end

	love.graphics.setColor(255,255,255)

end


function dialogue:trigger ()

	self:checkSafe()

	if(self.state <= #self.sequence)then
	
		if(self.safe)then
	
			self:talk(self.sequence[self.state].words)
			
		else
			
			self:talk(self.secretseq[1].words)
			
		end
		
		if(self.started == false)then
		
			if(self.restarted == false)then
			
				self.startTime = math.floor((love.timer.getTime() - gamestartSec) + modifier)
				self.workTime = self.startTime

			end
			
			self.endTime = self.startTime + self.sequence[self.state].time
			self.started = true
			self.restarted = false
		end
		
		if(editorMode)then
			if(backward)then
		
				self.workTime = self.workTime - alldt		
		
			elseif(forward)then
				
				self.workTime = self.workTime + alldt		

			end
		else
			--prevents dialogue from continuing if the player is not safe
			if(self.safe)then
			
				--progresses the dialogue if player is safe
				self.workTime = self.workTime + alldt		
			
			else
				--possible changes for the unsafe text or could change unsafe text talk to a unsafetalk that changes stuff isntead....
				
				
			
			end

		end
		
		if(self.workTime < self.startTime and (self.state - 1) ~= 0 and backward)then
			self.state = self.state - 1
			self.startTime = self.startTime - self.sequence[self.state].time 
			self.started = false
			self.restarted = true
			
		end
		if(self.workTime >= self.endTime)then
			self.started = false
			self.state = self.state + 1
		end
		


	elseif(self.repeatdo)then
		self.state = 1
	else
		self.finished = true
	end

end

