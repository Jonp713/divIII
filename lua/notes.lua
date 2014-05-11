notes = {}
notes.text = ""
notes.up = false
notes.check = 0
notes.selected = 1
notes.rowlength = 65
notes.rows = 14
notes.modifier = 0
notes.backcount = 0
notes.leftcount = 0
notes.rightcount = 0

function notes:draw()

	if(self.up)then
	
	    love.graphics.setColor(0, 0, 0, 200)
	    love.graphics.rectangle("fill", 0,0, 1280, 400)
	    love.graphics.setColor(0, 0, 0, 255)
		
	    love.graphics.rectangle("fill", 400, 80, 460, 240)
	    love.graphics.setColor(255, 255, 255, 255)
		
	    love.graphics.rectangle("line", 400, 80, 460, 240)
		
	    love.graphics.setColor(255, 255, 255)

		if(self.check > 25)then

		    love.graphics.printf(self.text:sub(1, notes.selected) .. '|' .. self.text:sub(notes.selected + 1, #notes.text), 420, 100, 420)			

		else

		    love.graphics.printf(self.text:sub(1, notes.selected) .. '  ' .. self.text:sub(notes.selected + 1, #notes.text), 420, 100, 420)			

		end
		if(self.check > 50)then
	
			self.check = 0
	
		end

	end

	self.check = self.check + 1


end

function notes:checkKeys()
	
	if(love.keyboard.isDown('right'))then
		
		notes.rightcount = notes.rightcount + 1
		
		if(notes.rightcount > 5)then
		
			rightpressable = true
		
		end
		
		if(rightpressable)then
			rightpressable = false
		
			if(notes.selected < #notes.text)then
		
				notes.selected = notes.selected + 1
		
			end
		
		end
		
	else
		
		notes.rightcount = 0
		
		
		rightpressable = true
		
	end
	if(love.keyboard.isDown('left'))then
		
		notes.leftcount = notes.leftcount + 1
		
		if(notes.leftcount > 5)then
			
			leftpressable = true
			
		end
		
		if(leftpressable)then
			leftpressable = false
		
			if(notes.selected >= 1)then
		
				notes.selected = notes.selected - 1
		
			end
		
		end
			

	else
		
		notes.leftcount = 0
		
		leftpressable = true
		
	end
	if(love.keyboard.isDown('up'))then
				
		if((notes.selected - notes.rowlength) >= 1 and uppressable)then
			uppressable = false
			
			notes.selected = notes.selected - notes.rowlength/4
			
			
		elseif(uppressable)then
				
			
			notes.selected = 0	
		end
		
	else
		
		uppressable = true
		
	end
	if(love.keyboard.isDown('down'))then
		
		if((notes.selected + notes.rowlength) <= #notes.text and downpressable)then
			downpressable = false
			
			notes.selected = notes.selected + notes.rowlength/4
			
		elseif(downpressable)then
			
			notes.selected = #notes.text
				
		end
		
				
		
	else
		
		downpressable = true
		
	end

	if( love.mouse.isDown( 'l' ) ) then
		
		x, y = love.mouse.getPosition( )
		
		if(x > 0 and x < 20)then
			
			if(y > 0 and y < 20)then
		
				if(notes.up and leftclick)then
	
					notes.up = false
					pause = false
					player.lock = false
					gamestartSec = love.timer.getTime()
		
	
				elseif(leftclick)then
		
					pause = true
					notes.up = true
					player.lock = true
					modifier = modifier + math.floor(love.timer.getTime() - gamestartSec)
	
				end
				
				leftclick = false
				
			end
		end

	else
	
		leftclick = true
	
	end
	
	if(love.keyboard.isDown('return'))then
		
		notes.modifier = notes.rowlength
	
		for line in notes.text:gmatch("\n") do 

			notes.modifier = notes.modifier + notes.rowlength

		end	
		
		if(enterpressable and notes.up and #notes.text + notes.modifier < (notes.rowlength * notes.rows))then

			
		   	notes.text = notes.text:sub(1, notes.selected) .. '\n' .. notes.text:sub(notes.selected + 1, #notes.text)		
	
			notes.selected = notes.selected + 2
		
			enterpressable = false
							
		end
	else
	
		enterpressable = true
	
	
	end
	
	if(love.keyboard.isDown('backspace'))then
		
		notes.backcount = notes.backcount + 1
		
		if(notes.backcount > 5)then
			
			backspacepressable = true
			
		end
		
		if(notes.up and backspacepressable and notes.selected >= 1)then
	
			notes.text =  notes.text:sub(1, notes.selected - 1) .. notes.text:sub(notes.selected + 1, #notes.text)
			notes.selected = notes.selected - 1
	
			backspacepressable = false
			notes.backcount = 0
			
	
		end
		
	else	
	
		backspacepressable = true
		
		notes.backcount = 0
	
	end

end


function notes:save()
	
	strg = 'notesend = "'..notes.text..'"\n\nreturn notesend'
	
	local f,err = io.open("/Users/Bah-Ru-Daga/Desktop/Game/notes.txt","w")
	if not f then return print(err) end
	f:write(strg)
	f:close()
	
	
end

function notes:load()
	
	
	-- need to do this io shit and read from it and save it here instead of the love stuff.
	chunk = love.filesystem.load( "notes.txt" )
	notes.text = chunk()
		
end
