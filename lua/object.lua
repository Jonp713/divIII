objects = {}


function objects:new(xIn, yIn, imgIn)
  o = {
  
  	x = xIn,
	y = yIn,
	img = imgIn,
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(objects, o)
  return o
  
end
 

function objects:draw()
	
	for i = 1, #objects do
	
        love.graphics.draw(images[objects[i].img], objects[i].x, objects[i].y)
		
		if(editor.objectSelect == i)then
	
			love.graphics.setColor(160, 160, 160, 75)
			love.graphics.rectangle("fill", objects[i].x, objects[i].y,  images[objects[i].img]:getWidth(),  images[objects[i].img]:getHeight())
			love.graphics.setColor(255,255,255,255)
		
		end
		
	end
	
end

function objects:checkClick(xIn, yIn)
	
	continue = true	
	
	for i = 1, #objects do
		
		if(editor.clickTime < .01 and collisionCheckPoint(xIn, yIn, 5, objects[i].x, objects[i].y, images[objects[i].img]:getWidth(), images[objects[i].img]:getHeight()))then
			
			editor.objectSelect = i
			editor.Print = 'Object Select = '..i
			continue = false
				
		end
		
	end
	
	if(continue)then
		
		objects[editor.objectSelect].x = xIn
		objects[editor.objectSelect].y = yIn
		
		editor.clickTime = editor.clickTime + alldt
	end
end

