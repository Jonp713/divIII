--[[
EDITOR
Drag mouse

OBJECTS
Set position by mouse click in editor

DRAWING

(drawing orders)

COLLISIONS

(Slopes) (add that to the weird collisions section)

DIALOGUE
Taller
Rather than stopping at end sec....it just can't start after end sec? Why would I ever want to cut off a dialogue? Do I ever want to?
for hidden situations, need them to pause?

EVENTS 
(Better time correlation with when movements end)
(better jump speeds)
(NPC physics?/jumping?) - (Snap to closest ground if you want)

EXTENSIONS

NPC
		
MENU
	saving
	toggle full screen
	sound
	
SOUNDS

Louder Softer

HERO


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

--Debug/Editor	
function editorDebug()

	love.graphics.setColor(255,0,0)
		
	--display mouse position in world
	printx, printy = camera:getPos()

	love.graphics.print("x: " .. printx .. ' ,', 10, 10)
	love.graphics.print("y: " .. printy, 10, 20)

	
	love.graphics.print('Seconds: '..currentSec , 1180, 10)
	love.graphics.print('Minutes: '..currentMinute , 1180, 22)
	
	love.graphics.print('"Day": '..currentDay , 1180, 40)
	love.graphics.print('"Hour": '..currentHour , 1180, 52)

	love.graphics.print(editor.Print, 600, 10)
	love.graphics.print(chars[1].count, 600, 22)
	love.graphics.print(chars[2].count, 600, 34)
	love.graphics.print(toprint, 600, 46)
	love.graphics.print(toprint2, 600, 58)
	--love.graphics.print('y2'..extensionsSizes.y2[1], 600, 70)
	
	--love.graphics.print('camerax'..camera._x, 600, 90)
	--love.graphics.print('cameray'..camera._y, 600, 102)
	--love.graphics.print('playerx'..player.x, 600, 114)
	--love.graphics.print('playery'..player.y, 600, 126)
		
	if(camera.inextension)then
		
		--love.graphics.print('hey guys', 600, 114)

	end

	love.graphics.setColor(255,255,255)
	

end
