function generatemap()

	e = love.filesystem.exists( "map.dat" )


	contents, size = love.filesystem.read( "TEST.TXT")

		gameobject = {}
		parsex = 0

		for token in string.gmatch(contents, "[^%s]+") do
			if token == 'G' or token == 'E' or token == 'P' or token == 'I' or token == 'X' then 
				if gameobject.x ~= nil then
					myObjIndex = GenerateAnObject(gameobject)
                    if gameobject.type == 'E' then
                        CreateAnEnemy(myObjIndex)
                    end
                    if gameobject.type == 'P' then
                        CreatePlayer(myObjIndex)
                    end
				end
				gameobject.type = token
				parsex = 0
			else
				if parsex == 0 then gameobject.x = token
				elseif parsex == 1 then gameobject.y = token
				elseif parsex == 2 then gameobject.mass = token
				elseif parsex == 3 then gameobject.inertia = token
				elseif parsex == 4 then gameobject.width = token
				elseif parsex == 5 then gameobject.height = token
				elseif parsex == 6 then gameobject.angle = token
				elseif parsex == 7 then gameobject.friction = token 
				end
				parsex = parsex + 1
			end

		end
	return e
end


function writemap ()

	writex = 0
	file = love.filesystem.newFile("TEST.TXT")
	ok = file:open('w')
	-- print (ok)
	-- contents = file:read()
	-- print (contents) 
	-- debug.debug()
	-- repeat
		
		writeObject = GetObject(writex)
		print(writeObject)
		if writeObject ~= false then
			-- debug.debug()
			file:write(writeObject)
		end
		
	-- until object = false
	file:close()
	
end