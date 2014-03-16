camera = {}
camera._x = 0
camera._y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
camera.modifier = 0
 
function camera:set()

  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self._x, -self._y)
  
end
 
function camera:unset()
  love.graphics.pop()
end

function camera:debug()

  	love.graphics.print(self._bounds.y2, 500, 200)
  	love.graphics.print(self._bounds.x2, 500, 100)
end
 
function camera:move(dx, dy)
  self._x = self._x + (dx or 0)
  self._y = self._y + (dy or 0)
end
 
function camera:rotate(dr)
  self.rotation = self.rotation + dr
end
 
function camera:scale(sx, sy)
toprint = 'scaling'
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end
 
function camera:setX(value)
  if self._bounds then
    self._x = math.clamp(value, self._bounds.x1, self._bounds.x2)
  else
    self._x = value
  end
end
 
function camera:setY(value)
  if self._bounds then
    self._y = math.clamp(value, self._bounds.y1, self._bounds.y2)
  else
    self._y = value
  end
end
 
function camera:setPosition(x, y)
  if x then self:setX(x) end
  if y then self:setY(y) end
end
 
function camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end
 
function camera:getBounds()
  return unpack(self._bounds)
end
 
function camera:setBounds(x1, y1, x2, y2)
  self._bounds = { x1 = x1, y1 = y1, x2 = x2, y2 = y2 }
end

function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end

function camera:newLayer(scale, func)
  table.insert(self.layers, { draw = func, scale = scale })
  table.sort(self.layers, function(a, b) return a.scale < b.scale end)
end

function camera:getPos()

	y = (love.mouse.getY() * self.scaleY) + (self._y * 5)
	x = (love.mouse.getX() * self.scaleX) + (self._x * 5)
	
	love.graphics.print("x: " .. x .. ' ,', 10, 10)
	love.graphics.print("y: " .. y, 10, 20)
	
	return x,y
	
end

function camera:checkKeys(dt)

	if(love.keyboard.isDown('up'))then
	
		self.modifier = self.modifier - math.ceil(300 *dt)
	
	end
	if(love.keyboard.isDown('down'))then
	
		self.modifier = self.modifier + math.ceil(300 *dt)
		
	end

	if(self.modifier > 150)then
	
		self.modifier = 150
	
	end
	if(self.modifier < - 150)then
	
		self.modifier = -150
	
	end
	
	if(love.keyboard.isDown('down') == false and love.keyboard.isDown('up') == false and ifcinematic == false)then
	
		if(self.modifier > 0)then
	
			self.modifier = self.modifier - math.ceil(500 * dt)
	
		end
		if(self.modifier < 0)then
		
			self.modifier = self.modifier + math.ceil(500 * dt)

	
		end
	
	end
	
	if(editorMode)then
	
		if(love.keyboard.isDown('t'))then
	
			camera:scale(0.99,0.99)
	
		end
		if(love.keyboard.isDown('y'))then
	
			camera:scale(1.01,1.01)
	
		end
	
	end
	
	
	if(camera.scaleX + 0.01 > 1 and camera.scaleX - 0.01 < 1)then
		
	elseif(editorMode == false and player.lock == false)then

		if(camera.scaleX > 1)then

			camera:scale(0.99,1)

		end
		if(camera.scaleX < 1)then

			camera:scale(1.01, 1)

		end
		if(camera.scaleY > 1)then

			camera:scale(1,0.99)

		end
		if(camera.scaleY < 1)then

			camera:scale(1,1.01)
		end
	end

end

function camera:returnPos()

	return self._x, self._y

end

function camera:drawBackground()
  local bx, by = self._x, self._y
  
  for _, v in ipairs(self.layers) do
    self._x = bx * v.scale
    self._y = by * v.scale
    camera:set()
    v.draw()
    camera:unset()
  end
end