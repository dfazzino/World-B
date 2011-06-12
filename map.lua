--parses and holds map data, gives enemy.lua data
--future: gives data to the following: maplogic, objects, items
require "physicsg"

map = {}

function generatemap()

	CreateWorld()
	
	e = love.filesystem.exists( "map.dat" )

	if e == true then	
		contents, size = love.filesystem.read( "map.dat", 22 )
	end
	gameobject = {}
	objecttype =  string.sub(contents,1,1)
	parsex = 0
	for token in string.gmatch(contents, "[^%s]+") do
		if parsex == 0 then gameobject.type = token
		elseif parsex == 1 then gameobject.x = token
		elseif parsex == 2 then gameobject.y = token
		elseif parsex == 3 then gameobject.mass = token
		elseif parsex == 4 then gameobject.inertia = token
		elseif parsex == 5 then gameobject.width = token
		elseif parsex == 6 then gameobject.height = token
		elseif parsex == 7 then gameobject.angle = token
		
		end
		print (parsex)
		parsex = parsex + 1

	end

	GenerateAnObject(gameobject)

	return e
end