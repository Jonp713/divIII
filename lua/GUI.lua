function playGUI()	
	
	notes:draw()

	love.graphics.setColor(255,255,255, 200)

	love.graphics.rectangle('fill', 1100, 5, 170, 35)
	
	love.graphics.rectangle('fill', 0, 0, 20, 20)
	

	love.graphics.setColor(0,0,0)

	love.graphics.print(currentMinute..' O\' clock', 1120, 22)
	love.graphics.print('Total Seconds: '..currentSec , 1120, 10)
	
	love.graphics.print('n', 4, 2)
	

	love.graphics.setColor(255,255,255)
	
end

