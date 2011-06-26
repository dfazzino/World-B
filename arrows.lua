arrows = {}
arrowIndex = 0
function PlaceArrow()

	mousePos = camera1:mousepos()
	local mousex, mousey = mousePos:unpack()
	
	arrowobj = {}
	for i = 0, 1 do
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
		if arrows[0] == nil then	
			arrowIndex = 0 
		end
		table.insert(arrows, arrowIndex, arrowObjIndex)
		arrowIndex = arrowIndex + 1
		-- debug.debug()
	end
	
end


function GetArrows()
	
	-- print (arrows[0])
	if arrows[0] == nil then
		return false
	else
		return arrows
	end
		
end


function ArrowExists(thisArrowInd)

	if arrows[thisArrowInd] == nil then
		return false
	else
		return true
	end

end


function RemoveArrow(thisArrowIndex)

	if thisArrowIndex == 0 then
		arrows[0] = nil
	else
		table.remove(arrows, thisArrowIndex)
	end


end