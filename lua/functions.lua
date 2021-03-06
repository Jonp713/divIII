function time()

	 --updates the current second, includes weird editor behavior
 	if(editorMode or pause)then
 	
		currentSec = math.floor(modifier)
		currentMinute = math.floor(modifier/60)

	else

		--[[
		if(opening.finished == false)then
	
			modifier = modifier - dt
		
		end
		]]

		currentSec = math.floor((love.timer.getTime() - gamestartSec) + modifier)
		currentMinute = math.floor(math.floor(love.timer.getTime() - gamestartSec + modifier)/60)

	end

	currentDay = math.ceil(((currentSec + 1)/60)/dayLength)
	currentHour = math.ceil(((currentSec + 1)/hourLength) - ((currentDay - 1) *24))	
	
end

function collisionCheckImage(object1, object2)

	c1x = object1.x
	c1y = object1.y
	
	c2x = object1.x + object1.width
	c2y = object1.y + object1.height
		
	p1x = object2.x
	p1y = object2.y
	
	p2x = object2.x + object2.width
	p2y = object2.y + object2.height
	
	if(c2x > p1x and c2x < p2x and c2y > p1y and c2y < p2y) then
		
		return true -- 4 ,}
	
	end
	if(c2x > p1x and c2x < p2x and c1y > p1y and c1y < p2y) then
		
		return true -- 2 '}
	
	end
	if(c1x > p1x and c1x < p2x and c1y > p1y and c1y < p2y) then
		
		return true -- 1 {'
	
	end
	if(c1x > p1x and c1x < p2x and c2y > p1y and c2y < p2y) then
		
		return true -- 3 {,
	
	end
end


function collisionCheckBox(x1, y1, length1, height1, x2, y2, length2, height2, drawx, drawy)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	oldp1y = drawy
	oldp2y = drawy + height1
	oldp1x = drawx
	oldp2x = drawx + length1
	
	if((p1x > c1x and p1x < c2x) or (p2x > c1x and p2x < c2x))then
		if((p1y > c1y and p1y < c2y) or (p2y > c1y and p2y < c2y))then			
			
			-- going right
			if(x1 > drawx)then
			
				correction = c1x - oldp2x
			
			end
			-- going left
			if(x1 < drawx)then
			
				correction = c2x - oldp1x
			
			end
			-- going down
			if(y1 > drawy)then
			
				correction = c1y - oldp2y
							
			end
			-- going up
			if(y1 < drawy)then
			
				correction = c2y - oldp1y
			end
			
			return true, correction
			
		end
	end

end



function collisionCheckSlopeUp(x1, y1, length1, height1, x2, y2, length2, height2, drawx, drawy)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	oldp1y = drawy
	oldp2y = drawy + height1
	oldp1x = drawx
	oldp2x = drawx + length1
	
	
	for x = -2, 50 do			
			if((p2x >= c1x + x and p2x <= c1x + x + 1))then
				if((p2y >= c2y - x and p2y <= c2y))then	
								
					-- going right
					if(x1 > drawx)then
			
						correction = (c2y - x) - p2y
						
					end
					
					if(x1 < drawx or x1 == drawx)then
						
						correction = 0
						
					end
					
														
					return true, correction
					
				end
				
			end
			
		end
				
end

function collisionCheckSlopeDown(x1, y1, length1, height1, x2, y2, length2, height2, drawx, drawy)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	oldp1y = drawy
	oldp2y = drawy + height1
	oldp1x = drawx
	oldp2x = drawx + length1
	
	
	for x = -10, 42 do			
			if(p1x >= c1x + x and p1x <= c1x + x + 1)then
				if(p2y >= c1y + x and p2y <= c2y)then
						
					if(x1 < drawx)then
						
						correction = (c2y + (x - 40)) - p2y						
						
					end
					
					-- going right
					if(x1 > drawx or x1 == drawx)then
			
						correction = 0
						
					end					
														
					return true, correction
					
				end
				
			end
			
		end
				
end


function collisionCheck(x1, y1, length1, height1, x2, y2, length2, height2)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	if((p1x >= c1x and p1x <= c2x) or (p2x >= c1x and p2x <= c2x))then
		if((p1y >= c1y and p1y <= c2y) or (p2y >= c1y and p2y <= c2y))then			
			
			return true
			
		end
	end

end
function collisionCheckOneWay(x1, y1, length1, height1, x2, y2, length2, height2, drawx, drawy)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	oldp1y = drawy
	oldp2y = drawy + height1
	oldp1x = drawx
	oldp2x = drawx + length1	
	
	
	if((p1x >= c1x and p1x <= c2x) or (p2x >= c1x and p2x <= c2x))then
	-- if the previous location was above the collide y location
		if(oldp2y - 1 < c1y)then
				
			if((p1y >= c1y and p1y <= c2y) or (p2y >= c1y and p2y <= c2y))then
								
				
				return true, c1y - oldp2y
				
				

			end
		end
	end

end

function collisionCheckSide(x1, y1, length1, height1, x2, y2, length2, height2, drawx, drawy, typeIn)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	oldp1y = drawy
	oldp2y = drawy + height1
	oldp1x = drawx
	oldp2x = drawx + length1	
	
	
	if((p1y >= c1y and p1y <= c2y) or (p2y >= c1y and p2y <= c2y))then
	
		--right
		if(typeIn == 1)then
	
			if(oldp2x - 1 < c1x)then

				if((p1x >= c1x and p1x <= c2x) or (p2x >= c1x and p2x <= c2x))then

					return true, c1x - oldp2x
				
				end
			end
		
		--left	
		elseif(typeIn == 2)then
		
			if(oldp1x + 1 > c2x)then

				if((p1x >= c1x and p1x <= c2x) or (p2x >= c1x and p2x <= c2x))then

					return true, c2x - oldp1x
				
				end
			end
			
		end
	end

end


function collisionCheckPoint(x1, y1, radius, x2, y2, length2, height2)

	p1x = x1 - radius
	p1y = y1 - radius
	
	p2x = x1 + radius
	p2y = y1 + radius
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2

	if((p1x >= c1x and p1x <= c2x) or (p2x >= c1x and p2x <= c2x))then
		if((p1y >= c1y and p1y <= c2y) or (p2y >= c1y and p2y <= c2y))then
	
			return true -- 4 ,}
			
		end
	end

end

function collisionCheck2Points(x1, y1, radius, x2, y2, radius)

	p1x = x1 - radius
	p1y = y1 - radius
	
	p2x = x1 + radius
	p2y = y1 + radius
	
	c1x = x2 - radius
	c1y = y2 - radius
	
	c2x = x2 + radius
	c2y = y2 + radius

	if((p1x >= c1x and p1x <= c2x) or (p2x >= c1x and p2x <= c2x))then
		if((p1y >= c1y and p1y <= c2y) or (p2y >= c1y and p2y <= c2y))then
	
			return true -- 4 ,}
			
		end
	end

end


function moveTowardsBottom(leader, follower, slope, xspeed, yspeed, dt)

	if(follower.x + (follower.width/2) < leader.x)then
		follower.x = follower.x + ((xspeed * slope) * dt)
	end
	if(follower.x + (follower.width/2) > leader.x)then
		follower.x = follower.x - ((xspeed * slope) * dt)
	end
	if(follower.y + (follower.height) < leader.y)then
		follower.y = follower.y + (yspeed * dt)
	end
	if(follower.y + (follower.height) > leader.y)then
		follower.y = follower.y - (yspeed * dt)
	end
end

function moveTowards(leader, follower, slope, speed, dt)

	if(follower.x < leader.x)then
		follower.x = follower.x + ((speed * slope) * dt)
	end
	if(follower.x > leader.x)then
		follower.x = follower.x - ((speed * slope) * dt)
	end
	if(follower.y < leader.y)then
		follower.y = follower.y + (speed * dt)
	end
	if(follower.y > leader.y)then
		follower.y = follower.y - (speed * dt)
	end
end

function otherKeyChecks()

	if (love.keyboard.isDown('f') and fpressable and pause == false and diaeditor.up == false) then
		fpressable = false
		
		
		if(editorMode)then
		
		editorMode = false
		fast = false
		gamestartSec = love.timer.getTime()
		
		editor.Print = 'Live Mode'
		editor.timer = 5

		
		else
		
			editorMode = true
			modifier = modifier + math.floor(love.timer.getTime() - gamestartSec)
			
			--love.window.setFullscreen(true, "desktop")
		
			editor.Print = 'Editor Mode'
			editor.timer = 5
		
		end

	end
	
	if(love.keyboard.isDown('z') == false)then
		zpressable = true
	end
	if(love.keyboard.isDown('f') == false)then
		fpressable = true
	end
	if(love.keyboard.isDown('q') == false)then
		qpressable = true
	end
	if(love.keyboard.isDown('w') == false)then
		wpressable = true
	end
	if(love.keyboard.isDown('e') == false)then
		epressable = true
	end
	if(love.keyboard.isDown('a') == false)then
		apressable = true
	end
	if(love.keyboard.isDown('s') == false)then
		spressable = true
	end
	if(love.keyboard.isDown('d') == false)then
		dpressable = true
	end
	if(love.keyboard.isDown('p') == false)then
		ppressable = true
	end
	if(love.keyboard.isDown('o') == false)then
		opressable = true
	end
	if(love.keyboard.isDown('m') == false)then
		mpressable = true
	end
	
	if(love.keyboard.isDown('n') == false)then
	
		npressable = true
	
	end
	if(love.keyboard.isDown('b') == false)then
	
		bpressable = true
	
	end
	if(love.keyboard.isDown('j') == false)then
		jpressable = true
	end
	
	if(love.keyboard.isDown('k') == false)then
	
		kpressable = true
	
	end
	if(love.keyboard.isDown('l') == false)then
	
		lpressable = true
	
	end
	if(love.keyboard.isDown('.') == false)then
	
		forward = false
		
	end
	if(love.keyboard.isDown(',') == false)then
	
		backward = false
	
	end
	if(love.keyboard.isDown('x') == false)then
	
		xpressable = true
	
	end
	if(love.keyboard.isDown('c') == false)then
	
		cpressable = true
	
	end
	if(love.keyboard.isDown('v') == false)then
	
		vpressable = true
	
	end
	if(love.keyboard.isDown('g') == false)then
	
		gpressable = true
	
	end
	if(love.keyboard.isDown(',') == false)then
	
		commapressable = true
	
	end
	if(love.keyboard.isDown('.') == false)then
	
		periodpressable = true
	
	end
	if(love.keyboard.isDown(';') == false)then
	
		colonpressable = true
	
	end
	if(love.keyboard.isDown('3') == false)then
	
		threepressable = true
	
	end
	if(love.keyboard.isDown('4') == false)then
	
		fourpressable = true
	
	end
	if(love.keyboard.isDown('-') == false)then
	
		dashpressable = true
	
	end
	if(love.keyboard.isDown('=') == false)then
	
		equalpressable = true
	
	end
	
	
	if(love.keyboard.isDown('9'))then
		
		if(ninepressable)then
		
			ninepressable = false
		
			boop:play()
	
		end
		
	else
		
		ninepressable = true
		
	end
	
	if(editorMode == false)then
		
		if(love.keyboard.isDown('s') and love.keyboard.isDown('lshift'))then
			
			notes:save()
			
		end
		
		
	end

	
end


function love.textinput(t)
	
	if(diaeditor.up and t ~= ';' and t ~= ':' and t ~= "'" and t ~= '"' and t ~= '\\')then
	
		diaeditor.modifier = 0
	
		for line in diaeditor.text:gmatch("\n") do 

			diaeditor.modifier = diaeditor.modifier + diaeditor.rowlength

		end	
	
		if(#diaeditor.text + diaeditor.modifier < (diaeditor.rowlength * diaeditor.rows))then
   
	   	 	diaeditor.text = diaeditor.text:sub(1, diaeditor.selected) .. t .. diaeditor.text:sub(diaeditor.selected + 1, #diaeditor.text)		
		
			diaeditor.selected = diaeditor.selected + 1
	
		end
	
	end
	
	if(notes.up and t ~= "'" and t ~= '"' and t ~= '\\')then
	
		notes.modifier = 0
	
		for line in notes.text:gmatch("\n") do 

			notes.modifier = notes.modifier + notes.rowlength

		end	
	
		if(notes.up and #notes.text + notes.modifier < (notes.rowlength * notes.rows))then
   
	   	 	notes.text = notes.text:sub(1, notes.selected) .. t .. notes.text:sub(notes.selected + 1, #notes.text)		
		
			notes.selected = notes.selected + 1
	
		end
	
	end
end