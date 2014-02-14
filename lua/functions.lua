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

function collisionCheckBox(x1, y1, length1, height1, x2, y2, length2, height2)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	if((p1x > c1x and p1x < c2x) or (p2x > c1x and p2x < c2x))then
		if((p1y > c1y and p1y < c2y) or (p2y > c1y and p2y < c2y))then
			return true
		end
	end

--[[
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
]]

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


function moveTowards(leader, follower)

	if(follower.x < leader.x)then
		follower.x = follower.x + 5
	end
	if(follower.x > leader.x)then
		follower.x = follower.x - 5
	end
	if(follower.y < leader.y)then
		follower.y = follower.y + 5
	end
	if(follower.y > leader.y)then
		follower.y = follower.y - 5
	end
end

function otherKeyChecks()
	if love.keyboard.isDown('f') then

		love.window.setFullscreen(true, "desktop")

	end

	if love.keyboard.isDown('d') then

		love.window.setFullscreen(false, "desktop")
		
	end
	
	if love.keyboard.isDown('l') then
		nerds = true
		
	end
	
	if(love.keyboard.isDown('z') == false)then
		zpressable = true
	end


end