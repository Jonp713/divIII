images = {}

--importing images
stone = love.graphics.newImage("images/testbox.png")
wood = love.graphics.newImage("images/wood.png")
tin = love.graphics.newImage("images/tin.png")
red = love.graphics.newImage("images/red.png")


qrightimg = love.graphics.newImage("images/char1right.png")

qrightanim = newAnimation(qrightimg, 23, 28, 0.15, 0)
qrightanim:setMode("bounce")

qleftimg = love.graphics.newImage("images/char1left.png")

qleftanim = newAnimation(qleftimg, 23, 28, 0.15, 0)
qleftanim:setMode("bounce")