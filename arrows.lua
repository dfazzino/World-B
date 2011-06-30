arrows = {}
arrowIndex = 0
function PlaceArrow(arrowObjIndex)

		if arrows[0] == nil then	
			arrowIndex = 0 
		end
        newArrow = {}
		newArrow.objIndex = arrowObjIndex
        newArrow.setForRemoval = false
		table.insert(arrows, arrowIndex, newArrow)
		arrowIndex = arrowIndex + 1
	
end


function ShootArrow() 

	mousePos = camera1:mousepos()
	local mousex, mousey = mousePos:unpack()
	xDistance =  mousex - bodies[player]:getX()
	yDistance = mousey - bodies[player]:getY()
	hypotenuse = math.sqrt((xDistance*xDistance) + (yDistance*yDistance))
	ximpulse = (xDistance/hypotenuse)
	yimpulse = (yDistance/hypotenuse)
	arrowobj = {}
	arrowobj.type = 'A'
	arrowobj.x = bodies[player]:getX() + ximpulse * 10
	arrowobj.y = bodies[player]:getY() + yimpulse * 10
	-- arrowobj.x = mousex
	-- arrowobj.y = mousey
	arrowobj.mass = 5
	arrowobj.inertia = 0
	arrowobj.width = 10
	arrowobj.height = 10
	arrowobj.angle = 0
	arrowobj.friction = 0
	arrowObjIndex = GenerateAnObject(arrowobj)

	ApplyImpulse(arrowObjIndex, ximpulse * 100, yimpulse * 100)

end


function MoveArrowPlz()

		-- ApplyImpulse(arrowObjIndex, -400, -400)

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


function SetForRemoval(thisArrow)

    arrows[thisArrow].setForRemoval = true

end


function RemoveArrows()

	removedObjIndex = {}

    for i, arrow in pairs(arrows) do
        if arrow.setForRemoval == true then
            RemoveBody(arrow.objIndex)  
            RemoveShape(arrow.objIndex)
            arrows[i] = nil
            print ('removing arrow ' .. i)
			table.insert(removedObjIndex, arrow.objIndex)
			-- debug.debug()
        end
    end
	
	return removedObjIndex
	
end


function AdjustArrowObjIndex(objIndex)

	for i, arrow in pairs(arrows) do
		if arrow.objIndex > objIndex then
			arrow.objIndex = arrow.objIndex - 1
		end
	end

end