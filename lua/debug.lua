--[[
EDITOR
Interactions?
Sounds? 
Whats the point of this? turn this whole thing into a full gui, or just store the values so I can like KNOW whatsup and use them in the code....
Change Sounds to a images array and change them using that....

SECTIONS
Turn blocks into image array

COLLISIONS
Broken on slopes sometimes when cpu going too slow

DIALOGUE
Toggle Repeat

EVENTS 
(Better time correlation with when movements end)
(NPC physics?/jumping?) - (Snap to closest ground if you want)
Change Animations by event + General NPC animation

OBJECTS
Foreground? Do I care? (this is filmy dude)
Background
Create new object with same Image as currently selected

click - select grid object lshift(group) rshift(boxdrag)
right click - select object

q - go up one blockgraphic lshift(+5)
w - go down one blockgraphic lshift(-5)

a - solid 
s - standable + others including slope
d - hollow

o - character down one rshift(-5)
p - character up one rshift(+5)

f - editormode Toggle

j - delete dialogues currently displayed by selected chracter
k - delete event
l - delete point

b - make a dialogue
n - make an event
m - make a point

z - selected object down graphic lshift(-5)
x - selected object up graphic lshift(+5)
c - create object
v - delete object

; - edit dialogue
	up - increase second
	down - decrease second
	= - new words in sequence
	- - delete words in sequence

1 - createSecretBox
2 - togggleSecret and type (Off, Only, Except, Moving)
3 - Toggle event repeat

- - lower event speed rshift(lower event wait time)
= - raise event speed rshift(raise event wait time)

> - fastforward rshift(*10) lshift(day +)
< - rewind rshift(*10) lshift(day -)

/ - Save

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
	love.graphics.print(toprint, 600, 22)
	love.graphics.print(toprint, 600, 34)
	love.graphics.print(toprint, 600, 46)
	love.graphics.print(toprint, 600, 58)
	love.graphics.print(toprint2, 600, 70)
	--love.graphics.print(toprint3, 600, 82)
	--love.graphics.print(toprint7, 600, 94)
	
	
	if(chars[1].events[1].sequence[2].door)then
		
		--love.graphics.print("this is true", 600, 90)

	
	else
	
		--love.graphics.print("this is not true", 600, 90)
	
	end
	
	love.graphics.setFont(thinfont)
	
	--love.graphics.print('Delight', 400, 100)
	
	
	love.graphics.setFont(font2)

	love.graphics.setColor(255,255,255)
	

end
