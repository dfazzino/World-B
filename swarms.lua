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
		
		table.insert(flies, fliesx, newFly)
	end
end

function MoveFlies (dt)

	if table.getn(arrows) > 0 then
	
		first = true
		
		for i,fly in pairs(flies) do
			
			if fly.target == nil then
				print(i .. " has nil target")
				AttackArrow(fly)
				print(i .. " has target " .. fly.target)
			end
			if first then
				lastFlyX = 0
				lastFlyY = 0
				first = false
			end
			dx = bodies[fly.target]:getX() - bodies[fly.objIndex]:getX() - math.random(-20,20)
			dy = bodies[fly.target]:getY() - bodies[fly.objIndex]:getY() - math.random(0,20)
--			dx = bodies[fly.target]:getX() - bodies[fly.objIndex]:getX()
--			dy = bodies[fly.target]:getY() - bodies[fly.objIndex]:getY()
--			ApplyImpulse(fly.objIndex, (math.random(0,5)+dx)*dt/3, (math.random(0,7)+dy)*dt/3)
			ApplyImpulse(fly.objIndex, dx*dt/3, dy*dt)
			
			lastFlyX = bodies[fly.objIndex]:getX()
			lastFlyY = bodies[fly.objIndex]:getY()
		end
	end
end

function omNomNom()
	
	for i,fly in pairs(flies) do
		if table.getn(arrows) > 0 and fly.target ~= nil then
			if math.abs(bodies[fly.target]:getX() - bodies[fly.objIndex]:getX()) < 20 and math.abs(bodies[fly.target]:getY() - bodies[fly.objIndex]:getY()) < 20 then
				--print ("eating!")
				love.graphics.print("om nom nom",bodies[fly.objIndex]:getX()+5, bodies[fly.objIndex]:getY()-15)
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


function AttackArrow(thisFly)
	settarget = nil
	arrowset = GetArrows()

		for j, arrow in pairs(arrowset) do
			xDistance = bodies[arrow]:getX() - bodies[thisFly.objIndex]:getX()
			yDistance = bodies[arrow]:getY() - bodies[thisFly.objIndex]:getY()
			hypotenuse = math.sqrt((xDistance*xDistance) + (yDistance*yDistance))
			if settarget == nil then
				hldHypotenuse = hypotenuse
				settarget = arrow
				--debug.debug()
			else 
				if hypotenuse < hldHypotenuse then
					hldHypotenuse = hypotenuse
					settarget = arrow
					--debug.debug()
				end
			end
		end
		if settarget == nil then
			thisFly.target = 1
		else
			thisFly.target = settarget
			--debug.debug()
		end
end