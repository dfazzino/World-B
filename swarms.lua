swarmzones = {}
flies = {}
swarmx = 0

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
			mygameobject.friction = .5

			newFly = GenerateAnObject(mygameobject)
			table.insert(flies, newFly)
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
		mygameobject.friction = .5

		newFly = GenerateAnObject(mygameobject)
		table.insert(flies, newFly)
	end
end

function MoveFlies (dt)

	first = true

	for i,fly in pairs(flies) do
		if first then
			lastFlyX = 0
			lastFlyY = 0
			first = false
		end
		dx = bodies[player]:getX() - bodies[fly]:getX() - lastFlyX + 5 
		dy = bodies[player]:getY() - bodies[fly]:getY() - lastFlyY + 5
		ApplyImpulse(fly, (math.random(0,5)+dx)*dt/5, (math.random(0,7)+dy)*dt/5)
		
		lastFlyX = bodies[fly]:getX()
		lastFlyY = bodies[fly]:getY()
	end

end