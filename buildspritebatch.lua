--sets up tiles, builds game graphics based on data in various places

function temporarilyDrawSomeThings(isLeftMouseDown)
	
	drawPlayer()
	-- drawEnemies()
	drawBoxThings()
	-- drawArrows()
	-- drawGround()
	TempDraw()
end

function drawPlayer()
	if player ~= nil then
		x1, y1, x2, y2, x3, y3, x4, y4 = shapes[player].shape:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
		boxwidth = x3 - x2 --calculate the width of the box
		boxheight = y2 - y1 --calculate the height of the box
		
		love.graphics.setColor(255, 0, 0) -- red for mother russia.. i mean the player
		
		love.graphics.rectangle("fill", bodies[player]:getX() - boxwidth/2, bodies[player]:getY() - boxheight/2, boxwidth, boxheight)
	end
end

function drawEnemies()
	for i,s in pairs(shapes) do
		x1, y1, x2, y2, x3, y3, x4, y4 = s.shape:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
		boxwidth = x3 - x2 --calculate the width of the box
		boxheight = y2 - y1 --calculate the height of the box

	end
end


function drawBoxThings()
	for i,s in pairs(shapes) do
		x1, y1, x2, y2, x3, y3, x4, y4 = s.shape:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
		boxwidth = x3 - x2 --calculate the width of the box
		boxheight = y2 - y1 --calculate the height of the box

		if s.objType == "F" then
			-- print (i)
			love.graphics.setColor(12, math.random(50,255), 40) -- pine green BUZZING flies (unscented)
			love.graphics.rectangle("fill", bodies[i]:getX() - boxwidth/2, bodies[i]:getY() - boxheight/2, boxwidth, boxheight)
		end
		if s.objType == "E" then -- shouldn't enemies be pretty too?
			love.graphics.setColor(200, 200, 0) -- yellow
			love.graphics.rectangle("fill", bodies[i]:getX() - boxwidth/2, bodies[i]:getY() - boxheight/2, boxwidth, boxheight)
		end
		if s.objType == "A" then
			love.graphics.setColor(200, 15, 99) -- pine green BUZZING flies (unscented)
			love.graphics.rectangle("fill", bodies[i]:getX() - boxwidth/2, bodies[i]:getY() - boxheight/2, boxwidth, boxheight)
		end
		if s.objType == "G" then -- ground, dawg
			love.graphics.setColor(72, 160, 14) -- green ground
			love.graphics.rectangle("fill", bodies[i]:getX() - boxwidth/2, bodies[i]:getY() - boxheight/2, boxwidth, boxheight)
		elseif s.objType == "I" then -- ice ice, baby
			love.graphics.setColor(175, 175, 255) -- icey blue
			love.graphics.rectangle("fill", bodies[i]:getX() - boxwidth/2, bodies[i]:getY() - boxheight/2, boxwidth, boxheight)
		end
	end
end


function TempDraw ()

		tempDrawing, Sx, Sy, Sw, Sh = GetDrawingCoords()

		if tempDrawing == 3 then
			love.graphics.setColor(72, 160, 14) -- green ground
			love.graphics.rectangle("fill", tempDrawingSx, tempDrawingSy, tempDrawingSw, tempDrawingSh)
		end
	    if tempDrawing == 4 then
			love.graphics.setColor(175, 175, 255) -- icey blue
			love.graphics.rectangle("fill", tempDrawingSx, tempDrawingSy, tempDrawingSw, tempDrawingSh)
		end
		if tempDrawing == 5 then
			love.graphics.setColor(255, 0, 255) -- dem ugly swarm zones
			love.graphics.rectangle("fill", tempDrawingSx, tempDrawingSy, tempDrawingSw, tempDrawingSh)
		end
		
	-- end

end


function AddText(words, x, y)

	texts[textIndex] = {}
	texts[textIndex].words = words
	texts[textIndex].x = x
	texts[textIndex].y = y
	textIndex = textIndex + 1
	
	return textIndex
	
end


function RemoveText(thisTextIndex)

	texts[thisTextIndex] = nil
	
end