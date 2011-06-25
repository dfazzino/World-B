physicsg = {}
bodies = {} -- i guess these need to be global?
shapes = {}
world = nil

objectIndex = 0

function CreateWorld()
	world = love.physics.newWorld(-2000, -2000, 2000, 2000)  -- how big is the world, anyway?
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

	-- print(	"Created obj " 	
			-- .. objtype 
			-- .. " (x=" 		.. x 
			-- .. ", y=" 		.. y 
			-- .. ", m=" 	.. mass 
			-- .. ", i=" .. inertia 
			-- .. ", w=" 	.. width 
			-- .. ", h=" 	.. height
			-- .. ", a=" 	.. angle
			-- .. ", f=" 	.. friction
			-- .. ", idx=" 	.. thisIndex
			-- .. ")"
			-- )

	body = love.physics.newBody(world, x, y, mass, inertia)
	shape = love.physics.newRectangleShape(body, 0, 0, width, height, angle) -- x,y = 0 because body anchors to center of shape
	shape:setData(objtype)
	shape:setFriction(friction)
	
	bodies[thisIndex] = body 
	shapes[thisIndex] = shape

    return thisIndex

end

function ApplyImpulse(i, ximpulse, yimpulse)

    -- debug.debug()

    bodies[i]:applyImpulse(ximpulse, yimpulse)

end


function GetObject(writex)
	writedata = ""
	
	for i,s in pairs(shapes) do
		if s:getData() ~= 'F' then 
			x1, y1, x2, y2, x3, y3, x4, y4 = s:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
			if x3 < x2 then
				tempx = x2
				x2 = x3
				x3 = tempx
			end
			if y2 < y1 then
				tempx = y1
				y1 = y2
				y2 = tempx
			end
			boxwidth = x3 - x2 --calculate the width of the box
			boxheight = y2 - y1 --calculate the height of the box
		
			writedata =  (writedata .. s:getData() .. ' ' .. bodies[i]:getX() .. ' ' .. bodies[i]:getY() .. ' ' .. bodies[i]:getMass() .. ' ' .. bodies[i]:getInertia() .. ' ' .. boxwidth.. ' ' .. boxheight .. ' ' .. 0 .. ' ' .. .25 .. ' ')
		end
	end
	
	return(writedata)
end