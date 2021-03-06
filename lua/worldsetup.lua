--total World Width and World Height in pixels, determined in sections.lua
worldWidth = 0
worldHeight = 0

love.graphics.setBackgroundColor(255, 255, 255)

dayCount = 7
--day length in minutes
dayLength = 15 -- minutes
hourLength = (dayLength/24) * 60-- seconds
modifier = 0 --hello

--stores game start second and makes that the current second
gamestartSec = love.timer.getTime()
currentSec = gamestartSec

mapCount = 25

for i = 1, mapCount do
	
	editor:loadmap(i)
	
end

--middle
section:new(0, 3, maps[1], colmaps[1], "start")
start = section:new(1, 3, maps[2], colmaps[2], "name")
section:new(2, 3, maps[3], colmaps[3], "start")
section:new(3, 3, maps[4], colmaps[4], "name")
hotel = section:new(4, 3, maps[5], colmaps[5], "start")


--above
section:new(0, 2, maps[6], colmaps[6], "name")
section:new(1, 2, maps[7], colmaps[7], "start")
section:new(2, 2, maps[8], colmaps[8], "name")
section:new(3, 2, maps[9], colmaps[9], "name")
section:new(4, 2, maps[10], colmaps[10], "start")


--below
section:new(0, 4, maps[11], colmaps[11], "start")
section:new(1, 4, maps[12], colmaps[12], "name")
section:new(2, 4, maps[13], colmaps[13], "start")
section:new(3, 4, maps[14], colmaps[14], "name")
section:new(4, 4, maps[15], colmaps[15], "start")


extension:new(100, 100, maps[10], colmaps[10], "thehouse", 1)
extension:new(100, 101, maps[11], colmaps[11], "thehouse2", 1)

door:new(start.coords[8][4], extensions[1].coords[8][6], "thehouse")

door:new(hotel.coords[8][26], extensions[1].coords[8][6], "thehouse")
door:new(hotel.coords[8][27], extensions[1].coords[8][6], "thehouse")
door:new(hotel.coords[8][28], extensions[1].coords[8][6], "thehouse")



-- creates bg image
--bg = love.graphics.newImage("images/bg3.png")

-- creates layers 
camera.layers = {}

--sec1bg = love.graphics.newImage("backgrounds/testbackground.png")

--tells you how to draw this layer


camera:newLayer(.2, function()

	--love.graphics.draw(sec1bg, start.coords[1][1].x, start.coords[1][1].y)

end)

camera:scale(0.5, 0.5)

extensions:getSizes()

-- sets camera boundaries
camera:setBounds(0, 0, worldWidth - sections[1].width, worldHeight - sections[1].height)



--objects

editor:loadObjects()
