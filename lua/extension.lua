extension = {}
extensions = {}

function extension:new (xIn, yIn, gridIn, colIn, nameIn, numbIn)
	o = {
  		--large scale coordinate of sections
		xBig = xIn,
		yBig = yIn,
		width = 1280,
		height = 400,
		x = 1280 * xIn,
		y = 400 * yIn,
	
		grid = gridIn,
		
		col = colIn,
		drawNum = numbIn,
		
		coords = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, },
	
		name = nameIn,
		
		isIn = false,
		
		blockwidth = 40,
		blockheight = 40
  
	}  
		
	for yIn=1, #o.grid do
        for xIn = 1, 32 do
        
        	table.insert(o.coords[yIn], {x = ((xIn - 1 )* o.blockwidth) + o.x , y = ((yIn - 1) * o.blockheight) + o.y})

        end
    end
	
	--adds this section to aggregate section table
	table.insert(extensions, o)
	table.insert(sections, o)
  	--does necessary lua stuf
	setmetatable(o, self)
	self.__index = self
	return o
end

--returns section and specific grid piece that is at given x,y coordinates
function extension:getSection (xIn, yIn)
	  for y=1, #self.grid do
        for x= 1, #self.grid[y] do
			    if( ((x -1) * self.blockwidth) + self.x  <= xIn and (x * self.blockwidth) + self.x  >= xIn)then
			    	if( ((y -1) * self.blockheight) + self.y  <= yIn and (y * self.blockheight) + self.y  >= yIn)then
			    	
			    		return true, x, y, self.xBig, self.yBig, self.name
			    	
			    	end
			    end
        end
    end
end


function extension:displayGrid ()

    for y=1, #self.grid do
        for x= 1, #self.grid[y] do
			
            love.graphics.setColor(255, 255, 255)
            love.graphics.rectangle("fill", ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight)
            love.graphics.setColor(255, 255, 255)
            if self.grid[y][x] == -1 then
            
            	love.graphics.setColor(0, 0, 0, 255)
				love.graphics.setNewFont(8)

                love.graphics.rectangle("line", ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight)
                
            	love.graphics.print(y, ((x -1) * self.blockwidth) + self.x + 5, ((y - 1) * self.blockheight) + self.y + 10)
            	love.graphics.print(", " .. x, ((x -1) * self.blockwidth) + self.x + 20, ((y - 1) * self.blockheight) + self.y + 10)
            	love.graphics.print(self.xBig .. ', '..self.yBig, ((x -1) * self.blockwidth) + self.x + 5, ((y - 1) * self.blockheight) + self.y + 25)
				love.graphics.setColor(255,255,255,255)
				love.graphics.setNewFont(12)

            end
			
			if(blocks[self.grid[y][x]] ~= nil)then

			
           	 	   love.graphics.draw(blocks[self.grid[y][x]], ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y)
			
			else
				
			
			
			
       	 	end
		end
    end
    
    
    if(editorMode)then
    
    	for i = 1, #editor.chosen do
    
			if ((self.xBig == editor.chosen[i].bigX) and (self.yBig == editor.chosen[i].bigY)) and (editorMode)then
		
				love.graphics.setColor(122, 122, 122, 75)
				love.graphics.rectangle("fill", ((editor.chosen[i].x -1) * self.blockwidth) + self.x, ((editor.chosen[i].y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight)
				love.graphics.setColor(255,255,255,255)
				
			end
		
		end
	
	end

    
    
    if(editorMode)then
    
    	for i = 1, #editor.chosen do
    
			if ((self.xBig == editor.chosen[i].bigX) and (self.yBig == editor.chosen[i].bigY)) and (editorMode)then
		
				love.graphics.setColor(122, 122, 122, 75)
				love.graphics.rectangle("fill", ((editor.chosen[i].x -1) * self.blockwidth) + self.x, ((editor.chosen[i].y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight)
				love.graphics.setColor(255,255,255,255)
				
			end
		
		end
	
	end

end


function extension:collide(object, xory)

  for y=1, #self.col do
        for x= 1, #self.col[y] do
            if self.col[y][x] == 1  then
            
            	if(xory == 'x')then
            
					if(collisionCheckBox(object.x, object.drawy, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy))then
				
						return collisionCheckBox(object.x, object.drawy, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy)
						
					end
				
				elseif(xory == 'y')then
					
					if(collisionCheckBox(object.drawx, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy))then
				
						return collisionCheckBox(object.drawx, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy)
					
					end
				
				end
				
            end
            --standable
            if self.col[y][x] == 2 then
                   
                if(xory == 'x')then

					
				elseif(xory == 'y')then
					if(collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy))then
				
						return collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight,object.drawx, object.drawy)
					end
				end                
            end
            --rightside
            if self.col[y][x] == 3 then
                   
                if(xory == 'y')then

					
				elseif(xory == 'x')then
				
					if(collisionCheckSide(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy, 1))then
				
						return collisionCheckSide(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight,object.drawx, object.drawy, 1)
					end
				end  
			end
			--leftside              
            if self.col[y][x] == 4 then
                   
                if(xory == 'y')then

					
				elseif(xory == 'x')then
				
					if(collisionCheckSide(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy, 2))then
				
						return collisionCheckSide(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight,object.drawx, object.drawy, 2)
					end
				end                
            end
            --rightside and standable
            if self.col[y][x] == 5 then
                   
                if(xory == 'y')then
					
					if(collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy))then
				
						return collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight,object.drawx, object.drawy)
					end
					
				elseif(xory == 'x')then
				
					if(collisionCheckSide(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy, 1))then
				
						return collisionCheckSide(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight,object.drawx, object.drawy, 1)
					end
				end                
            end
            --leftside and standable
            if self.col[y][x] == 6 then
                   
                if(xory == 'y')then
					
					if(collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy))then
				
						return collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight,object.drawx, object.drawy)
					end
					
				elseif(xory == 'x')then
				
					if(collisionCheckSide(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy, 2))then
				
						return collisionCheckSide(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight,object.drawx, object.drawy, 2)
					end
				end                
            end
        end
    end
end

function extension:onTop(object)
 	for y=1, #self.col do
        for x= 1, #self.col[y] do
            if self.col[y][x] > 0  then
          	 
                	if(collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight, object.drawx, object.drawy))then
				
						return collisionCheckOneWay(object.x, object.y, object.width, object.height, ((x -1) * self.blockwidth) + self.x, ((y - 1) * self.blockheight) + self.y, self.blockwidth, self.blockheight,object.drawx, object.drawy)
					end
          	end	
        end 
    end 
end

function extensions:getSizes()
	
	extensionsSizes = {

		x = {},
		y = {},
		x2 = {},
		y2 = {}

	}
	
	amountofdraws = 0
 	for i=1, #extensions do
		
		if(extensions[i].drawNum > amountofdraws)then
			
			amountofdraws = extensions[i].drawNum
			
		end

	end
	
	o = {}

	--manditory instertion of tables based on amount of section parts
	for i = 1, amountofdraws do
		
		table.insert(extensionsSizes.x, o)
		table.insert(extensionsSizes.y, o)
		table.insert(extensionsSizes.x2, o)
		table.insert(extensionsSizes.y2, o)
		
	end
	
 	for i=1, #extensions do

		x = extensions[i].x
		y = extensions[i].y
		x2 = extensions[i].x + extensions[i].width
		y2 = extensions[i].y + extensions[i].height
		
        for j= 1, #extensions do	

			if(extensions[i].drawNum == extensions[j].drawNum)then
			
				if(extensions[j].x < x)then
					
					x = extensions[j].x
					
				end
				
				if(extensions[j].y < y)then
					
					y = extensions[j].y
					
				end
				
				if(extensions[j].x + extensions[i].width > x)then
					
					x2 = extensions[j].x + extensions[i].width
					
				end
				
				if(extensions[j].y + extensions[i].height > y)then
					
					y2 = extensions[j].y + extensions[i].height
					
				end
				
				
			end
			
		end
		
		extensionsSizes.x[extensions[i].drawNum] = x
		extensionsSizes.y[extensions[i].drawNum] = y
		extensionsSizes.x2[extensions[i].drawNum] = x2
		extensionsSizes.y2[extensions[i].drawNum] = y2

	end

end