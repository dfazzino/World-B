--parses and holds map data, gives enemy.lua data
--future: gives data to the following: maplogic, objects, items
require "physicsg"

map = {}

function generatemap()
	
	e = love.filesystem.exists( "map.dat" )


	contents, size = love.filesystem.read( "map.dat")

		gameobject = {}
		objecttype =  string.sub(contents,1,1)
		parsex = 0

		for token in string.gmatch(contents, "[^%s]+") do
			if token == 'N' then 
				if gameobject.x ~= nil then
					GenerateAnObject(gameobject)
				end
				objecttype = {}
				parsex = 0
			else
				if parsex == 0 then gameobject.type = token
				elseif parsex == 1 then gameobject.x = token
				elseif parsex == 2 then gameobject.y = token
				elseif parsex == 3 then gameobject.mass = token
				elseif parsex == 4 then gameobject.inertia = token
				elseif parsex == 5 then gameobject.width = token
				elseif parsex == 6 then gameobject.height = token
				elseif parsex == 7 then gameobject.angle = token
				elseif parsex == 7 then gameobject.friction = token
				end
				parsex = parsex + 1
			end
			
		end
		GenerateAnObject(gameobject)
	return e
end