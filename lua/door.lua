door = {}

function door:new (enterIn, leaveIn, extensionIn)
  o = {
  
  	opened = false,
  
  	extension = extensionIn;
  
	x = enterIn.x,
	y = enterIn.y,
	
	backx = leaveIn.x,
	backy = leaveIn.y
		
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(doors, o)
  return o
end

function door:open ()
	if love.keyboard.isDown('z') then
		
		for i = 1, #extensions do
			
			if(extensions[i].name == self.extension)then
				 
				extrax = extensions[i].x
				extray = extensions[i].y
				extensions[i].isIn = true;
				camera.drawNum = extensions[i].drawNum
			
			end
		end
		
		player.drawx = self.backx
		player.drawy = self.backy - 20
		
		player.x = self.backx
		player.y = self.backy - 20
	
		camera.inextension = true
		self.opened = true
		zpressable = false
	end
end

function door:close ()
	if love.keyboard.isDown('z') then
			
		player.drawx = self.x
		player.drawy = self.y - 20
		player.x = self.x
		player.y = self.y - 20

		camera.inextension = false
		self.opened = false
		zpressable = false

	end
end

function doors:checkAll()

	if(zpressable)then

		for i = 1, #doors do
			if(doors[i].opened == false)then
				if(collisionCheckPoint(doors[i].x, doors[i].y, 20, player.x, player.y, player.width, player.height))then
					doors[i]:open()
				end
			else
				
				if(collisionCheckPoint(doors[i].backx, doors[i].backy, 20, player.x, player.y, player.width, player.height))then
								
					doors[i]:close()
				end
			end
		end
	
	end		
	
end