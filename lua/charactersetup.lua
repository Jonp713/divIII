arrrnold = npc:new(3500, 990,  {0, 200, 200})

clara = npc:new(1462, 1475,  {200, 120, 120})

alfonso = npc:new(1000, 1475,  {80, 220, 80})

doosquat = npc:new(2800, 1475,  {20, 100, 180})

tooply = npc:new(4000, 1475,  {200, 200, 10})

monfred = npc:new(2000, 1310, {100, 80, 200})

tooper = npc:new(1815, 1070,  {255, 80, 100})

arrrnold.selected = true

editor:loadEvent(1)
editor:loadDialogue(1)

editor:loadEvent(2)
editor:loadDialogue(2)

editor:loadEvent(3)
editor:loadDialogue(3)

editor:loadEvent(4)
editor:loadDialogue(4)

editor:loadEvent(5)
editor:loadDialogue(5)

editor:loadEvent(6)
editor:loadDialogue(6)

editor:loadEvent(7)
editor:loadDialogue(7)

nerds = false
qcondition = conditional:new(function() if(nerds)then return true end end, function() love.graphics.print("I WIN I WIN", 100, 100) end, true)

