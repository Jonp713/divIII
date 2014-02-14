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