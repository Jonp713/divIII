dialogue = {}

function dialogue:new (dayIn, minuteIn, secIn, sequenceIn, objectIn, repeatIn)
  o = {
  
  	state = 1,
  	sequence = sequenceIn,
	startTime = 0,
	endTime = 0,
	started = false,
	
	targetObject = objectIn,
	
	finished = false,
	
	startSec = (((dayIn * dayLength) + minuteIn) * 60) + gamestartSec + secIn,

	repeaty = repeatIn
  
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(timeevents, o)
  return o
end

function dialogue:talk (dia)

	love.graphics.setColor(0, 0, 0)
  	love.graphics.print(dia, self.targetObject.x - 70, self.targetObject.y - 20)
	love.graphics.setColor(255,255,255)

end


function dialogue:trigger ()

	if(self.state <= #self.sequence)then

		self:talk(self.sequence[self.state][1])
	
		if(self.started == false)then
			self.startTime = love.timer.getTime()
			self.endTime = self.startTime + self.sequence[self.state][2]
			self.started = true
		end
		if(love.timer.getTime() >= self.endTime)then
			self.started = false
			self.state = self.state + 1
		end
	
	elseif(self.repeaty)then
		self.state = 1
	else
		self.finished = true
	end

end