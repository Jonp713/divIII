--[[

player controlled camera movement

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



function love.load(args)
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
	
	--camera library
	require('lua/camera')
	--random useful functions (collisions, extra key checks, parsing, table to string)
	require('lua/functions')
	--animation library
	require("lua/AnAL")
	--level editor
	require('lua/editor')
	--sections of the world
	require('lua/section')
	--temporary (for boundary border
	require('lua/ground')
	--load images and animations
	require('lua/images')
	--"haters" (bad guys)
	require('lua/hater')
	--dialogue events timed
	require('lua/dialogue')
	--npcs
	require('lua/NPC')
	--movement events timed
	require('lua/event')
	--conditional events timed
	require('lua/conditional')
	--doors
	require('lua/door')
	--load maps, create sections
	require('lua/worldsetup')
	--sets up,creates, lods characters
	require('lua/charactersetup')
	--sets up events
	require('lua/eventsetup')
	--player character
	require('lua/hero')
	
	--to prevent repeated key presses
	zpressable, qpressable, wpressable, apressabe, spressable, dpressable = true
	
	--turning on and off level editor mode
	editorMode = true
	debugMode = false

end
 
function love.update(dt)
  
  	--enacts gravity on the player
  	player:gravity(dt)
  	
  	--checks to see if player movement key is pressed, adds speed and acceleration to player depending on air/ground/currentspeed
	player:checkKeys(dt)
	
	--figure out which section the player is in....only draw one section over
	player:whichSection()
	
	--move players
	player:move(dt)
    
    --make sure player movement is not illegal, if so reset it
    player:checkMovement()
	
	if(editorMode)then

		--checks for keys to change objects
		editor:checkKeys()
	
	end
	
	--check all doors
	doors:checkAll()
	
	--checks if keys ARENT pressed and fullscreen
	otherKeyChecks()
  
  	--sets the camera position based on the player
  	camera:setPosition(player.drawx - 550,  player.drawy - 371)
  	
  	--updates the current second
	currentSec = math.floor(love.timer.getTime() - gamestartSec)
	currentMinute = math.floor(math.floor(love.timer.getTime() - gamestartSec)/60)

	
	currentDay = math.ceil(((currentSec + 1)/60)/dayLength)
	currentHour = math.ceil(((currentSec + 1)/hourLength) - ((currentDay - 1) *24))
	
	
  		
end

function dialogues()

	--check for dialogue/movement events triggered by time, enact them
	for i = 1, #timeevents do
		if(timeevents[i].startSec <= currentSec and timeevents[i].finished == false)then
			timeevents[i]:trigger()
			
		end
	end
	
	--check for dialogue/movement events triggered by conditions, enact them
	for i = 1, #conditionals do
		if(conditionals[i].condition() and conditionals[i].finished == false)then
			conditionals[i]:action()
			
		end
	end


end
 
function love.draw(dt)

	--set the camera
	camera:set()

	--draw scrolling background
	camera:drawBackground()
	
  	-- boundaries box
	--love.graphics.rectangle('line', box.x, box.y, box.width, box.height)
  	
  	 -- draw drawables as rectangles (temporary)
  	for i = 1, #drawables do
		love.graphics.rectangle('fill', drawables[i].x, drawables[i].y, drawables[i].width, drawables[i].height)
	end
	
	--draw every part of each section (display the grids) (ONLY DRAW SECTIONS ONLY 1 SECTION AWAY FROM THE PLAYER
	for i = 1, #sections do
		if(sections[i].xBig <= player.sectionx + 1 and sections[i].xBig >= player.sectionx - 2 and sections[i].yBig <= player.sectiony + 1 and sections[i].yBig >= player.sectiony - 2)then
			sections[i]:displayGrid()
		end
	end
	
	-- draw drawable creatures
	for i = 1, #drawables do
		drawables[i]:draw()
	end
		
	--animate player...draw them and draw them last
	player:animate()

	--display dialogues over everything else
	dialogues()
		
	--unset the background
  	camera:unset()
  	
	  
	--DEBUG  
	love.graphics.setColor(0,0,0)
	
	--display mouse position in world
	camera:getPos()
	love.graphics.print('Seconds: '..currentSec , 1000, 10)
	love.graphics.print('Minutes: '..currentMinute , 1000, 22)
	
	love.graphics.print('"Day": '..currentDay , 1000, 40)
	love.graphics.print('"Hour": '..currentHour , 1000, 52)


	
  	love.graphics.setColor(255,255,255)
  

end