player = {}

function MovePlayer(dt)

	for i,s in pairs(shapes) do
		if s:getData() == "0" then -- player
			
			if key == "escape" then -- this just doesn't work if you're falling into absolute oblivion :)
				bodies[i]:setX(150)
				bodies[i]:setY(-100)
			end
			if key == "up" then -- double jumping still effect
				ApplyImpulse(i,0,-175)
			end
		end
	end
end

function PlayerKeyPressed(key)

	for i,s in pairs(shapes) do
		if s:getData() == "0" then -- player
			
			if key == "escape" then -- this just doesn't work if you're falling into absolute oblivion :)
				bodies[i]:setX(150)
				bodies[i]:setY(-100)
			end
			if key == "up" then -- double jumping still effect
				ApplyImpulse(i,0,-175)
			end
		end
	end
end

function PlayerKeyReleased(key)
end

function PlayerKeyDown(dt)

	for i,s in pairs(shapes) do
		if s:getData() == "0" then -- player

			if love.keyboard.isDown("left") then -- this seems to work OK!
				ApplyImpulse(i,-150*dt,0)
			end
			if love.keyboard.isDown("right") then
				ApplyImpulse(i,150*dt,0)
			end
		end
	end
end