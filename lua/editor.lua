maps = {




}

colmaps = {



}

chars = {



}

editor = {

x = 1,
y = 1,
bigX = 0,
bigY = 0,
name = ""

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
	
	
	local f,err = io.open("/Users/TheDon/Desktop/attempt1/levels/"..number..".txt","w")
	if not f then return print(err) end
	f:write(strg)
	f:close()

end

function editor:checkKeys()

	if love.keyboard.isDown('/') then

		self:savemap(1)
		self:savemap(2)
		toprint2 = 'Saved'
	
	end
	
	if(love.keyboard.isDown('q'))then

		if(qpressable)then
			qpressable = false

			for i = 1, #sections do

				if ((sections[i].xBig == self.bigX) and (sections[i].yBig == self.bigY))then
					toprint = 'Changed'
					
					sections[i].grid[self.y][self.x] = sections[i].grid[self.y][self.x] + 1
					
					
				end
			end
			
		end
	end
	
	if(love.keyboard.isDown('w'))then

		if(wpressable)then
			wpressable = false

			for i = 1, #sections do

				if ((sections[i].xBig == self.bigX) and (sections[i].yBig == self.bigY))then
					toprint = 'Changed'
					
					sections[i].grid[self.y][self.x] = sections[i].grid[self.y][self.x] - 1
					
					
				end
			end
			
		end
	end
	
	if(love.keyboard.isDown('a'))then

		if(apressable)then
			apressable = false

			for i = 1, #sections do

				if ((sections[i].xBig == self.bigX) and (sections[i].yBig == self.bigY))then
					toprint = 'Changed'
					
					sections[i].col[self.y][self.x] = 1
					
					
				end
			end
			
		end
	end
	
	if(love.keyboard.isDown('s'))then

		if(spressable)then
			spressable = false

			for i = 1, #sections do

				if ((sections[i].xBig == self.bigX) and (sections[i].yBig == self.bigY))then
					toprint = 'Changed'
					
					sections[i].col[self.y][self.x] = 2
					
					
				end
			end
			
		end
	end

	if(love.keyboard.isDown('d'))then

		if(dpressable)then
			dpressable = false

			for i = 1, #sections do

				if ((sections[i].xBig == self.bigX) and (sections[i].yBig == self.bigY))then
					toprint = 'Changed'
					
					sections[i].col[self.y][self.x] = 0
					
					
				end
			end
			
		end
	end

end


function love.mousepressed(addx, addy, button)
   if button == "l" then
		
		x,y = camera:returnPos()
		
		x = (x * 5) + addx
		y = (y * 5) + addy
			
		for i = 1, #sections do
		
			if(sections[i]:getSection(x,y))then
				
				
				nada, editor.x, editor.y, editor.bigX, editor.bigY, editor.name = sections[i]:getSection(x,y)
		
			end
	
		end	
   end
end