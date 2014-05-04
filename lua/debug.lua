--[[
EDITOR

DIALOGUE
Rather than stopping at end sec....it just can't start after end sec? Why would I ever want to cut off a dialogue? Do I ever want to?
for hidden situations, need them to pause?

EVENTS 
(Better time correlation with when movements end)
(better jump speeds)
(NPC physics?/jumping?) - (Snap to closest ground if you want)
		
MENU
Main Menu
Opening Sequence
Pause Menu

NOTES
Save Notes
Load Notes

SOUNDS
Based on player location

q - go up one blockgraphic
w - go down one blockgraphic

a - solid 
s - standable + others
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

z - selected object down graphic
x - selected object up graphic
c - create object
v - delete object

; - edit dialogue
	up - increase second
	down - decrease second
	= - new words in sequence
1 - createSecretBox
2 - togggleSecret and type (Off, Only, Except)

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
	love.graphics.print(#chars[2].dialogues[1].sortArray[1].markers, 600, 22)
	love.graphics.print(#chars[2].dialogues[1].sortArray[1].placements, 600, 34)
	love.graphics.print(editor.hiddeny1, 600, 46)
	love.graphics.print(editor.hiddeny2, 600, 58)
	love.graphics.print(toprint5, 600, 70)
	love.graphics.print(toprint6, 600, 82)
	love.graphics.print(toprint7, 600, 94)
	love.graphics.print(#editor.chosen, 600, 108)
	
	
	if(#editor.chosen > 1)then
		
	--love.graphics.print(editor.chosen[2].x, 600, 90)
	--love.graphics.print('cameray'..camera._y, 600, 102)
	--love.graphics.print('playerx'..player.x, 600, 114)
	--love.graphics.print('playery'..player.y, 600, 126)
	
	end
	
	love.graphics.setFont(thinfont)
	
	--love.graphics.print('Delight', 400, 100)
	
	
	love.graphics.setFont(font2)
	
		
	if(camera.inextension)then
		
		--love.graphics.print('hey guys', 600, 114)

	end
		

	love.graphics.setColor(255,255,255)
	

end
