arrows = {}
arrowIndex = 1
local removeArrowTime = love.timer.getMicroTime( )

function ArrowProcessing()

    for i, arrow in pairs(arrows) do

        -- ArrowInAir(arrow)
        removeArrowTimer = love.timer.getMicroTime( )
        -- if removeArrowTimer - removeArrowTime > 1 then
            removedObjIndexes = RemoveArrows()
            AdjustObjIndexes(removedObjIndexes)
            removeObjIndexes = nil
        -- end
    end
end


function PlaceArrow(arrowObjIndex)

		if arrows[1] == nil then	
			arrowIndex = 1
		end
        newArrow = {}
        newArrow.flies = {}
		newArrow.objIndex = arrowObjIndex
        newArrow.setForRemoval = false
        newArrow.inAir = true
        newArrow.airTime = love.timer.getMicroTime( )
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
	arrowobj.friction = .1
	arrowObjIndex = GenerateAnObject(arrowobj)
    PlaceArrow(arrowObjIndex)
	-- ApplyAngle(arrowObjIndex, 1)
	ApplyImpulse(arrowObjIndex, ximpulse * 100, yimpulse * 100)

end


function ArrowInAir(thisArrow)

        if thisArrow.inAir == true then
			print ("arrow in the air!", thisArrow)
            thisArrow.airTimer = love.timer.getMicroTime( )
            if bodies[thisArrow.objIndex]:isSleeping() == false then
				if thisArrow.airTimer - thisArrow.airTime > 1 then
                    thisArrow.setForRemoval = true
                    -- debug.debug()
                end
			else
				thisArrow.inAir = false
            end
        end
   
end


function MoveArrowPlz()

		-- ApplyImpulse(arrowObjIndex, -400, -400)

end


function GetArrows()

	return arrows
		
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
    bodies[arrows[thisArrow].objIndex]:setX(99999)
    bodies[arrows[thisArrow].objIndex]:setY(99999)

end


function RemoveArrows()
	removedObjIndex = {}

    for i, arrow in pairs(arrows) do
        if arrow.setForRemoval == true then
			table.insert(removedObjIndex, arrow.objIndex)
            RemoveShape(arrow.objIndex)
            RemoveBody(arrow.objIndex)  
            table.remove(arrows, i)
            if #arrows == 0 then
                arrows = {}
            end
        --    print ('removing arrow ' .. i , 'objIndex:,', arrow.objIndex)
			for j, arro in pairs(arrows) do 
		--		print(j, arro.objIndex)
			end
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


function ClearArrows()

    arrows = {}

end