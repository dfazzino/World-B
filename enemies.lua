--holds enemies and AI

enemies = {}

function CreateAnEnemy(gameObject, objIndex)

    enemy = {}

    enemy[0] = gameObject
    enemy[0].objIndex = objIndex

end

    
function MoveEnemies ()

    ApplyImpulse(0, -10, 0)

end