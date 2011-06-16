physicsg = {}
bodies = {} -- i guess these need to be global?
shapes = {}
world = nil

objectIndex = 0

function CreateWorld()
	world = love.physics.newWorld(-650, -650, 650, 650)  -- how big is the world, anyway?
	world:setGravity(0, 700)
	world:setMeter(64)
end

function GenerateAnObject(gameobject)

    thisIndex = objectIndex
    objectIndex = objectIndex + 1

	objtype		= gameobject.type
	x			= gameobject.x
	y	 		= gameobject.y
	mass 		= gameobject.mass
	inertia		= gameobject.inertia
	width		= gameobject.width
	height		= gameobject.height
	angle		= gameobject.angle
	friction	= gameobject.friction

	print(	"you sent me an object " 	
			.. objtype 
			.. " (x=" 		.. x 
			.. ", y=" 		.. y 
			.. ", mass=" 	.. mass 
			.. ", inertia=" .. inertia 
			.. ", width=" 	.. width 
			.. ", height=" 	.. height
			.. ", angle=" 	.. angle
			.. ", friction=" 	.. friction
			.. ")"
			)

	-- function should add new items to table intellegently (index)
	body = love.physics.newBody(world, x, y, mass, inertia)
	shape = love.physics.newRectangleShape(body, 0, 0, width, height, angle) -- x,y = 0 because body anchors to center of shape
	shape:setData(objtype)
	shape:setFriction(friction)
	
	table.insert(bodies,thisIndex, body)
	table.insert(shapes,thisIndex, shape)

    return thisIndex

end

function ApplyImpulse(i, ximpulse, yimpulse)

    -- debug.debug()

    bodies[i]:applyImpulse(ximpulse, yimpulse)

end