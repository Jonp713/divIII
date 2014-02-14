player = {

	x = 0,
	y = 0,
	width = 23,
	height = 28,
	color = { 150, 150, 150 },
	
	drawx = 0,
	drawy = 0,
	
	left = false,
	right = true,

	illegalx = false,
	illegaly = false,
	
	reverse = false,
	
	sectionx = 0,
	sectiony = 0,
	
	speed = 0,
	acc = 0,
	yacc = 0,
	yspeed = 0,
	maxspeed = 500,
	
	moving = false
}

function player:gravity(dt)

	self.y = self.y + 100 * dt
	
	self:checkY()
end

function player:whichSection()
	player.sectionx = player.drawx/1100
	player.sectiony = player.drawy/500
end

function player:checkKeys(dt)

  if love.keyboard.isDown('left') then
    if(self.speed > 0)then
  		self.speed = self.speed - 10
  	end
 
  	self.moving = true
  
  	self.acc = -5
  	if(self.speed > - 200)then
  		self.acc = - 40
  	end
  	if(self.speed < -self.maxspeed)then
  		self.acc = 0
  		self.speed = -self.maxspeed

  	end
  	self.speed = self.speed + self.acc
  	  		    
    qleftanim:update(dt)   
      
    self.right = false
    self.left = true

	end  
  if love.keyboard.isDown('right') then
  
  	if(self.speed < 0)then
  		self.speed = self.speed + 10
  	end
  	
  	self.moving = true

  	
  	self.acc = 5
  	if(self.speed < 200)then
  		self.acc = 40
  	end
  	if(self.speed > self.maxspeed)then
  		self.acc = 0
  		self.speed = self.maxspeed
  	end
	self.speed = self.speed + self.acc
  	
    
    qrightanim:update(dt)   
    
    self.right = true
    self.left = false

	
	end
 	if love.keyboard.isDown('up') then
    self.y = self.y - 300 * dt
    
	
    
	end
 	if love.keyboard.isDown('down') then
    self.y = self.y + 300 * dt
    
    
 	end
  
  	if((love.keyboard.isDown('right') == false) and (love.keyboard.isDown('left') == false))then
  
		self.moving = false
		self.acc = 0
  	
		if(self.speed > 0)then
			qrightanim:update(dt)
		end
		if(self.speed < 0)then
			qleftanim:update(dt)
		end
		if(self.speed == 0)then
			qleftanim:seek(2)
			qrightanim:seek(2)

		end
	
  	end
    
    self.x = self.x + self.speed * dt
    
    self:checkY()
    self:checkX()
    


  
end


function player:checkX()

		self.reverse = false

		for i = 1, #sections do
			if(sections[i]:collide(player))then
				self.reverse = sections[i]:collide(player)
			end
		end
		
		if(self.reverse)then
	
			self.x = self.drawx
			
			return true

		else
			self.drawx = self.x

		end
end

function player:checkY()

		self.reverse = false

		for i = 1, #sections do
			if(sections[i]:collide(player))then
				self.reverse = sections[i]:collide(player)
				
				if(self.moving == false)then
					if(self.speed < 0)then
						self.speed = self.speed + 30
					end
					if(self.speed > 0)then
						self.speed = self.speed - 30
					end
					if((self.speed >= -30 and self.speed < 0) or (self.speed <= 30 and self.speed > 0))then
						self.speed = 0
					end
				
				end
				
			end
		end
		
		if(self.reverse)then
				
			self.y = self.drawy
			
			return true

		else
			self.drawy = self.y

		end

end

function player:animate()

	if(self.right)then

		qrightanim:draw(player.drawx, player.drawy)
	
	
	end
	
	if(self.left)then
	
		qleftanim:draw(player.drawx, player.drawy)
	
	end
end

function player:jump()


end
