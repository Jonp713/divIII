bob = hater:new(430, 350,  {20, 200, 200})

bobtalk = dialogue:new(0, 0, 30, {
	{ "I think its more than that " , 1}
}, bob, true)

bobvent = event:new(0, 1, 0, {
	{ x = 10, y = 350},
	{ x = 100 , y = 100},
	{ x = 1500, y = 900}
}, bob, true)

nerds = false
qcondition = conditional:new(function() if(nerds)then return true end end, function() love.graphics.print("I WIN I WIN", 100, 100) end, true)

