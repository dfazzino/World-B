player = nil
maprun = 0

function CreatePlayer(objIndex)
	player = objIndex
	print ("player = " .. player)
end

function PlayerKeyPressed(key)
			
	if key == "escape" then -- this just doesn't work if you're falling into absolute oblivion :)
		bodies[player]:setX(150)
		bodies[player]:setY(-100)
	end
	if key == "up" then -- double jumping still effect
		ApplyImpulse(player,0,-175)
	end
end

function PlayerKeyReleased(key)
	print(key)
	-- debug.debug()
	
	if key == "s" then	
		writemap()
	end
	if key == '`' then
		maprun = maprun + 1
		
		if maprun == 3 then
			RunGame(false)
		end
		if maprun == 4 then
			RunGame(true)
			maprun = 0
		end
	end
	
	if key == ' ' then
		PlaceArrow()
	end

		
	
end

function PlayerKeyDown(dt)

	if love.keyboard.isDown("left") then -- this seems to work OK!
		ApplyImpulse(player,-150*dt,0)
	end
	if love.keyboard.isDown("right") then
		ApplyImpulse(player,150*dt,0)
	end

end