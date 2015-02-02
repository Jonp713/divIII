

--importing images
stone = love.graphics.newImage("images/testbox.png")
wood = love.graphics.newImage("images/wood.png")
tin = love.graphics.newImage("images/tin.png")
red = love.graphics.newImage("images/red.png")
noteblock = love.graphics.newImage("images/noteblock.png")
noteblock2 = love.graphics.newImage("images/noteblock2.png")
bomb = love.graphics.newImage("images/bomb.png")


--blocks
whitesquig = love.graphics.newImage("images/doingsprites.png")
whitesquig2 = love.graphics.newImage("images/doingsprites2.png")
slopedup = love.graphics.newImage("images/slopedtile.png")
slopeddown = love.graphics.newImage("images/slopedtile2.png")
grass = love.graphics.newImage("nimages/grassblock.png")
dirt = love.graphics.newImage("nimages/dirt.png")

pinkoutwall = love.graphics.newImage("nimages/pinkoutwall.png")
pinkwindow = love.graphics.newImage("nimages/pinkwindow.png")
pinkinwall = love.graphics.newImage("nimages/pinkinwall.png")

hotelcarpet = love.graphics.newImage("nimages/hotelcarpet2.png")
hotelcarpetleft = love.graphics.newImage("nimages/hotelcarpetleft.png")
hotelcarpetright = love.graphics.newImage("nimages/hotelcarpetright.png")

darkwood = love.graphics.newImage("nimages/darkwood.png")
darkwooddarker = love.graphics.newImage("nimages/darkwooddarker.png")
darkwoodright = love.graphics.newImage("nimages/darkwoodright.png")
darkwoodleft = love.graphics.newImage("nimages/darkwoodleft.png")
darkwoodup = love.graphics.newImage("nimages/darkwoodup.png")
darkwooddown = love.graphics.newImage("nimages/darkwooddown.png")
darkwoodlefttopcorner = love.graphics.newImage("nimages/darkwoodlefttopcorner.png")
darkwoodrighttopcorner = love.graphics.newImage("nimages/darkwoodrighttopcorner.png")
darkwoodleftbottomcorner = love.graphics.newImage("nimages/darkwoodleftbottomcorner.png")
darkwoodrightbottomcorner = love.graphics.newImage("nimages/darkwoodrightbottomcorner.png")


gravel = love.graphics.newImage("nimages/possiblegravel.png")
travelgravel = love.graphics.newImage("nimages/graveltravel.png")
travelgravel2 = love.graphics.newImage("nimages/graveltravel2.png")

--objects
tree = love.graphics.newImage("nimages/tree1.png")
tree1 = love.graphics.newImage("nimages/tree2.png")
tree2 = love.graphics.newImage("nimages/tree3.png")
hoteldoor = love.graphics.newImage("nimages/hoteldoor.png")
bench1 = love.graphics.newImage("nimages/bench.png")
lamp = love.graphics.newImage("nimages/lamp.png")



qrightimg = love.graphics.newImage("images/braidmockup.png")

qrightanim = newAnimation(qrightimg, 40, 60, 0.15, 0)
qrightanim:setMode("bounce")

qleftimg = love.graphics.newImage("images/braidmockupleft.png")

qleftanim = newAnimation(qleftimg, 40, 60, 0.15, 0)
qleftanim:setMode("bounce")


--objectimages
images = {tree, tree1, tree2, hoteldoor, bench1, lamp}

blocks = {gravel, darkwood, hotelcarpet, dirt, grass, pinkoutwall, pinkwindow, pinkinwall, travelgravel, travelgravel2, darkwooddarker, darkwoodup, darkwoodright, darkwooddown, darkwoodleft, darkwoodlefttopcorner, darkwoodrighttopcorner , darkwoodleftbottomcorner , darkwoodrightbottomcorner, hotelcarpetleft, hotelcarpetright}