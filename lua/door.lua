door = {}

function door:new (enterIn, leaveIn)
  o = {
  
  	opened = false,
  
	enterx = enterIn.x,
	entery = enterIn.y,
	
	leavex = leaveIn.x,
	leavey = leaveIn.y
		
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(doors, o)
  return o
end

function door:open ()
	if love.keyboard.isDown('z') then
	
		player.drawx = self.leavex
		player.drawy = self.leavey
		player.x = self.leavex
		player.y = self.leavey

		self.opened = true
		zpressable = false
	end
end

function door:close ()
	if love.keyboard.isDown('z') then
		player.drawx = self.enterx
		player.drawy = self.entery
		player.x = self.enterx
		player.y = self.entery

		self.opened = false
		zpressable = false

	end
end

function doors:checkAll()


	if(zpressable)then

		for i = 1, #doors do
			if(doors[i].opened == false)then
				if(collisionCheckPoint(doors[i].enterx, doors[i].entery, 20, player.x, player.y, player.width, player.height))then
					doors[i]:open()
				end
			else
				if(collisionCheckPoint(doors[i].leavex, doors[i].leavey, 20, player.x, player.y, player.width, player.height))then
					doors[i]:close()
				end
			end
		end
	
	end		
	
end