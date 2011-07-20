player = nil
maprun = 0
playerVelocity = nil
state = 0  -- state 0 = can jump, 1 = can't jump

function CreatePlayer(objIndex)
	player = objIndex
	print ("player = " .. player)
end


function PlayerProcessing(dt)
    if player ~= nil then
        VelocityProcessing()
    end
        PlayerKeyPressed(dt)
        PlayerKeyDown(dt)

end


function VelocityProcessing()

    velVect = GetVelocity(player)
    xvel, yvel = velVect:unpack()

end


function PlayerKeyPressed(key)
			
	if key == "escape" then -- this just doesn't work if you're falling into absolute oblivion :)
		bodies[player]:setX(150)
		bodies[player]:setY(-100)
	end
	if key == "w" then -- double jumping still effect
        if state == 0 then
            ApplyImpulse(player,0,-275) 
        end
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
		ShootArrow()
	end
	
	if key == 'z'	then
        
		camera1.zoom = camera1.zoom + .08
	end	
	if key == 'x' 	then
		camera1.zoom = camera1.zoom - .08 
	end	
	if key == '1' 	then
        print 'obj'
		for i, obj in pairs(shapes) do
            print (i , obj.objType)
        end
        print 'flies'
		for i, fly in pairs(flies) do
            print (i , fly.target, fly.arrowNum)
        end
        print 'arrows'
		for i, arrow in pairs(arrows) do
            print (i , arrow.objIndex)
        end
        
        
		-- debug.debug()
	end	

    if key == 't' then
        getTarget = not getTarget
    end

	if key == '0' then
		AddText("test", 0,0)
	end
	if key == '9' then
		RemoveText(0)
	end
	if key == 'kp+' then
		ClearMap()
        -- LoadMap()
	end
	if key == 'kp-' then
        ClearMap()
        PrevMap()
	end

	if key == 'kpenter' then
        ClearMap()
		RestartMap()
	end

end


function SetPlayerState(playerState)

	state = playerState

end


function printobj()

        print 'obj'
		for i, obj in pairs(shapes) do
            print (i , obj.objType)
        end
        print 'flies'
		for i, fly in pairs(flies) do
            print (i , fly.target, fly.arrowNum)
        end
        print 'arrows'
		for i, arrow in pairs(arrows) do
            print (i , arrow.objIndex)
        end

end


function PlayerKeyDown()

    if love.keyboard.isDown( 'a' ) then
        if xvel ~= nil and xvel > -800 then
            ApplyForce(player,-400,0)
        end
    end


    if love.keyboard.isDown( 'd' ) then
        if xvel ~= nil and xvel < 800 then
            ApplyForce(player,400,0)
        end
    end

    if love.keyboard.isDown( 'up' ) then
        if xvel ~= nil and xvel < 800 then
            ApplyForce(player,0,-200)
        end
    end

end


function ClearPlayer()

    player = nil

end