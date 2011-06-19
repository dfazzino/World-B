
drawType = 1  --1 = player, 2 = enemy, 3 = ground, 4 = ice

function love.mousepressed (x, y, button )
	
	mousePos = camera1:mousepos()

		if button == "r" then
			if drawType == 4 then
				drawType = 1
			else
				drawType = drawType + 1
			end
		end
	-- end

	if button == "l" then
		if drawType == 3 or drawType == 4 then
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
	-- print (tempDrawingSx, tempDrawingSy)
	if button == "l" then
		newobj = {}
		if drawType == 2 then
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
			GenerateAnObject(newobj)
		elseif drawType == 3 then
			newobj.type = 'G'
			newobj.x = tempDrawingSx
			newobj.y = tempDrawingSy
			newobj.mass = 0
			newobj.inertia = 0
			newobj.width = tempDrawingSw
			newobj.height = tempDrawingSh
			newobj.friction = .25
			newobj.angle = 0
			GenerateAnObject(newobj)
		elseif drawType == 4 then
			newobj.type = 'I'
			newobj.x = tempDrawingSx
			newobj.y = tempDrawingSy
			newobj.mass = 0
			newobj.inertia = 0
			newobj.width = tempDrawingSw
			newobj.height = tempDrawingSh
			newobj.angle = 0
			newobj.friction = 0
			GenerateAnObject(newobj)
		end
	end
	drawing = false
	
end


function startDraw (startDrawVector, drawType)

	tempDrawingSx,tempDrawingSy = startDrawVector:unpack()
	tempDrawingSw = tempDrawingSx - tempDrawingSx + 10
	tempDrawingSh = tempDrawingSy - tempDrawingSy + 10
	tempDrawing = drawType
	drawing = true
	
end	


function ContinueDrawing(mouseCoords)

	if mouseCoords and tempDrawingSx and tempDrawingSy then
		tempMouseX, tempMouseY = mouseCoords:unpack()
		
		tempDrawingSw = tempMouseX - tempDrawingSx
		tempDrawingSh = tempMouseY- tempDrawingSy
	end
	
end


function GetDrawingCoords()

	if drawing == true then
		return tempDrawing, tempDrawingSw, tempDrawingSy, tempDrawingSw, tempDrawingSh
	end
	
end