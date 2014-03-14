event = {}

function event:new (secIn, sequenceIn, objectIn, repeatIn)
  o = {
  
  	sequence = sequenceIn,
	  	
  	state = 1,
	started = false,
	
	targetObject = objectIn,
	
	repeaty = repeatIn,
	finished = false,
	
	startSec = secIn,
	
	resetslope = true,
  
  	deltax = 0,
  	deltay = 0,
  	
  	slope = 0,
  	
  	xspeed = 0,
  	yspeed = 120,
  	xspeedsend = 0,
  	yspeedsend = 0
  }  
  setmetatable(o, self)
  self.__index = self
	table.insert(timeevents, o)
  return o
end


function event:addPoint(xIn, yIn, speedIn) 

	new = {x = xIn, y = yIn, speed = speedIn}
	table.insert(self.sequence, new)
	
end
function event:trigger()

	if(self.state <= #self.sequence and self.finished == false)then
		
		self.started = true
		
		if(self.resetslope)then
		
			if(backward and editorMode)then

				self.resetslope = false
				deltax = (self.targetObject.x + (self.targetObject.width/2)) - self.sequence[self.state - 1].x
				deltay = (self.targetObject.y + self.targetObject.height) - self.sequence[self.state - 1].y
				
			else
			
				self.resetslope = false
				deltax = (self.targetObject.x + (self.targetObject.width/2)) - self.sequence[self.state].x
				deltay = (self.targetObject.y + self.targetObject.height) - self.sequence[self.state].y
			
			end
			
			self.slope = deltax/deltay

			if(deltay == 0)then
				
				self.slope = deltax/100
				
			end
			
			if(self.slope < 0)then
			
				self.slope = self.slope * - 1
				
			end	
			
			self.xspeedsend = self.sequence[self.state].speed/self.slope
			
			self.yspeedsend = self.xspeedsend
				

		end
		
		--weird editor behavior
		if(editorMode)then
			if(forward)then
			
				moveTowardsBottom(self.sequence[self.state], self.targetObject, self.slope, self.xspeedsend, self.yspeedsend, alldt)

				if(collisionCheckPoint(self.sequence[self.state].x, self.sequence[self.state].y, 4, self.targetObject.x, self.targetObject.y, self.targetObject.width, self.targetObject.height))then
					
					self.state = self.state + 1
					self.resetslope = true
				end
		
			
			elseif(backward and self.state > 1)then
			
				moveTowardsBottom(self.sequence[self.state -1], self.targetObject, self.slope, self.xspeedsend, self.yspeedsend, alldt)
				
				if(collisionCheckPoint(self.sequence[self.state - 1].x, self.sequence[self.state - 1].y, 4, self.targetObject.x, self.targetObject.y, self.targetObject.width, self.targetObject.height))then
					self.state = self.state - 1
					self.resetslope = true
				end

			end	
		
		else
		
		--what should be happening
		
			moveTowardsBottom(self.sequence[self.state], self.targetObject, self.slope, self.xspeedsend, self.yspeedsend, alldt)

			if(collisionCheckPoint(self.sequence[self.state].x, self.sequence[self.state].y, 4, self.targetObject.x, self.targetObject.y, self.targetObject.width, self.targetObject.height))then
				self.state = self.state + 1
				self.resetslope = true
			end
		
		end


	elseif(self.repeaty)then
	
		self.state = 1
	
	else
	
		self.finished = true
		self.started = false

	end
end

function event:draw()

	for i = 1, #self.sequence do
	
	    love.graphics.setColor(0, 255, 0, 255)

		if(i < #self.sequence)then
	
			love.graphics.line(self.sequence[i].x, self.sequence[i].y, self.sequence[i + 1].x, self.sequence[i + 1].y)

		end
		
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.setPointSize( 10 )
		love.graphics.point(self.sequence[i].x, self.sequence[i].y)
		love.graphics.setColor(255, 255, 255, 255)

	end


end