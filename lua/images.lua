

--importing images
stone = love.graphics.newImage("images/testbox.png")
wood = love.graphics.newImage("images/wood.png")
tin = love.graphics.newImage("images/tin.png")
red = love.graphics.newImage("images/red.png")
noteblock = love.graphics.newImage("images/noteblock.png")
noteblock2 = love.graphics.newImage("images/noteblock2.png")
bomb = love.graphics.newImage("images/bomb.png")

whitesquig = love.graphics.newImage("images/doingsprites.png")

whitesquig2 = love.graphics.newImage("images/doingsprites2.png")

slopedup = love.graphics.newImage("images/slopedtile.png")


slopeddown = love.graphics.newImage("images/slopedtile2.png")




qrightimg = love.graphics.newImage("images/braidmockup.png")

qrightanim = newAnimation(qrightimg, 40, 60, 0.15, 0)
qrightanim:setMode("bounce")

qleftimg = love.graphics.newImage("images/braidmockupleft.png")

qleftanim = newAnimation(qleftimg, 40, 60, 0.15, 0)
qleftanim:setMode("bounce")


--objectimages
images = {stone, wood, tin, red}