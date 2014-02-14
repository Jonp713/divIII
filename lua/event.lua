event = {}

function event:new (dayIn, minuteIn, secIn, sequenceIn, objectIn, repeatIn)
  o = {
  
  	sequence = sequenceIn,
	  	
  	state = 1,
	started = false,
	
	targetObject = objectIn,
	
	repeaty = repeatIn,
	finished = false,
	
	startSec = (((dayIn * dayLength) + minuteIn) * 60) + gamestartSec + secIn
  
  }  
  setmetatable(o, self)
  self.__index = self
	table.insert(timeevents, o)
  return o
end

function event:trigger ()

	if(self.state <= #self.sequence and self.finished == false)then

		moveTowards(self.sequence[self.state], self.targetObject)
		
		if(collisionCheckPoint(self.sequence[self.state].x, self.sequence[self.state].y, 10, self.targetObject.x, self.targetObject.y, self.targetObject.width, self.targetObject.height))then
			self.state = self.state + 1
		end

	elseif(self.repeaty)then
	
		self.state = 1
	
	else
	
		self.finished = true
		
	end
end