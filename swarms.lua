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
			gameobject.x = math.random(s.x, s.w)
			gameobject.y = 100
			gameobject.mass = 10
			gameobject.inertia = 0
			gameobject.width = 20
			gameobject.height = 20
			gameobject.angle = 0
			gameobject.friction = 4

			newFly = GenerateAnObject(gameobject)
			table.insert(flies, newFly)
		end
	end
end

function MoveFlies (dt)

	for i,fly in pairs(flies) do
		ApplyImpulse(fly, math.random(-1000,1000)*dt, 0)
	end

end