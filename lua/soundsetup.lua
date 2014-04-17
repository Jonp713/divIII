funsound = love.audio.newSource('sounds/fun.ogg', 'static')

love.audio.setPosition(-5, 0, 0)

love.audio.rewind(funsound)
love.audio.play(funsound)