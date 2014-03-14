bob = npc:new(430, 270,  {0, 200, 200})

clara = npc:new(530, 270,  {200, 120, 120})

alfonso = npc:new(230, 270,  {80, 220, 80})

bob.selected = true


editor:loadEvent(1)
editor:loadDialogue(1)

editor:loadEvent(2)
editor:loadDialogue(2)

editor:loadEvent(3)
editor:loadDialogue(3)

nerds = false
qcondition = conditional:new(function() if(nerds)then return true end end, function() love.graphics.print("I WIN I WIN", 100, 100) end, true)

