swarmzones = {}
flies = {}
swarmx = 0

function CreateSwarmZone(gameobject)

   	table.insert(swarmzones, swarmx, gameobject)
	swarmx = swarmx + 1

end


function AddFlies()
	for i,s in pairs(swarmzones) do
		for i = 0,s.density do
			gameobject.type = 'F'
			print (s.w)
			gameobject.x = math.random(s.x-10, s.x+10)
			gameobject.y = math.random(s.y-10, s.x+10)
			gameobject.mass = 2
			gameobject.inertia = 0
			gameobject.width = 20
			gameobject.height = 20
			gameobject.angle = 0
			gameobject.friction = .5

			newFly = GenerateAnObject(gameobject)
			table.insert(flies, newFly)
		end
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