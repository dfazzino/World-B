--parses and holds map data, gives enemy.lua data
--future: gives data to the following: maplogic, objects, items
require "physicsg"

map = {}

function generatemap()

	e = love.filesystem.exists( "map.dat" )

	if e == true then	
		contents, size = love.filesystem.read( "map.dat", 19 )
	end

	objecttype =  string.sub(contents,1,1)


		gameobject = {}
		gameobject.type = string.sub(contents,1,1)
		gameobject.x = string.sub(contents,2,6)
		gameobject.y = string.sub(contents,7,11)
		gameobject.mass = string.sub(contents,12,15)
		gameobject.size = string.sub(contents,16,19)

		GenerateAnObject(gameobject)

	return e
end