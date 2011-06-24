arrows = {}
arrowIndex = 0
function PlaceArrow()

	mousePos = camera1:mousepos()
	local mousex, mousey = mousePos:unpack()
	
	arrowobj = {}
	for i = 0, 20 do
		arrowobj.type = 'A'
		arrowobj.x = math.random(mousex - 5, mousex + 5)
		arrowobj.y = math.random(mousey - 5, mousey + 5)
		arrowobj.mass = 0
		arrowobj.inertia = 0
		arrowobj.width = 4
		arrowobj.height = 4
		arrowobj.angle = 0
		arrowobj.friction = 0
		arrowObjIndex= GenerateAnObject(arrowobj)
		table.insert(arrows, arrowIndex, arrowObjIndex)
		arrowIndex = arrowIndex + 1
		-- debug.debug()
	end
	
end

function GetArrows()

	return arrows

end