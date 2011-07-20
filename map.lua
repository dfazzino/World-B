local maps = {}
local gameMapIndex = 1

function generatemap()

	e = love.filesystem.exists( "map.dat" )


	contents, size = love.filesystem.read( "TEST.TXT")

		gameobject = {}
		parsex = 0
        mapIndex = 1
        dataIndex = 1
        maps[mapIndex] = {}

		for token in string.gmatch(contents, "[^%s]+") do
			if token == 'G' or token == 'E' or token == 'P' or token == 'I' or token == 'SZ' or token == 'X' then 
				if gameobject.x ~= nil then
                    maps[mapIndex][dataIndex] = {}
                    maps[mapIndex][dataIndex].data = gameobject
                    dataIndex = dataIndex + 1
                    -- print (gameobject.type)
					gameobject = {}
                    if token == 'X' then
                        mapIndex = mapIndex + 1
                        maps[mapIndex] = {}
                        dataIndex = 1
                    end

				end
				gameobject.type = token
				parsex = 0
			else
				if gameobject.type == 'SZ' then
					if parsex == 0 then gameobject.x = token
					elseif parsex == 1 then gameobject.y = token
					elseif parsex == 2 then gameobject.w = token
					elseif parsex == 3 then gameobject.h = token
					elseif parsex == 4 then gameobject.density = token
					end
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
				end
				parsex = parsex + 1
			end
		end


	return e
end


function ClearMap()

    ClearPlayer()
    ClearEnemies()
    ClearSwarms()
    ClearArrows()
    -- ClearPhysics()

end


function LoadMap ()

    for i, objData in ipairs(maps[gameMapIndex]) do
        if objData.data.type == 'E' then
            -- print ('E')
            myObjIndex = GenerateAnObject(objData.data)
            CreateAnEnemy(myObjIndex)
        end
        if objData.data.type == 'P' then
            -- print ('P')
            myObjIndex = GenerateAnObject(objData.data)
            CreatePlayer(myObjIndex)
        end

        if objData.data.type == 'SZ' then
            CreateSwarmZone(objData.data)

        end
        if objData.data.type == 'G' then
            -- print ('G')
            GenerateAnObject(objData.data)

        end

        if objData.data.type == 'I' then
            -- print ('I')
            GenerateAnObject(objData.data)
        end

    end

    gameMapIndex = gameMapIndex + 1
 
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
		swarmZoneData = GetSZ()
		
		writeObject = (writeObject .. swarmZoneData)

		if writeObject ~= "" then
			writeObject = writeObject .. 'X'
		end
		
		if writeObject ~= false then
			-- debug.debug()
			file:write(writeObject)
		end
		
	-- until object = false
	file:close()
	
end

function DeleteFile ()
	shapes = {}
	bodies = {}	
	ok = love.filesystem.remove( "TEST.TXT" )
	
end


function RestartMap ()

    gameMapIndex = gameMapIndex - 1
    LoadMap()

end
function PrevMap ()

    gameMapIndex = gameMapIndex - 2
    LoadMap()

end