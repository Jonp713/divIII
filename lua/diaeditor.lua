diaeditor = {}
diaeditor.text = ""
diaeditor.up = false
diaeditor.check = 0
diaeditor.selected = 1
diaeditor.rowlength = 65
diaeditor.rows = 14
diaeditor.modifier = 0
diaeditor.backcount = 0

function diaeditor:draw()

	if(self.up)then
	
	    love.graphics.setColor(0, 0, 0, 200)
	    love.graphics.rectangle("fill", 0,0, 1280, 400)
	    love.graphics.setColor(0, 0, 0, 255)
		
	    love.graphics.rectangle("fill", 400, 80, 460, 240)
	    love.graphics.setColor(255, 255, 255, 255)
		
	    love.graphics.rectangle("line", 400, 80, 460, 240)
		
	    love.graphics.setColor(255, 255, 255)

		if(self.check > 25)then

		    love.graphics.printf(self.text:sub(1, diaeditor.selected) .. '|' .. self.text:sub(diaeditor.selected + 1, #diaeditor.text), 420, 100, 420)			

		else

		    love.graphics.printf(self.text:sub(1, diaeditor.selected) .. '  ' .. self.text:sub(diaeditor.selected + 1, #diaeditor.text), 420, 100, 420)			

		end
		if(self.check > 50)then
	
			self.check = 0
	
		end

	end

	self.check = self.check + 1


end

function diaeditor:checkKeys()
	
	if(love.keyboard.isDown('right'))then
		
		if(rightpressable)then
			rightpressable = false
		
			if(diaeditor.selected < #diaeditor.text)then
		
				diaeditor.selected = diaeditor.selected + 1
		
			end
		
		end
		
	else
		
		rightpressable = true
		
	end
	if(love.keyboard.isDown('left'))then
		
		if(leftpressable)then
			leftpressable = false
		
			if(diaeditor.selected >= 1)then
		
				diaeditor.selected = diaeditor.selected - 1
		
			end
		
		end
			

	else
		
		leftpressable = true
		
	end
	if(love.keyboard.isDown('up'))then
				
		if((diaeditor.selected - diaeditor.rowlength) >= 1 and uppressable)then
			uppressable = false
			
			diaeditor.selected = diaeditor.selected - diaeditor.rowlength/4
			
			
		elseif(uppressable)then
				
			
			diaeditor.selected = 0	
		end
		
	else
		
		uppressable = true
		
	end
	if(love.keyboard.isDown('down'))then
		
		if((diaeditor.selected + diaeditor.rowlength) <= #diaeditor.text and downpressable)then
			downpressable = false
			
			diaeditor.selected = diaeditor.selected + diaeditor.rowlength/4
			
		elseif(downpressable)then
			
			diaeditor.selected = #diaeditor.text
				
		end
		
				
		
	else
		
		downpressable = true
		
	end
	
	if(love.keyboard.isDown('backspace'))then
		
		diaeditor.backcount = diaeditor.backcount + 1
		
		if(diaeditor.backcount > 5)then
			
			backspacepressable = true
			
		end
		
		if(diaeditor.up and backspacepressable and diaeditor.selected >= 1)then
	
			diaeditor.text =  diaeditor.text:sub(1, diaeditor.selected - 1) .. diaeditor.text:sub(diaeditor.selected + 1, #diaeditor.text)
			diaeditor.selected = diaeditor.selected - 1
	
			backspacepressable = false
			diaeditor.backcount = 0
			
		end
		
	else	
	
		backspacepressable = true
		
		diaeditor.backcount = 0
	
	end

end