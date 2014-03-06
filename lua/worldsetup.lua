--total World Width and World Height in pixels, determined in sections.lua
worldWidth = 0
worldHeight = 0

--day length in minutes
dayLength = 2 -- minutes
hourLength = (dayLength/24) * 60-- seconds

--stores game start second and makes that the current second
gamestartSec, currentSec = love.timer.getTime()


editor:loadmap(1)
editor:loadmap(2)

start = section:new(0, 0, maps[1], colmaps[1], "start")
start2 = section:new(1, 0, maps[2], colmaps[2], "name")


qdoor = door:new({x = 100, y = 100},{x = 300, y = 1000})



-- creates bg image
bg = love.graphics.newImage("images/bg3.png")

-- creates layers 
camera.layers = {}

--tells you how to draw this layer
camera:newLayer(.2, function()

	love.graphics.draw(bg, start.x, start.y)
	love.graphics.draw(bg, start2.x, start2.y)

end)

-- sets camera boundaries
camera:setBounds(0, 0, worldWidth - 1100, worldHeight - 500)