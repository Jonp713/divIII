section = {}
sections = {}

function section:new (xIn, yIn, gridIn, colIn, nameIn)
	o = {
  		--large scale coordinate of sections
		xBig = xIn,
		yBig = yIn,
		width = 1100,
		height = 500,
		x = 1100 * xIn,
		y = 500 * yIn,
	
		grid = gridIn,
		
		col = colIn,
	
		name = nameIn
  
	}  
	-- determines world width and height based off of this new section

	if((xIn + 1) * 1100 > worldWidth) then

		worldWidth = (xIn + 1) * 1100

	end
	if((yIn + 1) * 500 > worldHeight) then

		worldHeight = (yIn + 1) * 500

	end	
	
	--adds this section to aggregate section table
	table.insert(sections, o)
  	--does necessary lua stuf
	setmetatable(o, self)
	self.__index = self
	return o
end

--returns section and specific grid piece that is at given x,y coordinates
function section:getSection (xIn, yIn)
	  for y=1, #self.grid do
        for x= 1, #self.grid[y] do
			    if( ((x -1) * 50) + self.x  < xIn and (x * 50) + self.x  > xIn)then
			    	if( ((y -1) * 50) + self.y  < yIn and (y * 50) + self.y  > yIn)then
			    	
			    		return true, x, y, self.xBig, self.yBig, self.name
			    	
			    	end
			    end
        end
    end
end


function section:displayGrid ()

    for y=1, #self.grid do
        for x= 1, #self.grid[y] do
            if self.grid[y][x] == 1 then
            
            	love.graphics.draw(stone, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y)

            end   
            if self.grid[y][x] == -1 then
            
            	love.graphics.setColor(0, 0, 0, 255)

                love.graphics.rectangle("line", ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50)
                
            	love.graphics.print(y, ((x -1) * 50) + self.x + 5, ((y - 1) * 50) + self.y + 15)
            	love.graphics.print(", " .. x, ((x -1) * 50) + self.x + 20, ((y - 1) * 50) + self.y + 15)
            	love.graphics.print(self.name, ((x -1) * 50) + self.x + 5, ((y - 1) * 50) + self.y + 35)
				love.graphics.setColor(255,255,255,255)


            end
            if self.grid[y][x] == 3 then
            
                love.graphics.draw(wood, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y)

            end
        	if self.grid[y][x] == 2 then
            
                love.graphics.draw(tin, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y)

            end
            if self.grid[y][x] == 4 then
            
                love.graphics.draw(red, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y)

            end
        end
    end
    
    
    if ((self.xBig == editor.bigX) and (self.yBig == editor.bigY)) and (editorMode)then
		
		love.graphics.setColor(0, 255, 0, 75)
        love.graphics.rectangle("fill", ((editor.x -1) * 50) + self.x, ((editor.y - 1) * 50) + self.y, 50, 50)
		love.graphics.setColor(255,255,255,255)
	end

end


function section:collide(object, xory)

  for y=1, #self.col do
        for x= 1, #self.col[y] do
            if self.col[y][x] == 1  then
            
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
            if self.col[y][x] == 2 then
                   
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
 	for y=1, #self.col do
        for x= 1, #self.col[y] do
            if self.col[y][x] > 0  then
          	 
                	if(collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy))then
				
						return collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * 50) + self.x, ((y - 1) * 50) + self.y, 50, 50, object.drawx, object.drawy)
					end
          	end	
        end 
    end 
end
