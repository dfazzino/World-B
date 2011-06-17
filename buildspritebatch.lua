--sets up tiles, builds game graphics based on data in various places

function temporarilyDrawSomeThings()
	
	drawPlayer()
	drawEnemies()
	drawGround()
end

function drawPlayer()
	if player ~= nil then
		x1, y1, x2, y2, x3, y3, x4, y4 = shapes[player]:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
		boxwidth = x3 - x2 --calculate the width of the box
		boxheight = y2 - y1 --calculate the height of the box
		
		love.graphics.setColor(255, 0, 0) -- red for mother russia.. i mean the player
		
		love.graphics.rectangle("fill", bodies[player]:getX() - boxwidth/2, bodies[player]:getY() - boxheight/2, boxwidth, boxheight)
	end
end

function drawEnemies()
	for i,s in pairs(shapes) do
		x1, y1, x2, y2, x3, y3, x4, y4 = s:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
		boxwidth = x3 - x2 --calculate the width of the box
		boxheight = y2 - y1 --calculate the height of the box

		if s:getData() == "E" then -- shouldn't enemies be pretty too?
			love.graphics.setColor(200, 200, 0) -- yellow
			love.graphics.rectangle("fill", bodies[i]:getX() - boxwidth/2, bodies[i]:getY() - boxheight/2, boxwidth, boxheight)
		end
	end
end

function drawGround()
	for i,s in pairs(shapes) do
		x1, y1, x2, y2, x3, y3, x4, y4 = s:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
		boxwidth = x3 - x2 --calculate the width of the box
		boxheight = y2 - y1 --calculate the height of the box

		if s:getData() == "G" then -- ground, dawg
			love.graphics.setColor(72, 160, 14) -- green ground
			love.graphics.rectangle("fill", bodies[i]:getX() - boxwidth/2, bodies[i]:getY() - boxheight/2, boxwidth, boxheight)
		elseif s:getData() == "I" then -- ice ice, baby
			love.graphics.setColor(175, 175, 255) -- icey blue
			love.graphics.rectangle("fill", bodies[i]:getX() - boxwidth/2, bodies[i]:getY() - boxheight/2, boxwidth, boxheight)
		end
	end
end