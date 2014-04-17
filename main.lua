function love.load(args)

	--to prevent repeated key presses
	zpressable, qpressable, wpressable, apressabe, spressable, dpressable, ppressable, opressable = true
	mpressable, npressable, bpressable, fpressable, gpressable = true
	
	commapressable, periodpressable = true
	
	forward, backward = false
	
	won, lost = false, false
	
	--turning on and off level editor mode
	editorMode = false
	debugMode = false
	ifcinematic = false
	toprint = 1
	toprint2 = 1
	toprint3 = ''
	toprint4 = ''

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
	--sections of the world
	require('lua/extension')
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
	--sets up sounds
	require('lua/soundsetup')
	--player character
	require('lua/hero')
	
	--gui
	require('lua/debug')
	--debug
	require('lua/GUI')
	
	time()
	
	chars:set(2)
		

end
 
function love.update(dt)
	
	time()

	alldt = dt
	
	if(editorMode)then

		--checks for keys to change objects and fastforwarding/rewinding in editor
		editor:checkKeys(dt)
		editor:selecting()
	
	end
	
	--checks if keys ARENT pressed and fullscreen keychecks
	otherKeyChecks()
	
	--moves camera up and down...zooms camera
	camera:checkKeys(dt)
	
	--playerkeys and movements
	player:update(dt)
	
	--
	chars:events()
			
	--check all doors
	doors:checkAll()

	--figure out how to display the camera
	camera:displayMath()	
	
end

function dialogues()
	
	
	chars:dialogues()
	
	--check for dialogue/movement events triggered by conditions, enact them
	for i = 1, #conditionals do
		if(conditionals[i].condition() and conditionals[i].finished == false)then
			conditionals[i]:action()
			
		end
	end


end
 
function love.draw()

	--set the camera
	camera:set()

	--draw scrolling background
	camera:drawBackground()
	
	--draw every part of each section (display the grids) (ONLY DRAW SECTIONS ONLY 1 SECTION AWAY FROM THE PLAYER
	for i = 1, #sections do
		if(sections[i].xBig <= player.sectionx + 1 and sections[i].xBig >= player.sectionx - 2 and sections[i].yBig <= player.sectiony + 1 and sections[i].yBig >= player.sectiony - 2)then
			sections[i]:displayGrid()
		end
	end
	
	--draw extensions
	for i = 1, #extensions do
		if(extensions[i].drawNum == camera.drawNum)then
		
			extensions[i]:displayGrid()
			
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
  
	--check to see if the player has interacted with anything and display the interaction at position independent of camera
  	interactions:checkAll()
  	
  	--opening:trigger()
	--opening.finished = true
	
	if(editorMode)then
	
		editorDebug()
	else
		
		playGUI()
		
	end
	
end