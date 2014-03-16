--total World Width and World Height in pixels, determined in sections.lua
worldWidth = 0
worldHeight = 0

love.graphics.setBackgroundColor(255, 255, 255)


--day length in minutes
dayLength = 2 -- minutes
hourLength = (dayLength/24) * 60-- seconds
modifier = 0

--stores game start second and makes that the current second
gamestartSec, currentSec = love.timer.getTime()

editor:loadmap(1)
editor:loadmap(2)
editor:loadmap(3)
editor:loadmap(4)
editor:loadmap(5)
editor:loadmap(6)
editor:loadmap(7)
editor:loadmap(8)
editor:loadmap(9)
editor:loadmap(10)
editor:loadmap(11)
editor:loadmap(12)
editor:loadmap(13)
editor:loadmap(14)
editor:loadmap(15)
editor:loadmap(16)
editor:loadmap(17)
editor:loadmap(18)
editor:loadmap(19)
editor:loadmap(20)
editor:loadmap(21)
editor:loadmap(22)
editor:loadmap(23)
editor:loadmap(24)
editor:loadmap(25)

section:new(0, 0, maps[21], colmaps[21], "name")
section:new(1, 0, maps[22], colmaps[22], "start")
section:new(2, 0, maps[23], colmaps[23], "name")
section:new(3, 0, maps[24], colmaps[24], "name")
section:new(4, 0, maps[25], colmaps[25], "name")

section:new(0, 1, maps[10], colmaps[10], "name")
section:new(1, 1, maps[11], colmaps[11], "start")
section:new(2, 1, maps[12], colmaps[12], "name")
section:new(3, 1, maps[13], colmaps[13], "name")
section:new(4, 1, maps[14], colmaps[14], "name")

section:new(0, 2, maps[4], colmaps[4], "name")
section:new(1, 2, maps[5], colmaps[5], "start")
arrrhouse = section:new(2, 2, maps[6], colmaps[6], "name")
section:new(3, 2, maps[15], colmaps[15], "name")
section:new(4, 2, maps[16], colmaps[16], "name")


section:new(0, 3, maps[1], colmaps[1], "start")
start = section:new(1, 3, maps[2], colmaps[2], "name")
section:new(2, 3, maps[3], colmaps[3], "start")
section:new(3, 3, maps[17], colmaps[17], "start")
section:new(4, 3, maps[18], colmaps[18], "start")


section:new(0, 4, maps[7], colmaps[7], "start")
section:new(1, 4, maps[8], colmaps[8], "name")
section:new(2, 4, maps[9], colmaps[9], "start")
section:new(3, 4, maps[19], colmaps[19], "start")
section:new(4, 4, maps[20], colmaps[20], "start")




qdoor = door:new({x = 100, y = 100},{x = 300, y = 1000})



-- creates bg image
bg = love.graphics.newImage("images/bg3.png")

-- creates layers 
camera.layers = {}

--tells you how to draw this layer
camera:newLayer(.2, function()


end)

camera:scale(0.5, 0.5)

-- sets camera boundaries
camera:setBounds(0, 0, worldWidth - sections[1].width, worldHeight - sections[1].height)
