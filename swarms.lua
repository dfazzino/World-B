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
		for j = 0,s.density do
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
		end
	end
	
end


function AddFiles(swarmZoneIndex)

	for j = 0,swarmzones[swarmZoneIndex].density do
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
		table.insert(flies, fliesx, newFly)
	end
	
end


function MoveFlies (dt)

	if arrows[0] ~= nil then
	
		first = true
		
		for i,fly in pairs(flies) do
			
			if fly.target == nil or ArrowExists(fly.target) == false then
				-- print(i .. " has nil target")
				AttackArrow(fly)
				-- print(i .. " has target " .. fly.target)
			end
			
			if arrows[0] ~= nil then
				if first then
					lastFlyX = 0
					lastFlyY = 0
					first = false
				end
				dx = bodies[fly.target]:getX() - bodies[fly.objIndex]:getX() - math.random(-20,20)
				dy = bodies[fly.target]:getY() - bodies[fly.objIndex]:getY() - math.random(0,20)
				-- dx = bodies[fly.target]:getX() - bodies[fly.objIndex]:getX()
	--			dy = bodies[fly.target]:getY() - bodies[fly.objIndex]:getY()
	--			ApplyImpulse(fly.objIndex, (math.random(0,5)+dx)*dt/3, (math.random(0,7)+dy)*dt/3)
				ApplyImpulse(fly.objIndex, dx*dt/3, dy*dt)
				omNomNom(fly)
				lastFlyX = bodies[fly.objIndex]:getX()
				lastFlyY = bodies[fly.objIndex]:getY()
			end
		end
	end
	
end


function AttackArrow(thisFly)

	settarget = nil
	arrowset = GetArrows()
		
		if arrowset ~= false then
			for j, arrow in pairs(arrowset) do
				xDistance = bodies[arrow.objIndex]:getX() - bodies[thisFly.objIndex]:getX()
				yDistance = bodies[arrow.objIndex]:getY() - bodies[thisFly.objIndex]:getY()
				hypotenuse = math.sqrt((xDistance*xDistance) + (yDistance*yDistance))
				if settarget == nil then
					hldHypotenuse = hypotenuse
					settarget = arrow.objIndex
					arrowNum = j
					--debug.debug()
				else 
					if hypotenuse < hldHypotenuse then
						hldHypotenuse = hypotenuse
						settarget = arrow.objIndex
						--debug.debug()
					end
				end
			end
			if settarget == nil then
				thisFly.target = 1
				thisFly.arrowNum = arrowNum
				
			else
				thisFly.target = settarget
				thisFly.arrowNum = arrowNum
				
				--debug.debug()
			end
		end
		
end


function omNomNom(thisFly)
	
	if arrows[0] ~= nil and thisFly.target ~= nil then
		if math.abs(bodies[thisFly.target]:getX() - bodies[thisFly.objIndex]:getX()) < 20 and math.abs(bodies[thisFly.target]:getY() - bodies[thisFly.objIndex]:getY()) < 20 then
			--print ("eating!")
			love.graphics.setColor(255, 255, 0) -- yellow om noms
			love.graphics.print("om nom nom",bodies[thisFly.objIndex]:getX()+5, bodies[thisFly.objIndex]:getY()-15)
			thisFly.omNomTimer = love.timer.getMicroTime( )
			-- print (thisFly.omNomTimer - thisFly.omNomTime)
			if thisFly.omNomTimer - thisFly.omNomTime > 3 then
                SetForRemoval(thisFly.arrowNum)
				thisFly.omNomTime = love.timer.getMicroTime( )
				-- thisFly.target = nil
			end
		end

	end

end


function GetSZ()
	writezones = ''
	for i,zone in pairs(swarmzones) do
		writezones = (writezones .. 'SZ' .. ' ' .. zone.x .. ' ' .. zone.y .. ' ' .. zone.w .. ' ' .. zone.h .. ' ' .. zone.density .. ' ')
	end

	return writezones

end


function CheckFlyTargets()

    for i,fly in pairs(flies) do
       -- print (ArrowExists(fly.arrowNum))
		if fly.arrowNum ~= nil then
		   if not ArrowExists(fly.arrowNum) then
				fly.target = nil
				fly.arrowNum = nil
				-- debug.debug()
		   end
		end
    end

end


function AdjustFlyObjIndex(objIndex)

	for i, fly in pairs(flies) do
		if fly.objIndex > objIndex then
			fly.objIndex = fly.objIndex - 1
		end
	end

end