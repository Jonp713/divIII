--[[

--conditional example
qcondition = conditional:new(function() if(nerds)then return true end end, function() love.graphics.print("I WIN I WIN", 100, 100) end, true

]]

arrrnold = npc:new(1440, 1440,  {0, 200, 200})
arrrnold.selected = true

boob = npc:new(1240, 1300,  {0, 200, 200})


charCount = 2

for i = 1, charCount do
	
	editor:loadEvent(i)
	editor:loadDialogue(i)
	
end


