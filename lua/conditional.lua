conditional = {}

function conditional:new (conditionIn, actionIn, repeatIn)
  o = {	  	
  	state = 1,
	started = false,
		
	condition = conditionIn,
	
	repeaty = repeatIn,
	finished = false,
	
	action = actionIn
	
  
  }  
  setmetatable(o, self)
  self.__index = self
	table.insert(conditionals, o)	
	
  return o
end