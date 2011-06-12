physicsg = {}
bodies = {} -- i guess these need to be global?
shapes = {}
world = nil

function CreateWorld()
	world = love.physics.newWorld(-650, -650, 650, 650)  -- how big is the world, anyway?
	world:setGravity(0, 700)
	world:setMeter(64)
end

function GenerateAnObject(gameobject)

	--x, y, mass, inertia, width, height, angle

	objtype		= gameobject.type
	x			= gameobject.x
	y	 		= gameobject.y
	mass 		= gameobject.mass
	inertia		= gameobject.inertia
	width		= gameobject.width
	height		= gameobject.height
	angle		= gameobject.angle

	-- objtype		= "test type"
	-- x		= 300
	-- y 		= 300
	-- mass 		= 10
	-- inertia 	= 0
	-- width		= 100
	-- height		= 20
	-- angle		= 0



	print(	"you sent me an object " 	
			.. objtype 
			.. " (x=" 		.. x 
			.. ", y=" 		.. y 
			.. ", mass=" 	.. mass 
			.. ", inertia=" .. inertia 
			.. ", width=" 	.. width 
			.. ", height=" 	.. height
			.. ", angle=" 	.. angle
			.. ")"
			)

	-- function should add new items to table intellegently (index)
	bodies[0] = love.physics.newBody(world, x, y, mass, inertia)
	shapes[0] = love.physics.newRectangleShape(bodies[0], 0, 0, width, height, angle) -- x,y = 0 because body anchors to center of shape
	shapes[0]:setData(objtype)

end