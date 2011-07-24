swarmzones = {}
flies = {}
swarmx = 0
fliesx = 0

function CreateSwarmZone(gameobject)

	thisSwarmX = swarmx

   	swarmzones[thisSwarmX] = gameobject
	swarmx = swarmx + 1
	return thisSwarmX

end


function AddFlies()
	
	for i,s in pairs(swarmzones) do		
		-- for j = 0,s.density do
			mygameobject = {}
			mygameobject.type = 'F'
			mygameobject.x = math.random(s.x-10, s.x+10)
			mygameobject.y = math.random(s.y-10, s.y+10)
			mygameobject.mass = 2
			mygameobject.inertia = 0
			mygameobject.width = 20
			mygameobject.height = 20
			mygameobject.angle = 0
			mygameobject.friction = .001

			newFly = {}
			newFly.objIndex = GenerateAnObject(mygameobject)
			--newFly.target = 1
			newFly.target = nil
			newFly.omNomTime = love.timer.getMicroTime( )
			
			table.insert(flies, fliesx, newFly)
		-- end
	end
	
end


function AddFiles(swarmZoneIndex)

	-- for j = 0,swarmzones[swarmZoneIndex].density do
		mygameobject = {}
		mygameobject.type = 'F'
		mygameobject.x = math.random(swarmzones[swarmZoneIndex].x-10, swarmzones[swarmZoneIndex].x+10)
		mygameobject.y = math.random(swarmzones[swarmZoneIndex].y-10, swarmzones[swarmZoneIndex].y+10)
		mygameobject.mass = 2
		mygameobject.inertia = 0
		mygameobject.width = 20
		mygameobject.height = 20
		mygameobject.angle = 0
		mygameobject.friction = .001

		newFly = {}
		newFly.objIndex = GenerateAnObject(mygameobject)
		newFly.target = nil
		newFly.omNomTime = love.timer.getMicroTime( )
		newFly.wingsTime = love.timer.getMicroTime( )
		table.insert(flies, fliesx, newFly)
	-- end
	
end


function GetSZ()
	writezones = ''
	for i,zone in pairs(swarmzones) do
		writezones = (writezones .. 'SZ' .. ' ' .. zone.x .. ' ' .. zone.y .. ' ' .. zone.w .. ' ' .. zone.h .. ' ' .. zone.density .. ' ')
	end

	return writezones

end


function FlyProcessing()

    for i, fly in pairs(flies) do
        GetFlyTarget(fly)
        ProcessImpulses(fly)
        MoveFlies(fly)
        OmNomNom(fly)
    end
end


function GetFlyTarget(thisFly)

	settarget = nil 
    thisFly.target = nil
    thisFly.arrowNum = nil
	arrowset = GetArrows()
    if getTarget then
		for j, arrow in pairs(arrows) do
			print (bodies[thisFly.objIndex]:getX())
			xDistance = bodies[arrow.objIndex]:getX() - bodies[thisFly.objIndex]:getX()
			yDistance = bodies[arrow.objIndex]:getY() - bodies[thisFly.objIndex]:getY()
			xDistSq = xDistance * xDistance
			yDistSq = yDistance * yDistance

			distance = math.sqrt(xDistSq + yDistSq)
			-- if distance < 1000 then
				hypotenuse = math.sqrt((xDistance*xDistance) + (yDistance*yDistance))
				if settarget == nil then
					hldHypotenuse = hypotenuse
					settarget = arrow.objIndex
					arrowNum = j
				else 
					if hypotenuse < hldHypotenuse then
						hldHypotenuse = hypotenuse
						settarget = arrow.objIndex
						arrowNum = j
					end
				end
			-- end
		end
    end

    if settarget ~= nil then
        thisFly.target = settarget
        thisFly.arrowNum = arrowNum
    end
		
end


function ProcessImpulses(thisFly)

    if thisFly.target ~= nil then
        thisFly.wingsTimer = love.timer.getMicroTime( )
        if thisFly.wingsTimer - thisFly.wingsTime > .03 then
            if bodies[thisFly.target]:getX() < bodies[thisFly.objIndex]:getX() then
                dx = -1
            else
                dx = 1
            end
            if bodies[thisFly.target]:getY() < bodies[thisFly.objIndex]:getY() then
                dy = -1
            else
                dy = 1
            end
            ApplyImpulse(thisFly.objIndex, dx , dy )
        end
    end

end


function OmNomNom(thisFly) --ettin' some arrows

	if arrows[1] ~= nil and thisFly.target ~= nil then

		if math.abs(bodies[thisFly.target]:getX() - bodies[thisFly.objIndex]:getX()) < 20 and math.abs(bodies[thisFly.target]:getY() - bodies[thisFly.objIndex]:getY()) < 20 then
			--print ("eating!")
			love.graphics.setColor(255, 255, 0) -- yellow om noms
			love.graphics.print("om nom nom",bodies[thisFly.objIndex]:getX()+5, bodies[thisFly.objIndex]:getY()-15)
			thisFly.omNomTimer = love.timer.getMicroTime( )
			-- print (thisFly.omNomTimer - thisFly.omNomTime)
			if thisFly.omNomTimer - thisFly.omNomTime > 3 then
                SetForRemoval(thisFly.arrowNum)
				thisFly.omNomTime = love.timer.getMicroTime( )
				thisFly.target = nil
                thisFly.arrowNum = nil
			end
		end

	end

end


function MoveFlies(thisFly)  

end


function AdjustFlyObjIndex(objIndex)

	for i, fly in pairs(flies) do
		if fly.objIndex > objIndex then
		--	print ("fly", fly.objIndex, objIndex)
			fly.objIndex = fly.objIndex - 1
            -- debug.debug()
		end
		if fly.target ~= nil then
			if fly.target > objIndex then
				fly.target = fly.target - 1
			end
		end
	end

end


function ClearSwarms()

    flies = {}

end