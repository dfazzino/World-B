enemies = {}

function CreateAnEnemy(objIndex)

   	table.insert(enemies, objIndex)
	print ("added to enemies = " .. objIndex)
end

function MoveEnemies (dt)

	for i,enemy in pairs(enemies) do
		ApplyImpulse(enemy, math.random(-1000,1000)*dt, 0)
	end

end


function AdjustEnemyObjIndex(objIndex)

	for i, enemy in pairs(enemies) do
		if enemy > objIndex then
			enemy = enemy - 1
		end
	end

end

