interaction = {}
interactions = {}

function interaction:new (secStart, secEnd, sequenceIn, objectIn, typeIn, functionIn)
  o = {
  
  	state = 1,
  	sequence = sequenceIn,
	startTime = secStart,
	endTime = secEnd,
	
	object = objectIn,
  	
  	triggerGo = false,
  	
  	itype = typeIn,
  	
  	use = functionIn or 0,
  
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(interactions, o)
  return o
end

function interaction:display ()

	if(collisionCheck(player.x, player.y, player.height, player.width, self.object.x, self.object.y, 40, 80) and player.lock == false)then
	
		love.graphics.setColor(255,255,255, 200)

		love.graphics.rectangle('fill', 590, 325, 140, 33)
	
		love.graphics.setColor(0, 0, 0, 255)
	
		if(self.itype == 1)then
	
			love.graphics.print("Press Z to read", 610, 335)
		
		end
		if(self.itype == 2)then
		
			love.graphics.print("Press Z to talk", 610, 335)

		end
		if(self.itype == 3)then
			
			love.graphics.print("Press Z to use", 610, 335)
		
		end
		
		if(love.keyboard.isDown('z') and zpressable)then
			zpressable = false
			self.triggerGo = true
			player.lock = true
	
		end
	
	end


end

function interaction:trigger ()

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

function interaction:text (textIn)

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
