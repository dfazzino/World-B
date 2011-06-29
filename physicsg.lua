physicsg = {}
bodies = {} -- i guess these need to be global?
shapes = {}
world = nil

objectIndex = 0

function CreateWorld()
	world = love.physics.newWorld(-2000, -2000, 2000, 2000)  -- how big is the world, anyway?
	world:setGravity(0, 700)
	world:setMeter(64)
	world:setCallbacks( add, persist, remve, result )
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
	shape:setData(thisIndex)
	shape:setFriction(friction)
	
	bodies[thisIndex] = body 
	shapes[thisIndex] = {}
	shapes[thisIndex].shape = shape
	shapes[thisIndex].objType = gameobject.type

    return thisIndex

end

function ApplyImpulse(i, ximpulse, yimpulse)

    -- debug.debug()

    bodies[i]:applyImpulse(ximpulse, yimpulse)

end


function GetObject(writex)
	writedata = ""
	
	for i,s in pairs(shapes) do
		if s.shape:getData() ~= 'F' then 
			x1, y1, x2, y2, x3, y3, x4, y4 = s.shape:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
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
		
			writedata =  (writedata .. s.objType .. ' ' .. bodies[i]:getX() .. ' ' .. bodies[i]:getY() .. ' ' .. bodies[i]:getMass() .. ' ' .. bodies[i]:getInertia() .. ' ' .. boxwidth.. ' ' .. boxheight .. ' ' .. 0 .. ' ' .. .25 .. ' ')
		end
	end
	
	return(writedata)
end


function RemoveShape (shapeNum)

	print ("shapenum " .. shapeNum)
	shapes[shapeNum] = nil
	
end


function RemoveBody (bodyNum)

	print ("bodynum " .. bodyNum)
	bodies[bodyNum] = nil

end


function remve(obj1, obj2, contact)

end


function add(obj1, obj2, contact)
	
	if shapes[obj1] ~= nil and shapes[obj2] ~= nil then
	
		if (shapes[obj1].objType == 'G' or shapes[obj1].objType == 'A') and shapes[obj2].objType == 'A' then
			PlaceArrow(obj2)
	        arrX, arrY = contact:getPosition( )
			bodies[obj2]:setMass(0,0,0,0)
			bodies[obj2]:putToSleep()
		end	
	end
end
