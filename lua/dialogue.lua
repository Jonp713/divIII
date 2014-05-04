dialogue = {}

function dialogue:new (secIn, endSecIn, sequenceIn, objectIn, repeatIn, secretTypeIn, secretSeqIn, hiddenArray)
  o = {
  
  	state = 1,
  	sequence = sequenceIn,
	startTime = 0,
	endTime = 0,
	workingTime = 0,
	workTime = 0,
	started = false,
	restarted = false,
	isCondition = false,
	condition = function() return true end,
	
	hiddenx1 = hiddenArray[1],
	hiddenx2 = hiddenArray[2],
	hiddeny1 = hiddenArray[3],
	hiddeny2 = hiddenArray[4],
	
	charstartx = 0,
	charstarty = 0,
	
	targetObject = objectIn,
	
	finished = false,
	
	startSec = secIn,
	endSec = endSecIn,

	repeatdo = repeatIn,
	secretType = secretTypeIn,
  	secretSeq = secretSeqIn,
	
	safe = true,
	
	sortArray = {
	
	
	},
	
  	modx = 0,
  	modx2 = 0,
  	mody = 0
  
  }  
  setmetatable(o, self)
  self.__index = self
  table.insert(timeevents, o)
  return o
  
end

--sometimes there is a bug...but basically chops up dialogue so i can display it in chunks.....has small bug thats easily fixable (sometimes chops words in half) (Chop number 2 for edits)
function dialogue:chop(dia, stateFor, number)
	
	if(number == 2)then
	
		table.remove(self.sortArray, stateFor)
	
		table.insert(self.sortArray, stateFor, {markers = {}, placements = {}})
	
	else
		
		table.insert(self.sortArray, {markers = {}, placements = {}})
	
	end
	
	for i = 1, #dia do
		
		d = dia:sub(i,i)
	
		if(d == ' ' or i == #dia)then
			
			table.insert(self.sortArray[stateFor].markers, {val = i})
		
		end
		
	end
	
	count = 0	
	countadd = 0
	lastcount = 0
	
	for i = 1, #self.sortArray[stateFor].markers do
		
		if(i==1)then
		
			count = self.sortArray[stateFor].markers[i].val
			
		
		else
			
			count = count + self.sortArray[stateFor].markers[i].val - self.sortArray[stateFor].markers[i -1].val
			
		end
		
		if(count > 26 or i == #self.sortArray[stateFor].markers)then
			
			lastcount = countadd
			countadd = countadd + count
			
			table.insert(self.sortArray[stateFor].placements, {val = countadd, length = count})
			
			count = 1
			
		end

	end
	
end

function dialogue:findLargest(stateFor)
	
	j = 0
	
	for i = 1, #self.sortArray[stateFor].placements do
		
		if(j < self.sortArray[stateFor].placements[i].length)then
			
			j = self.sortArray[stateFor].placements[i].length
			l = i
	
		end
		
	end
	
	return l, j
	
end

function dialogue:checkSafe()
	--safe
	if(self.secretType == 1)then
		if(collisionCheck(player.x, player.y, player.width, player.height, self.hiddenx1, self.hiddeny1, self.hiddenx2 - self.hiddenx1, self.hiddeny2 - self.hiddeny1))then
						
			self.safe = true
			
		else
		
			self.safe = false
			
		end
	end
	--not safe here
	if(self.secretType == 2)then
		if(collisionCheck(player.x, player.y, player.width, player.height, self.hiddenx1, self.hiddeny1, self.hiddenx2 - self.hiddenx1, self.hiddeny2 - self.hiddeny1) ~= true)then

			self.safe = true
			
		else
		
			self.safe = false
			
		end
	end
	--moving not safe
	if(self.secretType == 3)then
		if(collisionCheck(player.x, player.y, player.width, player.height, self.targetObject.x + self.hiddenx1, self.targetObject.y + self.hiddeny1, (self.hiddenx2 - self.hiddenx1), (self.hiddeny2 - self.hiddeny1)) ~= true)then

			self.safe = true
			
		else
		
			self.safe = false
			
		end


	end
	--moving not safe
	if(self.secretType == 4)then
		
		if(collisionCheck(player.x, player.y, player.width, player.height, self.hiddenx1, self.hiddeny1, self.hiddenx2 - self.hiddenx1, self.hiddeny2 - self.hiddeny1))then
						
			self.safe = true
			
		else
		
			self.safe = false
			
		end

	end
	
end

function dialogue:newTalk(dia, stateFor)
	
	l, j = self:findLargest(stateFor)
	
	if(j ~= 0)then
	
		love.graphics.setColor(255,255,255, 200)
	
		love.graphics.rectangle('fill', (self.targetObject.x - (self.sortArray[stateFor].placements[l].length * 3)) + (self.targetObject.width/2) - 20, self.targetObject.y - (#self.sortArray[stateFor].placements * 15) - 30, (self.sortArray[stateFor].placements[l].length * 7.4) + 20, (#self.sortArray[stateFor].placements * 15) + 20)
	
		love.graphics.setColor(0,0,0, 255)		
	
		for i = #self.sortArray[stateFor].placements, 1, -1 do
		
			if(i == 1)then
			
				love.graphics.print(dia:sub(0, self.sortArray[stateFor].placements[i].val - 1), (self.targetObject.x - (self.sortArray[stateFor].placements[i].length * 3)) + (self.targetObject.width/2), self.targetObject.y + ((i - #self.sortArray[stateFor].placements) * 15) - 35)
					
			else
		
				love.graphics.print(dia:sub(self.sortArray[stateFor].placements[i-1].val, self.sortArray[stateFor].placements[i].val - 1), (self.targetObject.x - (self.sortArray[stateFor].placements[i].length * 3)) + (self.targetObject.width/2), self.targetObject.y + ((i - #self.sortArray[stateFor].placements) * 15) - 35)
		
			end
		
		end
	
	end
	
end

function dialogue:talk (dia)

	count = #dia
		
	if(count > 26)then
	
		found = false
	
		for i = count/2, count do
		
			j = dia:sub(i,i)
			
			if(j == ' ' and found == false)then
			
				foundcount = i
				found = true
			end
		
		end
		
		if(found == false)then
		
			foundcount = count
			
		end
	
		count2 = foundcount
		
		self.modx = count2 * 3

		self.modx2 = count2 * 3
		
	end
	
	if(count <= 26)then
		
		count = #dia
	
		self.modx = count * 3
		
	end
	
	self.mody = 20	
	
	if(count > 26)then
	
		love.graphics.setColor(255,255,255, 200)

		love.graphics.rectangle('fill', (self.targetObject.x - self.modx) + (self.targetObject.width/2) - 15, self.targetObject.y - self.mody - 47, (count2 * 7.3) + 30, 52)

		love.graphics.setColor(0, 0, 0, 255)
	
		love.graphics.print(dia:sub(0, count2), (self.targetObject.x - self.modx) + (self.targetObject.width/2), self.targetObject.y - self.mody - 35)
		love.graphics.print(dia:sub(count2 + 1, count), (self.targetObject.x - self.modx2) + (self.targetObject.width/2), self.targetObject.y - self.mody - 20)

  	end
  	if(count <= 26 and count ~= 0)then
  	
  		love.graphics.setColor(255,255,255, 200)

		love.graphics.rectangle('fill', (self.targetObject.x - self.modx) + (self.targetObject.width/2) - 15, self.targetObject.y - self.mody - 28, (count * 7) + 30, 35)

		love.graphics.setColor(0, 0, 0, 255)
  	
  	  	love.graphics.print(dia, (self.targetObject.x - self.modx) + (self.targetObject.width/2), self.targetObject.y - self.mody - 20)
  	
  	end

	love.graphics.setColor(255,255,255)

end


function dialogue:trigger ()

	self:checkSafe()

	if(self.state <= #self.sequence)then
	
		if(self.safe)then
	
			self:newTalk(self.sequence[self.state].words, self.state)
			
		else
			
			self:talk(self.secretSeq[1].words)
			
		end
		
		if(self.started == false)then
		
			if(self.restarted == false)then
			
				self.startTime = math.floor((love.timer.getTime() - gamestartSec) + modifier)
				self.workTime = self.startTime

			end
			
			self.endTime = self.startTime + self.sequence[self.state].time
			self.started = true
			self.restarted = false
		end
		
		if(editorMode or pause)then
			if(backward)then
		
				self.workTime = self.workTime - alldt		
		
			elseif(forward)then
				
				self.workTime = self.workTime + alldt		

			end
		else
			--prevents dialogue from continuing if the player is not safe
			if(self.safe)then
			
				--progresses the dialogue if player is safe
				self.workTime = self.workTime + alldt		
			
			else
				--possible changes for the unsafe text or could change unsafe text talk to a unsafetalk that changes stuff isntead....	
			
			end

		end
		
		if(self.workTime < self.startTime and (self.state - 1) ~= 0 and backward)then
			self.state = self.state - 1
			self.startTime = self.startTime - self.sequence[self.state].time 
			self.started = false
			self.restarted = true
			
		end
		if(self.workTime >= self.endTime)then
			self.started = false
			self.state = self.state + 1
		end

	elseif(self.repeatdo)then
		self.state = 1
	else
		self.finished = true
	end
	
	if(editorMode and editor.hiddenDrag == false and self.finished == false)then
		
		if(self.secretType == 3)then
	        love.graphics.setColor(150, 0, 150, 50)
	        love.graphics.rectangle("fill", self.targetObject.x + self.hiddenx1, self.targetObject.y + self.hiddeny1,  (self.hiddenx2 - self.hiddenx1), (self.hiddeny2 - self.hiddeny1))
	        love.graphics.setColor(255, 255, 255)
			
		end
		if(self.secretType == 2)then
		
	        love.graphics.setColor(150, 0, 0, 50)
	        love.graphics.rectangle("fill", self.hiddenx1, self.hiddeny1, self.hiddenx2 - self.hiddenx1, self.hiddeny2 - self.hiddeny1)
	        love.graphics.setColor(255, 255, 255)
		
		end
		if(self.secretType == 1)then
	        love.graphics.setColor(0, 0, 150, 50)
	        love.graphics.rectangle("fill", self.hiddenx1, self.hiddeny1, self.hiddenx2 - self.hiddenx1, self.hiddeny2 - self.hiddeny1)
	        love.graphics.setColor(255, 255, 255)
		end
	end

end

