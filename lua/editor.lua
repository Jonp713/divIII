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
	timer = 0

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
			
				strg = strg .. "x = "..chars[number].events[i].sequence[j].x..", y = "..chars[number].events[i].sequence[j].y..", speed = "..chars[number].events[i].sequence[j].speed..", door = false"---..chars[number].events[i].sequence[j].door
				
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
	
		chars[number]:newDialogue(newvent[i].startSec, newvent[i].endSec, newvent[i].sequence, newvent[i].repeatdo, newvent[i].isSecret, newvent[i].secretSeq)
	
	end
	
end

function editor:checkKeys(dt)

	if love.keyboard.isDown('/') then


		for i = 1, mapCount do
	
			self:savemap(i)
	
	
		end
		
		for i = 1, charCount do
			
			self:saveEvent(i)
			self:saveDialogue(i)
			
		end
					
		self.Print = 'Files Saved!'
		self.timer = 5

	end
	
	if(love.keyboard.isDown('q'))then

		if(qpressable)then
			qpressable = false

			for i = 1, #sections do
			
				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
						sections[i].grid[self.chosen[j].y][self.chosen[j].x] = sections[i].grid[self.chosen[j].y][self.chosen[j].x] + 1
					
						self.Print = 'Graphic +'
						self.timer = 5
					
					end
				
				end
			end
			
		end
	end
	
	if(love.keyboard.isDown('w'))then

		if(wpressable)then
			wpressable = false

			for i = 1, #sections do
			
				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
						sections[i].grid[self.chosen[j].y][self.chosen[j].x] = sections[i].grid[self.chosen[j].y][self.chosen[j].x] - 1
					
						self.Print = 'Graphic -'
						self.timer = 5
					
					end
				
				end
			end
			
		end
	end
	
	if(love.keyboard.isDown('a'))then

		if(apressable)then
			apressable = false

			for i = 1, #sections do
			
				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
						self.Print = 'Collision - Solid'
						self.timer = 5
					
						sections[i].col[self.chosen[j].y][self.chosen[j].x] = 1
					
					
					end
				
				end
			end
			
		end
	end
	
	if(love.keyboard.isDown('s'))then

		if(spressable)then
			spressable = false

			for i = 1, #sections do
			
				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 5)then
							
							self.Print = 'Collision - left side + standable'
							self.timer = 5
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 6
							
						end
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 4)then
							
							self.Print = 'Collision - right side + standable'
							self.timer = 5
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 5
							
						end
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 3)then
							
							self.Print = 'Collision - left side'
							self.timer = 5
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 4
							
						end
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] == 2)then
							
							self.Print = 'Collision - right side'
							self.timer = 5
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 3
							
						end
						
						if(sections[i].col[self.chosen[j].y][self.chosen[j].x] < 2)then
						
							sections[i].col[self.chosen[j].y][self.chosen[j].x] = 2
							self.Print = 'Collision - Standable'
							self.timer = 5
						
						end
					
					end
				
				end
			end
			
		end
	end

	if(love.keyboard.isDown('d'))then

		if(dpressable)then
			dpressable = false

			for i = 1, #sections do

				for j = 1, #self.chosen do

					if ((sections[i].xBig == self.chosen[j].bigX) and (sections[i].yBig == self.chosen[j].bigY))then
					
						self.Print = 'Collision - Hollow'
						self.timer = 5
					
						sections[i].col[self.chosen[j].y][self.chosen[j].x] = 0
					
					end
				
				end
				
			end
			
		end
	end
	
	
	
	if(love.keyboard.isDown('.'))then
		if(love.keyboard.isDown('lshift') and periodpressable)then
			
			if(periodpressable and self.day < dayCount)then
			
				self.Print = 'Day >'
				self.timer = 5
			
				self.day = self.day + 1
				modifier = dayLength * 60 * self.day
				time()
				chars:set(1)
			
				periodpressable = false
			
			end
			
		else
			
			if(love.keyboard.isDown('rshift'))then
		
				self.Print = 'Time >>>'
				self.timer = 5
		
				modifier = modifier + (dt * 15)
				forward = true
			
				alldt = alldt * 15
				fast = true

			else
				self.Print = 'Time >'
				self.timer = 5
		
				modifier = modifier + (dt * 2)
				forward = true
				fast = false
			
				alldt = alldt * 2

			end
			
		end
		
	end
	if(love.keyboard.isDown(','))then
	
		if(love.keyboard.isDown('lshift'))then
			
			if(commapressable and self.day > 1)then
				
				self.Print = 'Day <'
				self.timer = 5
		
				self.day = self.day - 1
				modifier = dayLength * 60 * self.day
				time()
				chars:set(1)
			
				commapressable = false
					
			elseif(commapressable and self.day == 1)then
				
				self.Print = 'Day <'
				self.timer = 5
		
				self.day = self.day - 1
				modifier = dayLength * 60 * self.day
				time()
				chars:set(2)
			
				commapressable = false
				
			end
		else
			
			if(love.keyboard.isDown('rshift'))then
			
				self.Print = 'Time <<<'
				self.timer = 5
				fast = true
			
				modifier = modifier - (dt * 15)
				backward = true
			
				alldt = alldt * 15

			else
				self.Print = 'Time <'
				self.timer = 5
		
				modifier = modifier - (dt * 2)
				backward = true
				fast = false
			
				alldt = alldt * 2
		
			end
		end
	
	end
	
	if(love.keyboard.isDown('p'))then
		for i = 1, #chars do
		
			if(chars[i].selected and chars[i+1])then
			
				if(ppressable)then
				
					self.Print = 'Char Selected Up'
					self.timer = 5
					
					chars[i].selected = false
					chars[i+1].selected = true
				
					ppressable = false

				end
				
			end
		
		end
	
	end
	if(love.keyboard.isDown('o') and opressable)then
		opressable = false
		
		for i = 1, #chars do
		
			if(chars[i].selected and chars[i-1])then
				
				self.Print = 'Char Selected Down'
				self.timer = 5
						
				chars[i].selected = false
				chars[i-1].selected = true
				
			end
		
		end
	
	end
	
		
	if(love.keyboard.isDown('m') and mpressable)then
		mpressable = false
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
		
				for j = 1, #chars[i].events do
				
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
					
						self.Print = 'Added Point'
						self.timer = 5
						
						x,y = camera:getPos()
						
						chars[i].events[j]:addPoint(x,y, 50)
					
					end
				
				end
				
			end
		
		end
	
	end
	
	if(love.keyboard.isDown('n') and npressable)then
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
					self.timer = 5 
				
				else
							
					self.Print = 'Created Event'
					self.timer = 5
			
					xIn,yIn = camera:getPos()
				
					sequence = {
					
						{x = xIn, y = yIn, speed = 50}
				
					}

					chars[i]:newEvent(currentSec, 9999999, sequence, false)
				
				end
				
				dontDo = false
				
			end
		
		end
	
	end
	
	if(love.keyboard.isDown('b') and bpressable)then
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
					self.timer = 5 
				
				else
	
					self.Print = "Created Dialogue"
					self.timer = 5 
		
					sequence = {
			
						{words = "words", time = 3}
		
					}
					
					secretSeq = {
			
						{words = "words", time = 3}
		
					}

					chars[i]:newDialogue(currentSec, 9999999, sequence, false, 0, secretSeq)
														
				end
				
				dontDo = false
				
			end
		
		end
	
	end
	if(love.keyboard.isDown('j') and jpressable)then
		jpressable = false
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
								
				for j = 1, #chars[i].dialogues do
				
					if(chars[i].dialogues[j].started and chars[i].dialogues[j].finished == false)then
						
						self.Print = "Deleted Dialogue!"
						self.timer = 5
						
						table.remove(chars[i].dialogues, j)

					end
				
				
				end
				
			end
		
		end
	
	end
	
	if(love.keyboard.isDown('k') and kpressable)then
		kpressable = false
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
								
				for j = 1, #chars[i].events do
				
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
					
						self.Print = "Deleted Event!"
						self.timer = 5
					
						table.remove(chars[i].events, j)
						
					end
				
				
				end
				
			end
		
		end
	
	end
	
	if(love.keyboard.isDown('l') and lpressable)then
		lpressable = false
		
		
		for i = 1, #chars do
			
			if(chars[i].selected)then
								
				for j = 1, #chars[i].events do
				
					if(chars[i].events[j].started and chars[i].events[j].finished == false)then
				
						for l = 1, #chars[i].events[j].sequence do
					
							if(l == #chars[i].events[j].sequence)then
							
								self.Print = "Deleted Point!"
								self.timer = 5
														
								table.remove(chars[i].events[j].sequence, l)
							
							end
						
						end

					end
				
				
				end
				
			end
		
		end
	
	end



end


function editor:selecting()

	if( love.mouse.isDown( 'l' ) ) then

		x,y = camera:getPos()
		
		--addx, addy = camera:getPos()
		
		--x = (x * 5) + (addx * camera.scaleX)
		--y = (y * 5) + (addy * camera.scaleY)
			
		for i = 1, #sections do
		
			if(sections[i]:getSection(x,y))then
			
				if(love.keyboard.isDown('lshift'))then
				
					continue = true
				
					nada, xOut, yOut, bigXout, bigYout, nameOut = sections[i]:getSection(x,y)
					
					for j = 1, #self.chosen do

						if ((bigXout == self.chosen[j].bigX) and (bigYout == self.chosen[j].bigY))then
													
			
							if ((xOut == self.chosen[j].x) and (yOut == self.chosen[j].y))then
							
								continue = false

							else
								
								--continue = true
							
							end
											
						else
							
							--continue = true

						end
			
					end
								
					if(continue)then
				
						table.insert(editor.chosen, {x = xOut, y = yOut, bigX = bigXout, bigY = bigYout, name = nameOut})

					end
			
				else
				
					for j = 1, #editor.chosen do
					
						table.remove(editor.chosen)
					
					end
				
					nada, xOut, yOut, bigXout, bigYout, nameOut = sections[i]:getSection(x,y)
					
					table.insert(editor.chosen, {x = xOut, y = yOut, bigX = bigXout, bigY = bigYout, name = nameOut})

				end
			end
			
	
		end	
   end
end