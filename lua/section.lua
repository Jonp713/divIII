section = {}
sections = {}

function section:new (xIn, yIn, gridIn, nameIn)
  o = {
  
  
  	xBig = xIn,
  	yBig = yIn,
	width = 1100,
	height = 500,
	x = 1100 * xIn,
	y = 500 * yIn,
	
	grid = gridIn,
	
	name = nameIn
  
  }  

	if((xIn + 1) * 1100 > worldWidth) then

		worldWidth = (xIn + 1) * 1100

	end
	if((yIn + 1) * 500 > worldHeight) then

		worldHeight= (yIn + 1) * 500

	end

  table.insert(sections, o)
  
  setmetatable(o, self)
  self.__index = self
  return o
end


function section:draw ()


end


function section:displayGrid ()

    for y=1, #self.grid do
        for x= 1, #self.grid[y] do
            if self.grid[y][x] == 1 then
            
            love.graphics.draw(stone, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y)

            end
            
            
            if self.grid[y][x] == 2 then
            
            	--love.graphics.setColor(50,250, 100)
                love.graphics.rectangle("line", ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50)
                
            	love.graphics.print(y, ((x -1) * 50) + self.x + 5, ((y - 1) * 50) + self.y + 15)
            	love.graphics.print(", " .. x, ((x -1) * 50) + self.x + 20, ((y - 1) * 50) + self.y + 15)
            	love.graphics.print(self.name, ((x -1) * 50) + self.x + 5, ((y - 1) * 50) + self.y + 35)


            end
            if self.grid[y][x] == 3 then
            
                love.graphics.draw(wood, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y)

            end
        	if self.grid[y][x] == -1 then
            
                love.graphics.draw(tin, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y)

            end
            if self.grid[y][x] == 5 then
            
                love.graphics.draw(red, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y)

            end
        end
    end

end


function section:collide(object, xory)

  for y=1, #self.grid do
        for x= 1, #self.grid[y] do
            if self.grid[y][x] == 1  then
            
            	if(xory == 'x')then
            
					if(collisionCheckBox(object.x, object.drawy, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy))then
				
						return collisionCheckBox(object.x, object.drawy, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy)
						
					end
				
				elseif(xory == 'y')then
					
					if(collisionCheckBox(object.drawx, object.y, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy))then
				
						return collisionCheckBox(object.drawx, object.y, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy)
					
					end
				
				end
				
            end
            if self.grid[y][x] == 3 or self.grid[y][x] == 5 then
                   
                if(xory == 'x')then

					
				elseif(xory == 'y')then
					if(collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy))then
				
						return collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy)
					end
				end                
            end
        end
    end

end

function section:onTop(object)
 	for y=1, #self.grid do
        for x= 1, #self.grid[y] do
            if self.grid[y][x] > 0  then
          	 
                	if(collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy))then
				
						return collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy)
					end
          	end	
        end 
    end 
end
