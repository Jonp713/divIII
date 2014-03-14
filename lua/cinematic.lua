cinematic = {}

function cinematic:new (sequenceIn, typeIn, zoomIn, functionIn)
  o = {
  
  	state = 1,
  	sequence = sequenceIn,
  	
  	modx = 0,
  	modx2 = 0,
  	mody = 0,
  	
  	triggerGo = false,
  	
  	itype = typeIn,
  	
  	use = functionIn or 0,
  	
  	zoom = zoomIn,
  
  }  
  setmetatable(o, self)
  self.__index = self
  return o
end

function cinematic:trigger ()

	if(self.triggerGo)then
	
		player.lock = true

		if(camera.scaleX + 0.01 > self.zoom and camera.scaleX - 0.01 < self.zoom)then
		
		else

			if(camera.scaleX > self.zoom)then
	
				camera:scale(0.99,1)
	
			end
			if(camera.scaleX < self.zoom)then
	
				camera:scale(1.01, 1)
	
			end
			if(camera.scaleY > self.zoom)then
	
				camera:scale(1,0.99)

			end
			if(camera.scaleY < self.zoom)then
	
				camera:scale(1,1.01)
			end
		end

		if(self.itype == 1 or self.itype == 2)then
	
			if(love.keyboard.isDown('z') and zpressable)then
				zpressable = false
				self.state = self.state + 1
	
			end
	
			if(self.state > #self.sequence)then
		
				self.triggerGo = false
				self.state = 1
				player.lock = false
				
				

			else
	
				self:text(self.sequence[self.state].words)
	
			end

		end
		if(self.itype == 3)then
	
			self:use()
	
		end

	end
end

function cinematic:text (textIn)

	count = #textIn
		
	if(count > 50)then
	
		found = false
	
		for i = count/2, count do
		
			j = textIn:sub(i,i)
			
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
			
	else
		
		count = #textIn
	
		self.modx = count * 3
		
	end
	
	self.mody = 20
	
	love.graphics.setColor(255,255,255, 200)

	love.graphics.rectangle('fill', 420, 325, 490, 50)
	
	love.graphics.setColor(0, 0, 0, 255)
	
	
	if(count > 50)then
	
		love.graphics.print(textIn:sub(0, count2), 450, 335)
		love.graphics.print(textIn:sub(count2 + 1, count), 450, 348)
  	
  	else
  	
  	  	love.graphics.print(textIn, 500, 350)
  	
  	end
  	
	love.graphics.setColor(255,255,255)
	
end
