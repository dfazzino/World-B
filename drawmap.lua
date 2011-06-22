
drawType = 1  --1 = player, 2 = enemy, 3 = ground, 4 = ice, 5 = swarm zone

function love.mousepressed (x, y, button )
	
	mousePos = camera1:mousepos()

		if button == "r" then
			if drawType == 5 then
				drawType = 1
			else
				drawType = drawType + 1
			end
		end
	-- end

	if button == "l" then
		if drawType == 3 or drawType == 4 or drawType == 5 then
			startDraw(mousePos, drawType)
		end
		
	end
	
end

function CheckMouse ()

	mousePos = camera1:mousepos()

	if love.mouse.isDown("l") then
	   return mousePos
	end
	
end

function love.mousereleased (x, y, button)
	--print (tempDrawingSx, tempDrawingSy, tempDrawingSw, tempDrawingSh)
	if button == "l" then
		newobj = {}
		if drawType == 1 and player == nil then -- only make 1 player, if player is set we have it already
			newobj.type = 'P'
			mousepos = camera1:mousepos()
			playerx, playery = mousepos:unpack()
			newobj.x = playerx
			newobj.y = playery
			newobj.mass = 15
			newobj.inertia = 0
			newobj.width = 50
			newobj.height = 50
			newobj.angle = 0			
			newobj.friction = .25
			CreatePlayer(GenerateAnObject(newobj))
		elseif drawType == 2 then
			newobj.type = 'E'
			mousepos = camera1:mousepos()
			enemyx, enemyy = mousepos:unpack()
			newobj.x = enemyx
			newobj.y = enemyy
			newobj.mass = 15
			newobj.inertia = 0
			newobj.width = 50
			newobj.height = 50
			newobj.angle = 0			
			newobj.friction = .25
			CreateAnEnemy(GenerateAnObject(newobj))
		elseif drawType == 3 and math.abs(tempDrawingSw) > 0 and math.abs(tempDrawingSh) > 0 then -- don't add 0 width/height objects
			newobj.type = 'G'
			newobj.x = tempDrawingSx + tempDrawingSw / 2 
			newobj.y = tempDrawingSy + tempDrawingSh / 2
			newobj.mass = 0
			newobj.inertia = 0
			newobj.width = tempDrawingSw
			newobj.height = tempDrawingSh
			newobj.friction = .25
			newobj.angle = 0
			GenerateAnObject(newobj)
		elseif drawType == 4 and math.abs(tempDrawingSw) > 0 and math.abs(tempDrawingSh) > 0 then -- don't add 0 width/height objects
			newobj.type = 'I'
			newobj.x = tempDrawingSx + tempDrawingSw / 2 
			newobj.y = tempDrawingSy + tempDrawingSh / 2
			newobj.mass = 0
			newobj.inertia = 0
			newobj.width = tempDrawingSw 
			newobj.height = tempDrawingSh 
			newobj.angle = 0
			newobj.friction = 0
			GenerateAnObject(newobj)
		elseif drawType == 5 and math.abs(tempDrawingSw) > 0 and math.abs(tempDrawingSh) > 0 then -- don't add 0 width/height objects
			newobj.type = 'SZ'
			newobj.x = tempDrawingSx + tempDrawingSw / 2 
			newobj.y = tempDrawingSy + tempDrawingSh / 2
			newobj.w = tempDrawingSw 
			newobj.h = tempDrawingSh 
			newobj.density = math.abs( tempDrawingSw * tempDrawingSh / 250 ) + 1
			AddFiles(CreateSwarmZone(newobj))
		end		
	end
	drawing = false
	
end


function startDraw (startDrawVector, drawType)

	tempDrawingSx,tempDrawingSy = startDrawVector:unpack()
	tempDrawing = drawType
	drawing = true
	
end	

function ContinueDrawing(mouseCoords)

	if mouseCoords and tempDrawingSx and tempDrawingSy then
		tempMouseX, tempMouseY = mouseCoords:unpack()
		
		tempDrawingSw = tempMouseX - tempDrawingSx
		tempDrawingSh = tempMouseY - tempDrawingSy
	end
	
end


function GetDrawingCoords()

	if drawing == true then
		return tempDrawing, tempDrawingSw, tempDrawingSy, tempDrawingSw, tempDrawingSh
	end
	
end