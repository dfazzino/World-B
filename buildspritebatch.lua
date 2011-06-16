--sets up tiles, builds game graphics based on data in various places

function temporarilyDrawSomeThings()
	-- START temporary code to draw some shapes
	
	for i,s in pairs(shapes) do
		x1, y1, x2, y2, x3, y3, x4, y4 = s:getBoundingBox() --get the x,y coordinates of all 4 corners of the box.
		boxwidth = x3 - x2 --calculate the width of the box
		boxheight = y2 - y1 --calculate the height of the box

		love.graphics.setColor(125, 125, 125) -- undefined grey :|

		if s:getData() == "0" then -- 0 = player, for now!  and.. that 0 is apparently a string
			love.graphics.setColor(255, 0, 0) -- red for mother russia.. i mean the player
		elseif s:getData() == "1" then -- 1 = ground, dawg
			love.graphics.setColor(72, 160, 14) -- green ground
		elseif s:getData() == "2" then -- 2 = ice ice, baby
			love.graphics.setColor(175, 175, 255) -- icey blue
		end

		love.graphics.rectangle("fill", s:getBody():getX() - boxwidth/2, s:getBody():getY() - boxheight/2, boxwidth, boxheight)
	end
	
	-- END temporary code to draw some shapes
end