function love.load(args)

	--to prevent repeated key presses
	zpressable, qpressable, wpressable, apressabe, spressable, dpressable, ppressable, opressable = true
	mpressable, npressable, bpressable, fpressable, gpressable, xpressable, cpressable, vpressable, epressable = true
	
	equalpressable, commapressable, colonpressable, periodpressable, enterpressable, backspacepressable, leftpressable, rightpressable, uppressable, downpressable, dashpressable = true
	
	onepressable, twopressable, threepressable, ninepressable, fourpressable = true
	
	leftclick = true
	
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
	toprint5 = 1
	toprint6 = 1
	toprint7 = 1
	
	pause = false
	
	objects = {}

	drawables = {}
	
	collidables = {}
	
	timeevents = {}
	
	conditionals = {}
	
	doors = {}
	
	chars = {}
	
	--camera library
	require('lua/camera')
	--random useful functions (collisions, extra key checks, parsing, table to string)
	require('lua/functions')
	--animation library
	require("lua/AnAL")
	--level editor
	require('lua/editor')
	--dialogue editor
	require('lua/diaeditor')
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
	--objects
	require('lua/object')
	--npcs
	require('lua/NPC')
	--movement events timed
	require('lua/event')
	--conditional events timed
	require('lua/conditional')
	--doors
	require('lua/door')
	--sounds
	require('lua/sounds')
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
	
	
	--notes system
	require('lua/notes')
	--gui
	require('lua/debug')
	--debug
	require('lua/GUI')
	
	time()
	
	notes:load()
	
	chars:set(2)
	chars:diaChop()
		
	defaultfont = love.graphics.newFont('fonts/typewriter.ttf', 20 )
	font2 = love.graphics.newFont(12) -- the number denotes the font size
	thinfont = love.graphics.newFont('fonts/thin.ttf', 50 )
	fontsmaller = love.graphics.newFont(7) -- the number denotes the font size

	love.graphics.setFont(font2)
		

end
 
function love.update(dt)
	
	time()

	alldt = dt
	
	if(editorMode)then

		--checks for keys to change objects and fastforwarding/rewinding in editor
		editor:checkKeys(dt)
		editor:selecting()
		diaeditor:checkKeys()
	end
	
	--checks if keys ARENT pressed and fullscreen keychecks
	otherKeyChecks()
	
	--moves camera up and down...zooms camera
	camera:checkKeys(dt)
	
	notes:checkKeys()
	
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
	
	objects:draw()
	
	-- draw drawable creatures
	for i = 1, #drawables do
		drawables[i]:draw()
	end
	
		
	--animate player...draw them and draw them last
	player:animate()
	
	--display dialogues over everything else
	dialogues()
		
		
	--dragbox
	if(editor.rwasdown and editorMode)then
   
   	 	love.graphics.rectangle("line", editor.boxx1, editor.boxy1, editor.boxxdrag - editor.boxx1, editor.boxydrag - editor.boxy1)

	end
	
	if(editor.hiddenDrag and editorMode)then
 		
		love.graphics.rectangle("line", editor.hiddenx1, editor.hiddeny1, editor.hiddenDragx - editor.hiddenx1, editor.hiddenDragy - editor.hiddeny1)
		
	end
		
	--unset the background
  	camera:unset()
  
	--check to see if the player has interacted with anything and display the interaction at position independent of camera
  	interactions:checkAll()
  	
  	--opening:trigger()
	--opening.finished = true
	
	if(editorMode)then
		diaeditor:draw()
		
		editorDebug()
	else
		
		playGUI()
		
	end
	
end