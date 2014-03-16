dialogue = {}

function dialogue:new (secIn, endSecIn, sequenceIn, objectIn, repeatIn)
  o = {
  
  	state = 1,
  	sequence = sequenceIn,
	startTime = 0,
	endTime = 0,
	started = false,
	
	targetObject = objectIn,
	
	finished = false,
	
	--startSec = (((dayIn * dayLength) + minuteIn) * 60) + secIn,
	startSec = secIn,
	endSec = endSecIn,

	repeatdo = repeatIn,
  	
  	modx = 0,
  	modx2 = 0,
  	mody = 0
  
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(timeevents, o)
  return o
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
		
		toprint = 'over'
	end
	
	if(count <= 26)then
		
		count = #dia
	
		self.modx = count * 3
		
		toprint = 'under'

	end
	
	self.mody = 20	
	
	if(count > 26)then
	
		love.graphics.setColor(255,255,255, 200)

		love.graphics.rectangle('fill', (self.targetObject.x - self.modx) + (self.targetObject.width/2) - 15, self.targetObject.y - self.mody - 47, (count2 * 8) + 10, 57)

		love.graphics.setColor(0, 0, 0, 255)
	
		love.graphics.print(dia:sub(0, count2), (self.targetObject.x - self.modx) + (self.targetObject.width/2), self.targetObject.y - self.mody - 35)
		love.graphics.print(dia:sub(count2 + 1, count), (self.targetObject.x - self.modx2) + (self.targetObject.width/2), self.targetObject.y - self.mody - 20)

  	end
  	if(count <= 26 and count ~= 0)then
  	
  		love.graphics.setColor(255,255,255, 200)

		love.graphics.rectangle('fill', (self.targetObject.x - self.modx) + (self.targetObject.width/2) - 15, self.targetObject.y - self.mody - 28, (count * 7) + 10, 45)

		love.graphics.setColor(0, 0, 0, 255)
  	
  	  	love.graphics.print(dia, (self.targetObject.x - self.modx) + (self.targetObject.width/2), self.targetObject.y - self.mody - 20)
  	
  	end

	love.graphics.setColor(255,255,255)

end


function dialogue:trigger ()

	if(self.state <= #self.sequence)then

		self:talk(self.sequence[self.state].words)
	
		if(self.started == false)then
			self.startTime = love.timer.getTime()
			self.endTime = self.startTime + self.sequence[self.state].time
			self.started = true
		end
		if(love.timer.getTime() >= self.endTime)then
			self.started = false
			self.state = self.state + 1
		end
	
	elseif(self.repeatdo)then
		self.state = 1
	else
		self.finished = true
	end

end