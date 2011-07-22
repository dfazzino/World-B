physicsg = {}
bodies = {} -- i guess these need to be global?
shapes = {}
world = nil

objectIndex = 0

function CreateWorld()
	world = love.physics.newWorld(-4000, -4000, 4000, 4000)  -- how big is the world, anyway?
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
	shape = love.physics.newRectangleShape(body, 0, 0, width, height) -- x,y = 0 because body anchors to center of shape
	shape:setData(thisIndex)
	shape:setFriction(friction)
	shape:setRestitution(0)
	
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
function ApplyForce(i, ximpulse, yimpulse)

    -- debug.debug()

    bodies[i]:applyForce(ximpulse, yimpulse)

end


function SetAngle(i, angle)

    bodies[i]:setAngle(angle)

end


function GetObject(writex)
	writedata = ""
	
	for i,s in pairs(shapes) do
		if s.shape:getData() ~= 'F' and s.shape:getData() ~= 'A' then 
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


function GetVelocity(objIndex)

    tempx, tempy = bodies[objIndex]:getLinearVelocity()
    tempVect = vector(tempx, tempy)
    return tempVect

end


function RemoveShape (shapeNum)

	-- shapes[shapeNum].shape:destroy()
	table.remove(shapes, shapeNum)
end


function RemoveBody (bodyNum)

	-- bodies[bodyNum]:destroy()
	table.remove(bodies, bodyNum)
	objectIndex = objectIndex - 1
	
end


function AdjustObjIndexes (removedObjIndexes)
	for i, thisObjIndex in pairs(removedObjIndexes) do
        -- print ('adjustingFlyObj')
		AdjustFlyObjIndex(thisObjIndex)
        -- print ('adjustingArrowObj')
		AdjustArrowObjIndex(thisObjIndex)
        -- print ('adjustingEnemyObj')
		AdjustEnemyObjIndex(thisObjIndex)
        --debug.debug()
	end

end


function remve(obj1, obj2, contact)

	if shapes[obj1] ~= nil and shapes[obj2] ~= nil then 

        if (shapes[obj2].objType == 'P' and (shapes[obj1].objType == 'G' or shapes[obj1].objType == 'I' or shapes[obj2].objType == 'A' )) then
			collx, colly = contact:getNormal()
			if collx == 0 and colly == -64 then
				SetPlayerState(1)
			end
		end
		
        if (shapes[obj1].objType == 'P' and (shapes[obj2].objType == 'G' or shapes[obj2].objType == 'I' or shapes[obj2].objType == 'A')) then
			collx, colly = contact:getNormal()
			if collx == 0 and colly == 64 then
				SetPlayerState(1)
			end			
		end

	end

end


function add(obj1, obj2, contact)
	
	if shapes[obj1] ~= nil and shapes[obj2] ~= nil then 
	
		if ((shapes[obj1].objType == 'G' or shapes[obj1].objType == 'I') or shapes[obj1].objType == 'A') and shapes[obj2].objType == 'A' then
	        arrX, arrY = contact:getPosition( )
			bodies[obj2]:setMass(0,0,0,0)
			bodies[obj2]:putToSleep()
		end	
		if ((shapes[obj2].objType == 'G' or shapes[obj2].objType == 'I') or shapes[obj2].objType == 'A') and shapes[obj1].objType == 'A' then
	        arrX, arrY = contact:getPosition( )
			bodies[obj1]:setMass(0,0,0,0)
			bodies[obj1]:putToSleep()
		end	

        if (shapes[obj2].objType == 'P' and (shapes[obj1].objType == 'G' or shapes[obj1].objType == 'I' or shapes[obj1].objType == 'A')) then
			collx, colly = contact:getNormal()
			if collx == 0 and colly == -64 then
				SetPlayerState(0)
			end
			
		end
        if (shapes[obj1].objType == 'P' and (shapes[obj2].objType == 'G' or shapes[obj2].objType == 'I' or shapes[obj2].objType == 'A')) then
			collx, colly = contact:getNormal()
			if collx == 0 and colly == 64 then
				SetPlayerState(0)
			end			
		end
	end
end


function persist(obj1,obj2, contact)

		-- if (shapes[obj1].objType == 'F' and shapes[obj2].objType == 'A') or (shapes[obj1].objType == 'A' and shapes[obj1].objType == 'F') then
    
            -- if shapes[obj1].objType == 'A' then
                -- Omnomnom(obj1, obj2)
            -- else
                -- Omnomnom(obj2, obj1)
            -- end
        -- end

end


function ClearPhysics()

    -- for i, shape in pairs(shapes) do
        -- RemoveShape(i)
    -- end    
    -- for i, body in pairs(bodies) do
        -- RemoveBody(i)
    -- end
    shapes = {}
    bodies = {}
    objectIndex = 0

end