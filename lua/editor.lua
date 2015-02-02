maps = {




}

colmaps = {



}

chars = {



}

editor = {

	chosen = {
	
		{
	
			x = 1,
			y = 1,
			bigX = 0,
			bigY = 0,
	
		}	
	
	},
	
	
	day = 0,
	name = {""},
	Print = '',
	timer = 0,
	objectSelect = 1,
	movingObject = false,
	clickTime = 0,
	diedit = false,
	text = '',
	rwasdown = false,
	boxx1 = 0,
	boxx2 = 0,
	boxy1 = 0,
	boxy2 = 0,
	boxxdrag = 0,
	boxydrag = 0,
	readyforclick = true,
	
	hiddenx1 = 0,
	hiddenx2 = 0,
	hiddeny1 = 0,
	hiddeny2 = 0,
	hiddenDrag = false,
	hiddenDragx = 0,
	hiddenDragy = 0,
	
	count = 0,
	
	secretEditing = false,
	diaEditing = false,
}

function editor:loadmap(number)

	chunk = love.filesystem.load( "levels/"..number..".txt" )
	newmap, newcol = chunk()
	
	table.insert(maps, newmap)
	table.insert(colmaps, newcol)

end

function editor:savemap(number)

	strg = "map = {\n" -- starting the string buffer

	for x = 1, #maps[number] do 

		strg = strg .. "\t{ "        -- add to beginning of row the bracket
	
		for y = 1, #maps[number][1] do
	
		  strg = strg .. tostring(maps[number][x][y]) -- add the map value to string 
	
			if y < #maps[number][1] then
		
				strg = strg .. ", " 
			
			end -- add comma unless it's the last value of map row
	
		end
	  
		strg = strg .. " },\n" -- end of map row bracket
	
	end
		
	strg = strg .. " \n}" -- end of map table bracket
	
	strg = strg .. "\n\ncolmap = {\n" -- starting the string buffer

	for x = 1, #colmaps[number] do 

		strg = strg .. "\t{ "        -- add to beginning of row the bracket
	
		for y = 1, #colmaps[number][1] do
	
		  strg = strg .. tostring(colmaps[number][x][y]) -- add the map value to string 
	
			if y < #colmaps[number][1] then
		
				strg = strg .. ", " 
			
			end -- add comma unless it's the last value of map row
	
		end
	  
		strg = strg .. " },\n" -- end of map row bracket
	
	end
		
	strg = strg .. " \n}" -- end of map table bracket
		
	strg = strg ..'\n\nreturn map, colmap'
	
	local f,err = io.open("/Users/Bah-Ru-Daga/Desktop/Game/levels/"..number..".txt","w")
	if not f then return print(err) end
	f:write(strg)
	f:close()

end


function editor:saveEvent(number)

	strg = "tree = {\n\n" -- starting the string buffer

	for i = 1, #chars[number].events do -- find how many events there are in this tree

		strg = strg .. "\t{\n "        -- add to beginning of row the bracket
		
		strg = strg .. '\t\tnumber = '.. i .. ",\n"
	
		strg = strg .. '\t\tstartSec = '.. chars[number].events[i].startSec .. ",\n"
		
		strg = strg .. '\t\tendSec = '.. chars[number].events[i].endSec .. ",\n"
		
		if(chars[number].events[i].repeatdo)then
		
			strg = strg .. '\t\trepeatdo = true,\n'
		
		else
		
			strg = strg .. '\t\trepeatdo = false,\n'

		end
		
		strg = strg .. '\n\n\t\tsequence = {\n'
		
		for j = 1, #chars[number].events[i].sequence do -- find how many movements are in this event
			
				strg = strg .. "\t\t\t{"
			
				strg = strg .. "x = "..chars[number].events[i].sequence[j].x..", y = "..chars[number].events[i].sequence[j].y..", speed = "..chars[number].events[i].sequence[j].speed
				
				if(chars[number].events[i].sequence[j].door)then
		
					strg = strg ..", door = true"---..chars[number].events[i].sequence[j].door

		
				else
		
					strg = strg ..", door = false"---..chars[number].events[i].sequence[j].door

				end
				
				--[[
				
				
				strg = strg ..", time = ..chars[number].events[i].sequence[j].door
				
				
				]]
								
				strg = strg ..", time = 0"---..chars[number].events[i].sequence[j].door
		
				
				strg = strg ..  "},\n"
	
		end
		
		strg = strg .. "\t\t}\n" -- end of sequence bracket

		strg = strg .. "\t},\n" -- end of event bracket
	
	end
		
	strg = strg .. " \n}" -- end of table bracket
	
	strg = strg ..'\n\nreturn tree'

	local f,err = io.open("/Users/Bah-Ru-Daga/Desktop/Game/movements/"..number..".txt","w")
	if not f then return print(err) end
	f:write(strg)
	f:close()

end


function editor:loadEvent(number)

	chunk = love.filesystem.load( "movements/"..number..".txt" )
	newvent = chunk()
		
	for i = 1, #newvent do
	
		chars[number]:newEvent(newvent[i].startSec, newvent[i].endSec, newvent[i].sequence, newvent[i].repeatdo)
	
	end
	
end


function editor:saveDialogue(number)

	strg = "tree = {\n\n" -- starting the string buffer

	for i = 1, #chars[number].dialogues do -- find how many events there are in this tree

		strg = strg .. "\t{\n "        -- add to beginning of row the bracket
		
		strg = strg .. '\t\tnumber = '.. i .. ",\n"
	
		strg = strg .. '\t\tstartSec = '.. chars[number].dialogues[i].startSec .. ",\n"
		
		strg = strg .. '\t\tendSec = '.. chars[number].dialogues[i].endSec .. ",\n"
		
		strg = strg .. '\t\tisSecret = '.. chars[number].dialogues[i].secretType .. ",\n"		
		
		strg = strg .. '\t\thiddenx1 = '.. chars[number].dialogues[i].hiddenx1 .. ",\n"		
		strg = strg .. '\t\thiddenx2 = '.. chars[number].dialogues[i].hiddenx2 .. ",\n"		
		strg = strg .. '\t\thiddeny1 = '.. chars[number].dialogues[i].hiddeny1 .. ",\n"		
		strg = strg .. '\t\thiddeny2 = '.. chars[number].dialogues[i].hiddeny2 .. ",\n"	
		
		strg = strg .. '\n\n\t\tsecretSeq = {\n'
		
		--talking that happens if secrecy is interupted
		for j = 1, #chars[number].dialogues[i].secretSeq do -- find how many dialogues are in this event
			
				strg = strg .. "\t\t\t{"
			
				strg = strg .. 'words = "'..chars[number].dialogues[i].secretSeq[j].words..'", time = '..chars[number].dialogues[i].secretSeq[j].time
				
				strg = strg ..  "},\n"
	
		end
		strg = strg .. "\t\t},\n" -- end of secretsequence bracket
		

		if(chars[number].dialogues[i].repeatdo)then
		
			strg = strg .. '\t\trepeatdo = true,\n'
		
		else
		
			strg = strg .. '\t\trepeatdo = false,\n'

		end

		strg = strg .. '\n\n\t\tsequence = {\n'
		
		for j = 1, #chars[number].dialogues[i].sequence do -- find how many movements are in this event
			
			strg = strg .. "\t\t\t{"
		
			strg = strg .. 'words = "'..chars[number].dialogues[i].sequence[j].words..'", time = '..chars[number].dialogues[i].sequence[j].time
			
			strg = strg ..  "},\n"
	
		end
		
		strg = strg .. "\t\t}\n" -- end of sequence bracket

		strg = strg .. "\t},\n" -- end of event bracket
	
	end
		
	strg = strg .. " \n}" -- end of table bracket
	
	strg = strg ..'\n\nreturn tree'

	local f,err = io.open("/Users/Bah-Ru-Daga/Desktop/Game/dialogues/"..number..".txt","w")
	if not f then return print(err) end
	f:write(strg)
	f:close()

end

function editor:loadDialogue(number)

	chunk = love.filesystem.load( "dialogues/"..number..".txt" )
	newvent = chunk()
		
	for i = 1, #newvent do
	
		chars[number]:newDialogue(newvent[i].startSec, newvent[i].endSec, newvent[i].sequence, newvent[i].repeatdo, newvent[i].isSecret, newvent[i].secretSeq, {newvent[i].hiddenx1, newvent[i].hiddenx2, newvent[i].hiddeny1, newvent[i].hiddeny2})
	
	end
	
end


function editor:saveObjects(number)

	strg = "objectslist = {\n\n" -- starting the string buffer

	for i = 1, #objects do -- find how many events there are in this tree

		strg = strg .. "\t{\n "        -- add to beginning of row the bracket
		
		strg = strg .. '\t\tnumber = '.. i .. ",\n"
	
		strg = strg .. '\t\tx = '.. objects[i].x .. ",\n"
		
		strg = strg .. '\t\ty = '.. objects[i].y .. ",\n"
		
		strg = strg .. '\t\timg = '.. objects[i].img .. ",\n"
		
		strg = strg .. "\t},\n" -- end of object bracket
	
	end
		
	strg = strg .. " \n}" -- end of table bracket
	
	strg = strg ..'\n\nreturn objectslist'

	local f,err = io.open("/Users/Bah-Ru-Daga/Desktop/Game/objects/objects.txt","w")
	if not f then return print(err) end
	f:write(strg)
	f:close()

end

function editor:loadObjects()

	chunk = love.filesystem.load( "objects/objects.txt" )
	objecks = chunk()
		
	for i = 1, #objecks do
	
		objects:new(objecks[i].x, objecks[i].y, objecks[i].img)
	
	end
	
end

function editor:checkKeys(dt)

	--save
	if love.keyboard.isDown('/') and diaeditor.up == false then
		
		for i = 1, mapCount do
	
			self:savemap(i)
	
	
		end
		
		for i = 1, charCount do
			
			self:saveEvent(i)
			self:saveDialogue(i)
			
		end
		
		self.saveObjects()
					
		self.Print = 'Files Saved!'
		  

	end	
	--change object img down
	if(love.keyboard.isDown('z') and self.objectSelect > 0 and diaeditor.up == false)then

		if(zpressable and objects[self.objectSelect].img > 1)then
			zpressable = false
			
			if(love.keyboard.isDown('rshift') and objects[self.objectSelect].img > 5)then
				
				self.Print = 'ObjectSelect IMG - 5'
			  
				
				objects[self.objectSelect].img = objects[self.objectSelect].img - 5
				
			else
			
				self.Print = 'ObjectSelect IMG -'
			  
				
				objects[self.objectSelect].img = objects[self.objectSelect].img - 1
			
			end
		
			
		end
		
	end
	--change object IMG up
	if(love.keyboard.isDown('x') and self.objectSelect > 0 and diaeditor.up == false)then	  

		if(xpressable and objects[self.objectSelect].img < #images)then
			xpressable = false
			
			if(love.keyboard.isDown('lshift') and objects[self.objectSelect].img < #images - 5)then

				self.Print = 'ObjectSelect IMG + 5'
			
			
				objects[self.objectSelect].img = objects[self.objectSelect].img + 5
			
			else
				
				self.Print = 'ObjectSelect IMG +'
			
			
				objects[self.objectSelect].img = objects[self.objectSelect].img + 1
			
			end
		
			
		end
		
	end
	--create object
	if(love.keyboard.isDown('c') and diaeditor.up == false)then
		
		self.Print = 'Object Created'
		  

		if(cpressable)then
			cpressable = false

			x, y = camera:getPos()
			
			objects:new(x,y, 1)
			
			
		end
		
	end
	--delete object
	if(love.keyboard.isDown('v') and diaeditor.up == false)then

		if(vpressable)then
			vpressable = false
			
			self.Print = 'ObjectSelect Deleted'
			  
			
			table.remove(objects, self.objectSelect)
			self.objectSelect = #objects

		end
		
	end
	--change graphic up
	if(love.keyboard.isDown('q') and diaeditor.up == false)then
		
		if(love.keyboard.isDown('lshift'))then
			
			if(qpressable)then
				qpressable = false

				for i = 1, #sections do
			
					for j = 1, #self.chosen do

						if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
							sections[i].grid[self.chosen[j].y][self.chosen[j].x] = sections[i].grid[self.chosen[j].y][self.chosen[j].x] + 5
					
							self.Print = 'Graphic +++'
							  
					
						end
				
					end
				end
			
			end
		
		else

			if(qpressable)then
				qpressable = false

				for i = 1, #sections do
			
					for j = 1, #self.chosen do

						if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
							sections[i].grid[self.chosen[j].y][self.chosen[j].x] = sections[i].grid[self.chosen[j].y][self.chosen[j].x] + 1
					
							self.Print = 'Graphic +'
							  
					
						end
				
					end
				end
			
			end
		
		end
	end
	
	--change graphic down
	if(love.keyboard.isDown('w') and diaeditor.up == false)then
		
		if(love.keyboard.isDown('lshift'))then
		
			if(wpressable)then
				wpressable = false

				for i = 1, #sections do
			
					for j = 1, #self.chosen do

						if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
							sections[i].grid[self.chosen[j].y][self.chosen[j].x] = sections[i].grid[self.chosen[j].y][self.chosen[j].x] - 5
					
							self.Print = 'Graphic ---'
							  
					
						end
				
					end
				end
			
			end
		
		else

			if(wpressable)then
				wpressable = false

				for i = 1, #sections do
			
					for j = 1, #self.chosen do

						if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
							sections[i].grid[self.chosen[j].y][self.chosen[j].x] = sections[i].grid[self.chosen[j].y][self.chosen[j].x] - 1
					
							self.Print = 'Graphic -'
							  
					
						end
				
					end
				end
			
			end
		
		end	
	end
	
	
	--change graphic to 0
	if(love.keyboard.isDown('e') and diaeditor.up == false)then
				
		if(epressable)then
			wpressable = false

			for i = 1, #sections do
		
				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
				
						sections[i].grid[self.chosen[j].y][self.chosen[j].x] = 0
				
						self.Print = 'Graphic = 0'		  
				
					end
			
				end
			end
		
		end
		
	end
	--solid collision
	if(love.keyboard.isDown('a') and diaeditor.up == false)then

		if(apressable)then
			apressable = false

			for i = 1, #sections do
			
				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
						self.Print = 'Collision - Solid'
						  
					
						sections[i].col[self.chosen[j].y][self.chosen[j].x] = 1
					
					
					end
				
				end
			end
			
		end
	end
	--strange collision
	if(love.keyboard.isDown('s') and diaeditor.up == false)then

		if(spressable)then
			spressable = false

			for i = 1, #sections do
			
				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
						
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 7)then
							
							self.Print = 'Collision - sloped down'
							  
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 8
							
						end
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 6)then
							
							self.Print = 'Collision - sloped up'
							  
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 7
							
						end
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 5)then
							
							self.Print = 'Collision - left side + standable'
							  
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 6
							
						end
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 4)then
							
							self.Print = 'Collision - right side + standable'
							  
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 5
							
						end
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 3)then
							
							self.Print = 'Collision - left side'
							  
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 4
							
						end
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 2)then
							
							self.Print = 'Collision - right side'
							  
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 3
							
						end
						
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] < 2)then
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 2
							self.Print = 'Collision - Standable'
							  
						
						end
					
					end
				
				end
			end
			
		end
	end
	--hollow collision
	if(love.keyboard.isDown('d') and diaeditor.up == false)then

		if(dpressable)then
			dpressable = false

			for i = 1, #sections do

				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
						self.Print = 'Collision - Hollow'
						  
					
						sections[i].col[self.chosen[j].y][self.chosen[j].x] = 0
					
					end
				
				end
				
			end
			
		end
	end
	--time/day forward
	if(love.keyboard.isDown('.') and diaeditor.up == false)then
		if(love.keyboard.isDown('lshift') and periodpressable)then
			
			if(periodpressable and self.day < dayCount)then
			
				self.Print = 'Day >'
				  
			
				self.day = self.day + 1
				modifier = dayLength * 60 * self.day
				time()
				chars:set(1)
			
				periodpressable = false
			
			end
			
		else
			
			if(love.keyboard.isDown('rshift'))then
		
				self.Print = 'Time >>>'
				  
		
				modifier = modifier + (dt * 15)
				forward = true
			
				alldt = alldt * 15
				fast = true

			elseif(periodpressable)then
				self.Print = 'Time >'
				  
		
				modifier = modifier + (dt * 2)
				forward = true
				fast = false
			
				alldt = alldt * 2

			end
			
		end
		
	end
	--time/day backwards
	if(love.keyboard.isDown(',') and diaeditor.up == false)then
	
		if(love.keyboard.isDown('lshift'))then
			
			if(commapressable and self.day > 1)then
				
				self.Print = 'Day <'
				  
		
				self.day = self.day - 1
				modifier = dayLength * 60 * self.day
				time()
				chars:set(1)
			
				commapressable = false
					
			elseif(commapressable and self.day == 1)then
				
				self.Print = 'Day <'
				  
		
				self.day = self.day - 1
				modifier = dayLength * 60 * self.day
				time()
				chars:set(2)
			
				commapressable = false
				
			end
		else
			
			if(love.keyboard.isDown('rshift'))then
			
				self.Print = 'Time <<<'
				  
				fast = true
			
				modifier = modifier - (dt * 15)
				backward = true
			
				alldt = alldt * 15

			else
				self.Print = 'Time <'
				  
		
				modifier = modifier - (dt * 2)
				backward = true
				fast = false
			
				alldt = alldt * 2
		
			end
		end
	
	end
	-- char select up
	if(love.keyboard.isDown('p') and diaeditor.up == false)then
		
		if(love.keyboard.isDown('rshift'))then
			
			for i = 1, #chars do
		
				if(chars[i].selected and chars[i+5])then
			
					if(ppressable)then
				
						self.Print = 'Char Selected Up + 5'
						  
					
						chars[i].selected = false
						chars[i+5].selected = true
				
						ppressable = false

					end
				
				end
		
			end
			
		else
		
			for i = 1, #chars do
		
				if(chars[i].selected and chars[i+1])then
			
					if(ppressable)then
				
						self.Print = 'Char Selected Up'
						  
					
						chars[i].selected = false
						chars[i+1].selected = true
				
						ppressable = false

					end
				
				end
		
			end
			
		end
	
	end
	--character select down
	if(love.keyboard.isDown('o') and opressable and diaeditor.up == false)then
		
		if(love.keyboard.isDown('rshift'))then
			
			opressable = false
		
			for i = 1, #chars do
		
				if(chars[i].selected and chars[i-5])then
				
					self.Print = 'Char Selected Down - 5'
					  
						
					chars[i].selected = false
					chars[i-5].selected = true
				
				end
		
			end
			
		else
		
			opressable = false
		
			for i = 1, #chars do
		
				if(chars[i].selected and chars[i-1])then
				
					self.Print = 'Char Selected Down'
					  
						
					chars[i].selected = false
					chars[i-1].selected = true
				
				end
		
			end
		
		end
	
	end
		
	--create point
	if(love.keyboard.isDown('m') and mpressable and diaeditor.up == false)then
		mpressable = false
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
		
				for j = 1, #chars[i].events do
				
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
					
						self.Print = 'Added Point'
						  
						
						x,y = camera:getPos()
						
						chars[i].events[j]:addPoint(x,y, 50, 0)
					
					end
				
				end
				
			end
		
		end
	
	end
	
	--create Event
	if(love.keyboard.isDown('n') and npressable and diaeditor.up == false)then
		npressable = false
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
			
				for j = 1, #chars[i].events do
				
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
					
						dontDo = true
					
					end
				
				end
	
				if(dontDo)then
				
					self.Print = "Already an Event"
					   
				
				else
							
					self.Print = 'Created Event'
					  
			
					xIn,yIn = camera:getPos()
				
					sequence = {
					
						{x = xIn, y = yIn, speed = 50, time = 0}
				
					}

					chars[i]:newEvent(currentSec, 9999999, sequence, false)
				
				end
				
				dontDo = false
				
			end
		
		end
	
	end
	
	--start drag hidden values for dialogue
	if(love.keyboard.isDown('1') and onepressable and diaeditor.up == false and editor.hiddenDrag == false)then
		onepressable = false
		editor.hiddenDrag = true
				
		for i = 1, #chars do
			
			if(chars[i].selected)then
								
				for j = 1, #chars[i].dialogues do
				
					if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
						
						x,y = camera:getPos()
						
						if(chars[i].dialogues[j].secretType == 3 or chars[i].dialogues[j].secretType == 4)then
							
							chars[i].dialogues[j].hiddenx1 = x - chars[i].x
							chars[i].dialogues[j].hiddeny1 = y - chars[i].y
							
						else
						
							chars[i].dialogues[j].hiddenx1 = x
							chars[i].dialogues[j].hiddeny1 = y 
						
						end
						
						editor.hiddenx1 = x
						editor.hiddeny1 = y	

					end
				
				end
				
			end
		
		end
	
	end
	
	--drag hidden values for dialogues
	if(love.keyboard.isDown('1') and editor.hiddenDrag)then
		
		x,y = camera:getPos()
		
		editor.hiddenDragx = x
		editor.hiddenDragy = y	
		
	end
	
	--end drag create hidden values for dialogues
	if(love.keyboard.isDown('1') == false and editor.hiddenDrag)then
		onepressable = true
		editor.hiddenDrag = false
		
		x,y = camera:getPos()
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
								
				for j = 1, #chars[i].dialogues do
				
					if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
						
						x,y = camera:getPos()
						
						if(chars[i].dialogues[j].secretType == 3 or chars[i].dialogues[j].secretType == 4)then
							
							chars[i].dialogues[j].hiddenx2 = x - chars[i].x
							chars[i].dialogues[j].hiddeny2 = y - chars[i].y
							
						else
						
							chars[i].dialogues[j].hiddenx2 = x
							chars[i].dialogues[j].hiddeny2 = y			
						end
						
							--swaps values to make top corner the smaller one.... for x
							if(chars[i].dialogues[j].hiddenx2 > chars[i].dialogues[j].hiddenx1)then
						
						
							else
							
								hiddenx2temp = chars[i].dialogues[j].hiddenx1
								chars[i].dialogues[j].hiddenx2 = chars[i].dialogues[j].hiddenx1
								chars[i].dialogues[j].hiddenx1 = hiddenx2temp
							
							end
						
							--swaps values to make top corner the smaller one.... for y
							if(chars[i].dialogues[j].hiddeny2 > chars[i].dialogues[j].hiddeny1)then
						
						
							else
							
							
								hiddeny2temp = chars[i].dialogues[j].hiddeny1
								chars[i].dialogues[j].hiddeny2 = chars[i].dialogues[j].hiddeny1
								chars[i].dialogues[j].hiddeny1 = hiddeny2temp
							
							
							end
														
						editor.hiddenx2 = x
						editor.hiddeny2 = y	
						
					end
				
				
				end
				
			end
		
		end
				
	end
	
	--drag hidden values for dialogues
	if(love.keyboard.isDown('2'))then
		
		if(twopressable)then
			twopressable = false
			done = false
		
			for i = 1, #chars do
			
				if(chars[i].selected)then
								
					for j = 1, #chars[i].dialogues do
				
						if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
							
							if(chars[i].dialogues[j].secretType == 2 )then
							
								self.Print = 'Dialogue - Secret - Moving - Not Safe Here'
						
								chars[i].dialogues[j].secretType = 3
														
								break;
							
							
							end
						
						
							if(chars[i].dialogues[j].secretType == 1 )then
							
								self.Print = 'Dialogue - Secret - Not Safe Here'
						
								chars[i].dialogues[j].secretType = 2
								chars[i].dialogues[j].safe = true
														
								break;
							
							
							end
							if(chars[i].dialogues[j].secretType == 0)then
							
								self.Print = 'Dialogue - Secret - Safe Here'
						
								chars[i].dialogues[j].secretType = 1
								chars[i].dialogues[j].safe = true
	
								break;
						
							end
							if(chars[i].dialogues[j].secretType == 3)then
							
								self.Print = 'Dialogue - Secret - Moving - Safe Here'
						
								chars[i].dialogues[j].secretType = 4
								chars[i].dialogues[j].safe = true
														
								break;
							
							end
							if(chars[i].dialogues[j].secretType == 4)then
							
								self.Print = 'Dialogue - Not Secret'
						
								chars[i].dialogues[j].secretType = 0
								chars[i].dialogues[j].safe = true
								
														
								break;
							
							end
						
						end
					
					end
				
				end
			
			end
			
		end

	else
	
		twopressable = true
		
	end
	
	
	--create dialogue
	if(love.keyboard.isDown('b') and bpressable and diaeditor.up == false)then
		bpressable = false
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
			
				for j = 1, #chars[i].dialogues do
				
					if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
					
						dontDo = true
					
					end
				
				end
	
				if(dontDo)then
				
					self.Print = "Already a Dialogue"
					   
				
				else
	
					self.Print = "Created Dialogue"
					   
		
					sequence = {
			
						{words = "words", time = 3}
		
					}
					
					secretSeq = {
			
						{words = "words", time = 3}
		
					}

					chars[i]:newDialogue(currentSec, 9999999, sequence, false, 0, secretSeq, {0,0,0,0})
					
					chars[i].dialogues[#chars[i].dialogues]:chop(chars[i].dialogues[#chars[i].dialogues].sequence[1].words, 1, 1)
														
				end
				
				dontDo = false
				
			end
		
		end
	
	end
	
	--delete dialogue
	if(love.keyboard.isDown('j') and jpressable and diaeditor.up == false)then
		jpressable = false
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
								
				for j = 1, #chars[i].dialogues do
				
					if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
						
						self.Print = "Deleted Dialogue!"
						  
						
						table.remove(chars[i].dialogues, j)
						
						break;				
						

					end
				
				
				end
				
			end
		
		end
	
	end
	
	--delete event
	if(love.keyboard.isDown('k') and kpressable and diaeditor.up == false)then
		kpressable = false
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
								
				for j = 1, #chars[i].events do
				
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
					
						self.Print = "Deleted Event!"
						  
					
					
						table.remove(chars[i].events, j)		
						
						break;				
						 			
					end
				
				
				end
				
			end
		
		end
	
	end
	
	--delete point
	if(love.keyboard.isDown('l') and lpressable and diaeditor.up == false)then
		lpressable = false
		
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
								
				for j = 1, #chars[i].events do
				
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
				
						for l = 1, #chars[i].events[j].sequence do
					
							if(l == #chars[i].events[j].sequence)then
							
								self.Print = "Deleted Point!"
								  
														
								table.remove(chars[i].events[j].sequence, l)
								
								break;					
							
							end
						
						end

					end
				
				
				end
				
			end
		
		end
	
	end
	--edit selected dialoge time up
	if(love.keyboard.isDown('up') and uppressable and diaeditor.up)then
		uppressable = false
		
		
		if(diaeditor.up)then
						
			for i = 1, #chars do
			
				if(chars[i].selected)then
								
					for j = 1, #chars[i].dialogues do
										
						if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
							
							chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].time = chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].time + 1
							
							editor.Print = 'Dialogue +Time = '..chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].time
							
						end
				
					end
				
				end
		
			end
			
		end
	
	end
	--edit selected dialogue time down
	if(love.keyboard.isDown('down') and downpressable and diaeditor.up)then
		downpressable = false
		
		
		if(diaeditor.up)then
						
			for i = 1, #chars do
			
				if(chars[i].selected)then
								
					for j = 1, #chars[i].dialogues do
										
						if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
							
							chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].time = chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].time - 1
							
							editor.Print = 'Dialogue -Time = '..chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].time
							
						end
				
					end
				
				end
		
			end
			
		end
	
	end
	
	--add word point to dialogue
	if(love.keyboard.isDown('=') and diaeditor.up)then
		
		if(diaeditor.up and equalpressable)then
			
			equalpressable = false
						
			for i = 1, #chars do
			
				if(chars[i].selected)then
								
					for j = 1, #chars[i].dialogues do
										
						if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
							
							self.Print = "Dialogue - Added point"
							
							newdia = {words = 'words', time = 3}
							
							table.insert(chars[i].dialogues[j].sequence, newdia)
							
						end
						
					end
					
				end
				
			end
			
		end
	end
	
	--edit selected dialogue
	if(love.keyboard.isDown(';') and love.keyboard.isDown('rshift') == false and colonpressable and editor.secretEditing == false)then
		colonpressable = false
		
		if(diaeditor.up)then
						
			for i = 1, #chars do
			
				if(chars[i].selected)then
								
					for j = 1, #chars[i].dialogues do
										
						if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
							
							diaeditor.up = false
							player.lock = false
							editor.diaEditing = false
							
							chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].words = diaeditor.text
														
							chars[i].dialogues[j]:chop(chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].words, chars[i].dialogues[j].state, 2)
													
						end
				
					end
				
				end
		
			end
			
		elseif(editor.secretEditing == false)then
		
			for i = 1, #chars do
			
				if(chars[i].selected)then
								
					for j = 1, #chars[i].dialogues do
										
						if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
							
							diaeditor.up = true
							player.lock = true
							editor.diaEditing = true
							
							
							diaeditor.text = chars[i].dialogues[j].sequence[chars[i].dialogues[j].state].words
							
							

						end
				
					end
				
				end
		
			end
			
		end
	
	end


	--edit selected SECRETdialogue
	if(love.keyboard.isDown(';') and love.keyboard.isDown('rshift') and colonpressable and editor.diaEditing == false)then
		colonpressable = false
		
		
		if(diaeditor.up)then
						
			for i = 1, #chars do
			
				if(chars[i].selected)then
								
					for j = 1, #chars[i].dialogues do
										
						if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
							
							diaeditor.up = false
							player.lock = false
							editor.secretEditing = false
							
							chars[i].dialogues[j].secretSeq[1].words = diaeditor.text
							
						end
				
					end
				
				end
		
			end
			
		elseif(editor.diaEditing == false)then
		
			for i = 1, #chars do
			
				if(chars[i].selected)then
								
					for j = 1, #chars[i].dialogues do
										
						if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
							
							diaeditor.up = true
							player.lock = true
							editor.secretEditing = true
							
							diaeditor.text = chars[i].dialogues[j].secretSeq[1].words
							
							toprint5 = 'here'

						end
				
					end
				
				end
		
			end
			
		end
	
	end
	
	--toggle door for events
	if(love.keyboard.isDown('3') and threepressable)then
		threepressable = false

		for i = 1, #chars do
				
			if(chars[i].selected)then
							
				for j = 1, #chars[i].events do
								
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
														
						if(chars[i].events[j].sequence[chars[i].events[j].state].door == false)then
						
							editor.Print = "Event - door = true"
				
							chars[i].events[j].sequence[chars[i].events[j].state].door = true
						else
						
							editor.Print = "Event - door = false"
						
							chars[i].events[j].sequence[chars[i].events[j].state].door = false


						end
					end
			
				end
			
			end
	
		end

	end
	
	--toggle repeat for events
	if(love.keyboard.isDown('4') and fourpressable)then
		fourpressable = false

		for i = 1, #chars do
				
			if(chars[i].selected)then
							
				for j = 1, #chars[i].events do
								
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
														
						if(chars[i].events[j].repeatdo == true)then
						
							editor.Print = "Event - repeat = false"
				
							chars[i].events[j].repeatdo = false							
							
						else
							
							editor.Print = "Event - repeat = true"
				
							chars[i].events[j].repeatdo = true						

						end
					end
			
				end
			
			end
	
		end

	end
	
	--lower timed event by one
	if(love.keyboard.isDown('-') and love.keyboard.isDown('rshift') and dashpressable)then
		dashpressable = false

		for i = 1, #chars do
				
			if(chars[i].selected)then
							
				for j = 1, #chars[i].events do
								
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then				
						
						chars[i].events[j].endTime = chars[i].events[j].endTime - 1
								
						
						chars[i].events[j].sequence[chars[i].events[j].state].time = chars[i].events[j].sequence[chars[i].events[j].state].time - 1													
																				
						editor.Print = "Event - time = "..chars[i].events[j].sequence[chars[i].events[j].state].time
					
					end
			
				end
			
			end
	
		end

	end
	
	--raise timed event by one
	if(love.keyboard.isDown('=') and love.keyboard.isDown('rshift') and equalpressable)then
		equalpressable = false

		for i = 1, #chars do
				
			if(chars[i].selected)then
							
				for j = 1, #chars[i].events do
								
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
						
						if(chars[i].events[j].sequence[chars[i].events[j].state].time == 0)then
						
							chars[i].events[j].startTime = math.floor((love.timer.getTime() - gamestartSec) + modifier)
							
							chars[i].events[j].workTime = chars[i].events[j].startTime
			
							chars[i].events[j].endTime = chars[i].events[j].startTime + 1

						else
							chars[i].events[j].endTime = chars[i].events[j].endTime + 1
							 
						end
						
						chars[i].events[j].sequence[chars[i].events[j].state].time = chars[i].events[j].sequence[chars[i].events[j].state].time + 1
																				
						editor.Print = "Event - time = "..chars[i].events[j].sequence[chars[i].events[j].state].time
					
					end
			
				end
			
			end
	
		end

	end
	
	
	--lower event point speed
	if(love.keyboard.isDown('-') and dashpressable)then
		dashpressable = false

		for i = 1, #chars do
				
			if(chars[i].selected)then
							
				for j = 1, #chars[i].events do
								
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
						
						chars[i].events[j].sequence[chars[i].events[j].state].speed = chars[i].events[j].sequence[chars[i].events[j].state].speed - 1
																				
						editor.Print = "Event - speed = "..chars[i].events[j].sequence[chars[i].events[j].state].speed
					
					end
			
				end
			
			end
	
		end

	end
	
	--raise event point speed
	if(love.keyboard.isDown('=') and equalpressable)then
		equalpressable = false

		for i = 1, #chars do
				
			if(chars[i].selected)then
							
				for j = 1, #chars[i].events do
								
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
						
						chars[i].events[j].sequence[chars[i].events[j].state].speed = chars[i].events[j].sequence[chars[i].events[j].state].speed + 1
																				
						editor.Print = "Event - speed = "..chars[i].events[j].sequence[chars[i].events[j].state].speed
					
					end
			
				end
			
			end
	
		end

	end
	
	
	if(love.keyboard.isDown('0'))then
		
		
		objects[editor.objectSelect].x = xIn
		objects[editor.objectSelect].y = yIn
		
		
		
	end
	

	

	
end


function editor:selecting()

	if( love.mouse.isDown( 'l' ) ) then

		x,y = camera:getPos()
		
		--for drawing the box when dragging
		if(editor.rwasdown == true and love.keyboard.isDown('rshift'))then
			
			editor.boxxdrag = x
			editor.boxydrag = y
			
		end
		
		--Start box draw drag
		if(love.keyboard.isDown('rshift') and editor.rwasdown == false)then
		
			editor.rwasdown = true
			editor.boxx1 = x
			editor.boxy1 = y			
			editor.readyforclick = false
		
		--Mutiple select
		elseif(love.keyboard.isDown('lshift'))then
		
			for i = 1, #sections do
	
				continue = true
	
				nada, xOut, yOut, bigXout, bigYout, nameOut = sections[i]:getSection(x,y)
		
				for j = 1, #self.chosen do

					if ((bigXout == self.chosen[j].bigX) and (bigYout == self.chosen[j].bigY))then
										

						if ((xOut == self.chosen[j].x) and (yOut == self.chosen[j].y))then
				
							continue = false

						end
							
					end

				end
					
				if(continue)then
	
					table.insert(editor.chosen, {x = xOut, y = yOut, bigX = bigXout, bigY = bigYout, name = nameOut})

				end
			
			end

		--single select
		elseif(editor.rwasdown == false and editor.readyforclick)then
		
			for j = 1, #editor.chosen do
	
				table.remove(editor.chosen)
							
			end
		
			for i = 1, #sections do
		
				nada, xOut, yOut, bigXout, bigYout, nameOut = sections[i]:getSection(x,y)
		
				table.insert(editor.chosen, {x = xOut, y = yOut, bigX = bigXout, bigY = bigYout, name = nameOut})
			
			end
		
		end
		
		--end drag select
		if(love.keyboard.isDown('rshift') == false and editor.rwasdown)then

			editor.rwasdown = false
			editor.readyforclick = false
		
			editor.boxx2 = x
			editor.boxy2 = y
			
			if(editor.boxx2 > editor.boxx1)then
				
				xrate = 39
				
			else
				
				xrate = -39
				
			end
			if(editor.boxy2 > editor.boxy1)then
				
				yrate = 39
				
			else
				
				yrate = -39
				
			end
		
			for xloop = editor.boxx1, editor.boxx2, xrate do
				for yloop = editor.boxy1, editor.boxy2, yrate do
			
					for i = 1, #sections do
				
						continue = true

						nada, xOut, yOut, bigXout, bigYout, nameOut = sections[i]:getSection(xloop,yloop)
	
						for j = 1, #self.chosen do

							if ((bigXout == self.chosen[j].bigX) and (bigYout == self.chosen[j].bigY))then
									

								if ((xOut == self.chosen[j].x) and (yOut == self.chosen[j].y))then
			
									continue = false

								end
							end

						end
				
						if(continue)then

							table.insert(editor.chosen, {x = xOut, y = yOut, bigX = bigXout, bigY = bigYout, name = nameOut})

						end
				
					end
				
				end
		
			end
		
		end
		
	end
	
	--make sure that it dont go back to single click after you just dragged
	if(love.keyboard.isDown('rshift') == false and love.mouse.isDown('l') == false )then

		editor.readyforclick = true

	end
	
	--move objects
	if( love.mouse.isDown( 'r' ) ) then

		x,y = camera:getPos()
		
		objects:checkClick(x,y)
		
	else
		editor.clickTime = 0
		
		
	end
	
end