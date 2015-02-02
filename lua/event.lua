event = {}

function event:new (secIn, endSecIn, sequenceIn, objectIn, repeatIn)
  o = {
  
  	sequence = sequenceIn,
	  	
  	state = 1,
	started = false,
	restarted = false,
	
	targetObject = objectIn,

	repeatdo = repeatIn,
	finished = false,
	
	startTime = 0,
	endTime = 0,
	workingTime = 0,
	workTime = 0,
	
	isCondition = false,
	condition = function() return true end,
	
	startSec = secIn,
	endSec = endSecIn,
	
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


function event:addPoint(xIn, yIn, speedIn, timeIn) 

	new = {x = xIn, y = yIn, speed = speedIn, door = false, time = timeIn}
	table.insert(self.sequence, new)
	
end

function event:trigger()

	if(self.state <= #self.sequence and self.finished == false)then
		
		if(self.sequence[self.state].time > 0)then
			
			if(self.started == false)then
		
				if(self.restarted == false)then
			
					self.startTime = math.floor((love.timer.getTime() - gamestartSec) + modifier)
					self.workTime = self.startTime

				end
			
				self.endTime = self.startTime + self.sequence[self.state].time
				self.started = true
				self.restarted = false
			end
		
			if(editorMode or pause)then
				if(backward)then
						
					self.workTime = self.workTime - alldt		
				
				end
				
				if(forward)then
					
					self.workTime = self.workTime + alldt		
					
				end
				
			else
				
				self.workTime = self.workTime + alldt		
	
			end
			
			--reverse for editormode
			if(self.workTime < self.startTime and (self.state - 1) ~= 0 and backward)then
				self.state = self.state - 1
				self.startTime = 0
				self.started = false
				self.restarted = true
				
			end
			if(self.workTime >= self.endTime)then
				self.started = false
				self.state = self.state + 1
				
				toprint = toprint + 1
				
			end
			
		else
			
			self.started = true
			
			if(self.sequence[self.state].door)then
			
				if(editorMode)then
				
					if(editor.count == 20)then
					
						if(backward or forward)then
			
							editor.count = 0
				
							self.targetObject.x = self.sequence[self.state].x - (self.targetObject.width/2)
							self.targetObject.y = self.sequence[self.state].y - self.targetObject.height

							self.state = self.state + 1
					
						end
			
					else
					
						if(backward or forward)then
				
							editor.count = editor.count + 1
					
						end
					
					end
			
				else
				
					self.targetObject.x = self.sequence[self.state].x - (self.targetObject.width/2)
					self.targetObject.y = self.sequence[self.state].y - self.targetObject.height

					self.state = self.state + 1
				
				end
		
			else
			
				if(self.resetslope)then
	
					if(backward and editorMode and self.state > 1)then

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
				if(editorMode or pause)then
					if(forward)then
					
						moveTowardsBottom(self.sequence[self.state], self.targetObject, self.slope, self.xspeedsend, self.yspeedsend, alldt)
					
						if(fast)then
					
							if(collisionCheck2Points(self.sequence[self.state].x, self.sequence[self.state].y, 50, self.targetObject.x + self.targetObject.width/2, self.targetObject.y + self.targetObject.height, 2))then
				
								self.state = self.state + 1
								self.resetslope = true
							
							end
	
						else
						
							if(collisionCheck2Points(self.sequence[self.state].x, self.sequence[self.state].y, 10, self.targetObject.x + self.targetObject.width/2, self.targetObject.y + self.targetObject.height, 2))then
				
								self.state = self.state + 1
								self.resetslope = true
							
							end
					
						end
		
					elseif(backward and self.state > 1)then
		
						moveTowardsBottom(self.sequence[self.state -1], self.targetObject, self.slope, self.xspeedsend, self.yspeedsend, alldt)
			
						if(collisionCheck2Points(self.sequence[self.state - 1].x, self.sequence[self.state - 1].y, 10, self.targetObject.x + self.targetObject.width/2, self.targetObject.y + self.targetObject.height, 2))then
							self.state = self.state - 1
							self.resetslope = true
						end

					end	
	
				else
	
					--what should be happening
	
					moveTowardsBottom(self.sequence[self.state], self.targetObject, self.slope, self.xspeedsend, self.yspeedsend, alldt)

					if(collisionCheck2Points(self.sequence[self.state].x, self.sequence[self.state].y, 2, self.targetObject.x + self.targetObject.width/2, self.targetObject.y + self.targetObject.height, 2))then
						self.state = self.state + 1
						self.resetslope = true
					end
	
				end
	
			end
			
		end

	elseif(self.repeatdo)then
	
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
		
		
		if(self.sequence[i].time > 0)then
		
			love.graphics.setColor(0, 100, 255, 255)
			love.graphics.setPointSize( 10 )
			love.graphics.point(self.sequence[i].x, self.sequence[i].y)
			love.graphics.setColor(255, 255, 255, 255)
		
		else
			
			love.graphics.setColor(0, 255, 0, 255)
			love.graphics.setPointSize( 10 )
			love.graphics.point(self.sequence[i].x, self.sequence[i].y)
			love.graphics.setColor(255, 255, 255, 255)
			
		end

	end


end