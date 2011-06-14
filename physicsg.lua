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
	friction	= gameobject.friction
	
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
			.. ", friction=" 	.. friction
			.. ")"
			)

	-- function should add new items to table intellegently (index)
	body = love.physics.newBody(world, x, y, mass, inertia)
	shape = love.physics.newRectangleShape(body, 0, 0, width, height, angle) -- x,y = 0 because body anchors to center of shape
	shape:setData(objtype)
	shape:setFriction(friction)
	
	table.insert(bodies, body)
	table.insert(shapes, shape)
end

playerDistanceChange = 0

function love.keypressed(key, unicode)

	for i,s in pairs(shapes) do
		if s:getData() == "0" then -- player
			
			if key == "escape" then -- this just doesn't work if you're falling into absolute oblivion :)
				s:getBody():setX(150)
				s:getBody():setY(-100)
			end
			if key == "up" then -- double jumping still effect
				s:getBody():applyImpulse(0,-175)
			end
			if key == "left" then
				playerDistanceChange = -150
			end
			if key == "right" then
				playerDistanceChange = 150
			end
		end
	end
end

function love.keyreleased(key, unicode)
	if key == "left" then
		playerDistanceChange = 0
	end
	if key == "right" then
		playerDistanceChange = 0
	end
end