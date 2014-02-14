--[[

player controlled camera movement

advanced player physics
	jumps
	general movement

NPC
	interaction
	Location events
		
Menu
	saving
	toggle full screen
	sound

dual talk sequence?

image array
image drawing


how do i want the player to feel in this environment

]]

require('lua/camera')
require('lua/functions')
require("lua/AnAL")

function love.load(args)

	worldWidth = 0
	worldHeight = 0
	dayLength = 20
	gamestartSec, currentSec = love.timer.getTime()
	zpressable = true
	
	stone = love.graphics.newImage("images/testbox.png")

  	qrightimg = love.graphics.newImage("images/char1right.png")
   
    qrightanim = newAnimation(qrightimg, 23, 28, 0.15, 0)
	qrightanim:setMode("bounce")
	
  	qleftimg = love.graphics.newImage("images/char1left.png")
   
    qleftanim = newAnimation(qleftimg, 23, 28, 0.15, 0)
    qleftanim:setMode("bounce")

		
	require('section')
	

	start = section:new(5,3, {
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
	}, "Start")
	leftgate = section:new(4,3, {
		{ 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
	}, "leftgate")
	outleftgate = section:new(3,3, {
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
	}, "outside!")
	
	well = section:new(2,3, {
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1 },
	}, "well")
	belowwell = section:new(2,4, {
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
	}, "belowwell")
	belowwell = section:new(3,4, {
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
	}, "belowwell")
	
	
	below2 = section:new(4,4, {
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
	}, "below2")
	
	below3 = section:new(5,4, {
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
		{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 },
	}, "below2")
	
	block = section:new(6,4, {
		{ 0,1,0,0,0,0,0,0,0,0,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,1,0,0,0,0,0,0,0,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,0,1,0,0,0,0,0,0,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,0,0,1,0,0,0,0,0,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,0,0,0,1,0,0,0,0,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,0,0,0,0,1,0,0,0,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,0,0,0,0,0,1,0,0,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,0,0,0,0,0,0,1,0,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,0,0,0,0,0,0,0,1,1,0,2,0,0,0,0,0,0,0,0,0 },
		{ 0,1,0,0,0,0,0,0,0,0,1,0,2,0,0,0,0,0,0,0,0,0 },
	}, "nateblockj")
	

	drawables = {};
	setmetatable(drawables, {__index=table})
	
	collidables = {};
	setmetatable(collidables, {__index=table})
	
	timeevents = {};
	setmetatable(collidables, {__index=table})
	
	conditionals = {};
	setmetatable(collidables, {__index=table})
	
	doors = {};
	setmetatable(collidables, {__index=table})
	
	require('lua/ground')
	
	require('lua/images')
	
	require('lua/hero')
	
	require('lua/hater')
	
	require('lua/dialogue')
	
	require('lua/NPC')
	
	require('lua/event')
	
	require('lua/conditional')
	
	require('lua/door')
	
	player.x, player.y = start.x, start.y
	player.drawx, player.drawy = start.x,start.y
	
	q = hater:new(1402, 30)
	
	qtalk = dialogue:new(0, 0, 30, {
		{ "I think its more than that " , 1},
		{ "I dont think its more than that " , 1},
		{ "I think its more than that again" , 1},
		{ "I wannna gpoooooooo hoooomw" , 5},

	}, q, true)
	
	qvent = event:new(0, 1, 0, {
		{ x = 10, y = 350},
		{ x = 100 , y = 100},
		{ x = 1500, y = 900}
	}, q, true)
	
	nerds = false
	qcondition = conditional:new(function() if(nerds)then return true end end, function() love.graphics.print("I WIN I WIN", 100, 100) end, true)

	qdoor = door:new({x = 100, y = 100},{x = 300, y = 1000})

	-- sets camera boundaries
	camera:setBounds(0, 0, worldWidth - 1100, worldHeight - 500)

	-- creates bg image
  	bg = love.graphics.newImage("images/bg.png")

	-- creates layers 
	camera.layers = {}

    camera:newLayer(.2, function()
   
    	love.graphics.draw(bg)
   
    end)
    
end
 
function love.update(dt)
  
  	player:gravity(dt)
	player:checkKeys(dt)
	player:whichSection()
	
	if(zpressable)then

		for i = 1, #doors do
			if(doors[i].opened == false)then
				if(collisionCheckPoint(doors[i].enterx, doors[i].entery, 20, player.x, player.y, player.width, player.height))then
					doors[i]:open()
				end
			else
				if(collisionCheckPoint(doors[i].leavex, doors[i].leavey, 20, player.x, player.y, player.width, player.height))then
					doors[i]:close()
				end
			end
		end
	
	end		
	
	currentSec = love.timer.getTime()
	
	otherKeyChecks()
  
  	camera:setPosition(player.drawx - 550,  player.drawy - 371)
  		
end

function dialogues()

	
	for i = 1, #timeevents do
		if(timeevents[i].startSec <= currentSec and timeevents[i].finished == false)then
			timeevents[i]:trigger()
			
		end
	end
	
	for i = 1, #conditionals do
		if(conditionals[i].condition() and conditionals[i].finished == false)then
			conditionals[i]:action()
			
		end
	end


end
 
function love.draw(dt)
	camera:set()

	camera:drawBackground()
	
  	-- player
  	love.graphics.setColor(255,255,255)
  	--love.graphics.rectangle('fill', player.drawx, player.drawy, player.width, player.height)
  	
  	-- box
	love.graphics.rectangle('line', box.x, box.y, box.width, box.height)
  	
  	 -- haters
  	for i = 1, #drawables do
		love.graphics.rectangle('fill', drawables[i].x, drawables[i].y, drawables[i].width, drawables[i].height)
	end
	
	
	for i = 1, #sections do
		if(sections[i].xBig <= player.sectionx + 1 and sections[i].xBig >= player.sectionx - 2 and sections[i].yBig <= player.sectiony + 1 and sections[i].yBig >= player.sectiony - 2)then
			sections[i]:displayGrid()
		end
	end
	
	for i = 1, #drawables do
			drawables[i]:draw()
	end
		
		
	player:animate()


		
	dialogues()
		
  	camera:unset()
  	
  	camera:getPos()
	
	love.graphics.print(player.sectionx, 10, 40)
	love.graphics.print(player.sectiony, 10, 50)

end