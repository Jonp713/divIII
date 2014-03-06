function collisionCheckImage(object1, object2)

	c1x = object1.x
	c1y = object1.y
	
	c2x = object1.x + object1.width
	c2y = object1.y + object1.height
	
	
	p1x = object2.x
	p1y = object2.y
	
	p2x = object2.x + object2.width
	p2y = object2.y + object2.height
	
	
	if(c2x > p1x and c2x < p2x and c2y > p1y and c2y < p2y) then
		
		return true -- 4 ,}
	
	end
	if(c2x > p1x and c2x < p2x and c1y > p1y and c1y < p2y) then
		
		return true -- 2 '}
	
	end
	if(c1x > p1x and c1x < p2x and c1y > p1y and c1y < p2y) then
		
		return true -- 1 {'
	
	end
	if(c1x > p1x and c1x < p2x and c2y > p1y and c2y < p2y) then
		
		return true -- 3 {,
	
	end


end


function collisionCheckBox(x1, y1, length1, height1, x2, y2, length2, height2, drawx, drawy)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	oldp1y = drawy
	oldp2y = drawy + height1
	oldp1x = drawx
	oldp2x = drawx + length1
	
	if((p1x > c1x and p1x < c2x) or (p2x > c1x and p2x < c2x))then
		if((p1y > c1y and p1y < c2y) or (p2y > c1y and p2y < c2y))then			
			
			-- going right
			if(x1 > drawx)then
			
				correction = c1x - oldp2x
			
			end
			-- going left
			if(x1 < drawx)then
			
				correction = c2x - oldp1x
			
			end
			-- going down
			if(y1 > drawy)then
			
				correction = c1y - oldp2y
							
			end
			-- going up
			if(y1 < drawy)then
			
				correction = c2y - oldp1y
			end
			
			return true, correction
			
		end
	end

--[[
	if(c2x > p1x and c2x < p2x and c2y > p1y and c2y < p2y) then
		
		return true -- 4 ,}
	
	end
	if(c2x > p1x and c2x < p2x and c1y > p1y and c1y < p2y) then
		
		return true -- 2 '}
	
	end
	if(c1x > p1x and c1x < p2x and c1y > p1y and c1y < p2y) then
		
		return true -- 1 {'
	
	end
	if(c1x > p1x and c1x < p2x and c2y > p1y and c2y < p2y) then
		
		return true -- 3 {,
	
	end
]]

end

function collisionCheckOneWay(x1, y1, length1, height1, x2, y2, length2, height2, drawx, drawy)

	p1x = x1
	p1y = y1
	
	p2x = x1 + length1
	p2y = y1 + height1	
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2
	
	oldp1y = drawy
	oldp2y = drawy + height1
	oldp1x = drawx
	oldp2x = drawx + length1	
	
	if((p1x >= c1x and p1x <= c2x) or (p2x >= c1x and p2x <= c2x))then
	-- if the previous location was above the collide y location
		if(oldp2y - 1 < c1y)then
				
			if((p1y >= c1y and p1y <= c2y) or (p2y >= c1y and p2y <= c2y))then
				return true, c1y - oldp2y

		 
			end
		end
	end

end

function collisionCheckPoint(x1, y1, radius, x2, y2, length2, height2)

	p1x = x1 - radius
	p1y = y1 - radius
	
	p2x = x1 + radius
	p2y = y1 + radius
	
	c1x = x2
	c1y = y2
	
	c2x = x2 + length2
	c2y = y2 + height2


	if(c2x > p1x and c2x < p2x and c2y > p1y and c2y < p2y) then
		
		return true -- 4 ,}
	
	end
	if(c2x > p1x and c2x < p2x and c1y > p1y and c1y < p2y) then
		
		return true -- 2 '}
	
	end
	if(c1x > p1x and c1x < p2x and c1y > p1y and c1y < p2y) then
		
		return true -- 1 {'
	
	end
	if(c1x > p1x and c1x < p2x and c2y > p1y and c2y < p2y) then
		
		return true -- 3 {,
	
	end


end


function moveTowards(leader, follower)

	if(follower.x < leader.x)then
		follower.x = follower.x + 5
	end
	if(follower.x > leader.x)then
		follower.x = follower.x - 5
	end
	if(follower.y < leader.y)then
		follower.y = follower.y + 5
	end
	if(follower.y > leader.y)then
		follower.y = follower.y - 5
	end
end

function otherKeyChecks()
	if love.keyboard.isDown('f') then

		love.window.setFullscreen(true, "desktop")

	end

	if love.keyboard.isDown('d') then

		love.window.setFullscreen(false, "desktop")
		
	end
	
	if love.keyboard.isDown('l') then
		nerds = true
		
	end
	
	if(love.keyboard.isDown('z') == false)then
		zpressable = true
	end
	if(love.keyboard.isDown('q') == false)then
		qpressable = true
	end
	if(love.keyboard.isDown('w') == false)then
		wpressable = true
	end
	if(love.keyboard.isDown('a') == false)then
		apressable = true
	end
	if(love.keyboard.isDown('s') == false)then
		spressable = true
	end
	if(love.keyboard.isDown('d') == false)then
		dpressable = true
	end

end

--[[
   Save Table to File
   Load Table from File
   v 1.0
   
   Lua 5.2 compatible
   
   Only Saves Tables, Numbers and Strings
   Insides Table References are saved
   Does not save Userdata, Metatables, Functions and indices of these
   ----------------------------------------------------
   table.save( table , filename )
   
   on failure: returns an error msg
   
   ----------------------------------------------------
   table.load( filename or stringtable )
   
   Loads a table that has been saved via the table.save function
   
   on success: returns a previously saved table
   on failure: returns as second argument an error msg
   ----------------------------------------------------
   
   Licensed under the same terms as Lua itself.
]]--
do
   -- declare local variables
   --// exportstring( string )
   --// returns a "Lua" portable version of the string
   local function exportstring( s )
      return string.format("%q", s)
   end

   --// The Save Function
   function table.save(  tbl,filename )
      local charS,charE = "   ","\n"
      local file,err = io.open( filename, "wb" )
      if err then return err end

      -- initiate variables for save procedure
      local tables,lookup = { tbl },{ [tbl] = 1 }
      file:write( "return {"..charE )

      for idx,t in ipairs( tables ) do
         file:write( "-- Table: {"..idx.."}"..charE )
         file:write( "{"..charE )
         local thandled = {}

         for i,v in ipairs( t ) do
            thandled[i] = true
            local stype = type( v )
            -- only handle value
            if stype == "table" then
               if not lookup[v] then
                  table.insert( tables, v )
                  lookup[v] = #tables
               end
               file:write( charS.."{"..lookup[v].."},"..charE )
            elseif stype == "string" then
               file:write(  charS..exportstring( v )..","..charE )
            elseif stype == "number" then
               file:write(  charS..tostring( v )..","..charE )
            end
         end

         for i,v in pairs( t ) do
            -- escape handled values
            if (not thandled[i]) then
            
               local str = ""
               local stype = type( i )
               -- handle index
               if stype == "table" then
                  if not lookup[i] then
                     table.insert( tables,i )
                     lookup[i] = #tables
                  end
                  str = charS.."[{"..lookup[i].."}]="
               elseif stype == "string" then
                  str = charS.."["..exportstring( i ).."]="
               elseif stype == "number" then
                  str = charS.."["..tostring( i ).."]="
               end
            
               if str ~= "" then
                  stype = type( v )
                  -- handle value
                  if stype == "table" then
                     if not lookup[v] then
                        table.insert( tables,v )
                        lookup[v] = #tables
                     end
                     file:write( str.."{"..lookup[v].."},"..charE )
                  elseif stype == "string" then
                     file:write( str..exportstring( v )..","..charE )
                  elseif stype == "number" then
                     file:write( str..tostring( v )..","..charE )
                  end
               end
            end
         end
         file:write( "},"..charE )
      end
      file:write( "}" )
      file:close()
   end
   
   --// The Load Function
   function table.load( sfile )
      local ftables,err = loadfile( sfile )
      if err then return _,err end
      local tables = ftables()
      for idx = 1,#tables do
         local tolinki = {}
         for i,v in pairs( tables[idx] ) do
            if type( v ) == "table" then
               tables[idx][i] = tables[v[1]]
            end
            if type( i ) == "table" and tables[i[1]] then
               table.insert( tolinki,{ i,tables[i[1]] } )
            end
         end
         -- link indices
         for _,v in ipairs( tolinki ) do
            tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
         end
      end
      return tables[1]
   end
-- close do
end

-- ChillCode


function table.show(t, name, indent)
   local cart     -- a container
   local autoref  -- for self references

   --[[ counts the number of elements in a table
   local function tablecount(t)
      local n = 0
      for _, _ in pairs(t) do n = n+1 end
      return n
   end
   ]]
   -- (RiciLake) returns true if the table is empty
   local function isemptytable(t) return next(t) == nil end

   local function basicSerialize (o)
      local so = tostring(o)
      if type(o) == "function" then
         local info = debug.getinfo(o, "S")
         -- info.name is nil because o is not a calling level
         if info.what == "C" then
            return string.format("%q", so .. ", C function")
         else 
            -- the information is defined through lines
            return string.format("%q", so .. ", defined in (" ..
                info.linedefined .. "-" .. info.lastlinedefined ..
                ")" .. info.source)
         end
      elseif type(o) == "number" or type(o) == "boolean" then
         return so
      else
         return string.format("%q", so)
      end
   end

   local function addtocart (value, name, indent, saved, field)
      indent = indent or ""
      saved = saved or {}
      field = field or name

      cart = cart .. indent .. field

      if type(value) ~= "table" then
         cart = cart .. " = " .. basicSerialize(value) .. ";\n"
      else
         if saved[value] then
            cart = cart .. " = {}; -- " .. saved[value] 
                        .. " (self reference)\n"
            autoref = autoref ..  name .. " = " .. saved[value] .. ";\n"
         else
            saved[value] = name
            --if tablecount(value) == 0 then
            if isemptytable(value) then
               cart = cart .. " = {};\n"
            else
               cart = cart .. " = {\n"
               for k, v in pairs(value) do
                  k = basicSerialize(k)
                  local fname = string.format("%s[%s]", name, k)
                  field = string.format("[%s]", k)
                  -- three spaces between levels
                  addtocart(v, fname, indent .. "   ", saved, field)
               end
               cart = cart .. indent .. "};\n"
            end
         end
      end
   end

   name = name or "__unnamed__"
   if type(t) ~= "table" then
      return name .. " = " .. basicSerialize(t)
   end
   cart, autoref = "", ""
   addtocart(t, name, indent)
   return cart .. autoref
end


function string:split( inSplitPattern, outResults )
  if not outResults then
    outResults = { }
  end
  local theStart = 1
  local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  while theSplitStart do
    table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
    theStart = theSplitEnd + 1
    theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  end
  table.insert( outResults, string.sub( self, theStart ) )
  return outResults
end
