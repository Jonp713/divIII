--[[

--conditional example
qcondition = conditional:new(function() if(nerds)then return true end end, function() love.graphics.print("I WIN I WIN", 100, 100) end, true

]]

arrrnold = npc:new(1440, 1440,  {0, 200, 200})
arrrnold.selected = true

boob = npc:new(1240, 1300,  {0, 100, 200})
tuesday = npc:new(1840, 1300,  {0, 200, 255})
ernest = npc:new(2240, 1300,  {255, 0, 200})
procter = npc:new(2540, 1300,  {20, 80, 100})
anni = npc:new(2740, 1300,  {200, 100, 0})
spat = npc:new(2940, 1300,  {20, 200, 20})
rundoc = npc:new(3140, 1300,  {200, 200, 100})
easha = npc:new(3340, 1300,  {150, 100, 50})

charCount = 9

for i = 1, charCount do
	
	editor:loadEvent(i)
	editor:loadDialogue(i)
	
end


