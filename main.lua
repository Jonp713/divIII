--[[

COLLISIONS

(Slopes)

DOORS
	
Better Doors
DoorSendId
DoorFromId

Extension (Inside Houses and such...) (Similar to section , but does not add to worldwidth

NPC
	Location events
	dialogue sequence ends if you leave them - replaced with ?
	dialogue changes if you are around them
		
		
Menu
	saving
	toggle full screen
	sound

how do i want the player to feel in this environment

q - go up one blockgraphic
w - go down one blockgraphic

a - solid 
s - standable 
d - hollow

o - character down one
p - character up one

f - editormode Toggle

j - delete dialogues currently displayed by selected chracter
k - delete event
l - delete point

b - make a dialogue
n - make an event
m - make a point


]]


function love.load(args)

	--to prevent repeated key presses
	zpressable, qpressable, wpressable, apressabe, spressable, dpressable, ppressable, opressable = true
	mpressable, npressable, bpressable, fpressable = true
	
	forwards, backward = false
	
	--turning on and off level editor mode
	editorMode = false
	debugMode = false
	toprint = 1
	toprint2 = 1
	toprint3 = ''

	drawables = {}
	--setmetatable(drawables, {__index=table})
	
	collidables = {}
	--setmetatable(collidables, {__index=table})
	
	timeevents = {}
	--setmetatable(collidables, {__index=table})
	
	conditionals = {}
	--setmetatable(collidables, {__index=table})
	
	doors = {}
	--setmetatable(collidables, {__index=table})
	
	chars = {}
	
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
	--text interactions with chars and objects
	require('lua/interaction')
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
	--cutscenes
	require("lua/cinematic")
	--load maps, create sections
	require('lua/worldsetup')
	--sets up,creates, lods characters
	require('lua/charactersetup')
	--sets up events
	require('lua/eventsetup')
	--player character
	require('lua/hero')



	
end
 
function love.update(dt)

	alldt = dt
  
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
		editor:checkKeys(dt)
		editor:selecting()
	
	end
	
	--check all doors
	doors:checkAll()
	
	--checks if keys ARENT pressed and fullscreen keychecks
	otherKeyChecks()
	camera:checkKeys(dt)
  
  	--sets the camera position based on the player
  	camera:setPosition(player.drawx - (640 * camera.scaleX),  player.drawy - ((280 + camera.modifier) * camera.scaleY))
  	
  	 --updates the current second, includes weird editor behavior
  	if(editorMode)then
  	
		currentSec = math.floor(modifier)
		currentMinute = math.floor(modifier/60)
	
	else
	
		currentSec = math.floor((love.timer.getTime() - gamestartSec) + modifier)
		currentMinute = math.floor(math.floor(love.timer.getTime() - gamestartSec)/60)
	
	end

	
	currentDay = math.ceil(((currentSec + 1)/60)/dayLength)
	currentHour = math.ceil(((currentSec + 1)/hourLength) - ((currentDay - 1) *24))
	
	--scroll through characters
	for i = 1, #chars do

		--check for movement events triggered by time, enact them
		for j = 1, #chars[i].events do
			if(chars[i].events[j].startSec <= currentSec and chars[i].events[j].finished == false)then
				chars[i].events[j]:trigger()
			
			end
		
			--reset for editor mode
			if(editorMode and chars[i].events[j].startSec > currentSec)then
			
				chars[i].events[j].started = false
				chars[i].events[j].finished = false
				chars[i].events[j].state = 1
				chars[i].events[j].resetslope = true
		
			end
		end
		
	end
	
end

function dialogues()

	--scroll through characters
	for i = 1, #chars do

		--check for dialogue events triggered by time, enact them
		for j = 1, #chars[i].dialogues do
			if(chars[i].dialogues[j].startSec <= currentSec and chars[i].dialogues[j].finished == false)then
				chars[i].dialogues[j]:trigger()
			
			end
		
			--reset for editor mode
			if(editorMode and chars[i].dialogues[j].startSec > currentSec)then
			
				chars[i].dialogues[j].started = false
				chars[i].dialogues[j].finished = false
				chars[i].dialogues[j].state = 1
				chars[i].dialogues[j].resetslope = true
		
			end
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
	
	--draw every part of each section (display the grids) (ONLY DRAW SECTIONS ONLY 1 SECTION AWAY FROM THE PLAYER
	for i = 1, #sections do
		--if(sections[i].xBig <= player.sectionx + 1 and sections[i].xBig >= player.sectionx - 2 and sections[i].yBig <= player.sectiony + 1 and sections[i].yBig >= player.sectiony - 2)then
			sections[i]:displayGrid()
		--end
	end
	
	love.graphics.setColor(122,122,122)

	love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
	
	love.graphics.setColor(0,0,0)
	
	love.graphics.rectangle('line', player.x, player.y, player.width, player.height)
	
  	love.graphics.setColor(255,255,255)

	
	-- draw drawable creatures
	for i = 1, #drawables do
		drawables[i]:draw()
	end
		
	--animate player...draw them and draw them last
	--player:animate()
	
	
	
	--display dialogues over everything else
	dialogues()
		
	--unset the background
  	camera:unset()
  	
  	
  	for i = 1, #interactions do

  		
  		if(interactions[i].triggerGo)then
  		
  			interactions[i]:trigger()
  		else
  		  	if(interactions[i].startTime < currentSec and interactions[i].endTime > currentSec)then
  		
  			interactions[i]:display()
  			
  			end
  		end
  	end
	
	--DEBUG  
	love.graphics.setColor(255,0,0)
	
	--display mouse position in world
	camera:getPos()
		
	love.graphics.print('Seconds: '..currentSec , 1200, 10)
	love.graphics.print('Minutes: '..currentMinute , 1200, 22)
	
	love.graphics.print('"Day": '..currentDay , 1200, 40)
	love.graphics.print('"Hour": '..currentHour , 1200, 52)
	
	love.graphics.print(editor.Print, 600, 10)
	love.graphics.print(camera.scaleX, 600, 22)
	--love.graphics.print(interactions[1].sequence[1].words, 600, 34)
	
  	love.graphics.setColor(255,255,255)
  

end