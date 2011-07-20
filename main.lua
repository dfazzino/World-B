require "TEsound"
require "camera"
require "vector"
require "enemies"
require "swarms"
require "arrows"
require "drawmap"
require "map"
require "physicsg" -- this might be temporary, just to draw objects from bodies/shapes
require "player"
require "buildspritebatch"

local map -- stores tiledata
local mapWidth, mapHeight -- width and height in tiles

local mapX, mapY -- view x,y in tiles. can be a fractional value like 3.25.

local tilesDisplayWidth, tilesDisplayHeight -- number of tiles to show
local zoomX, zoomY

local tilesetImage
local tileSize -- size of tiles in pixels
local tileQuads = {} -- parts of the tileset used for different tiles
local tilesetSprite
local worldupdate = true


function love.load()
	math.randomseed(love.timer.getMicroTime( ))
	--TEsound.playLooping("DAVland theme.mp3", "music")
	setupMap()
	setupMapView()
	setupTileset()
	love.graphics.setFont(12)
	CreateWorld()
	e = generatemap()
	AddFlies()

    camerapos = vector(0,0)
    camera1 = camera(camerapos, .75, 0)
end


function setupMap()
	mapWidth = 100
	mapHeight = 20

	map = {}
end


function setupMapView()
	mapX = 1
	mapY = 1
	tilesDisplayWidth = 26
	tilesDisplayHeight = 20

	zoomX = 1
	zoomY = 1
end


function setupTileset()
	tilesetImage = love.graphics.newImage( "tileset.png" )
	tilesetImage:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
	tileSize = 32
	tileSize = 32

	-- grass
	tileQuads[0] = love.graphics.newQuad(0 * tileSize, 20 * tileSize, tileSize, tileSize,
		tilesetImage:getWidth(), tilesetImage:getHeight())
	-- sidewalk with bottom edgge
	tileQuads[1] = love.graphics.newQuad(9 * tileSize, 0 * tileSize, tileSize, tileSize,
		tilesetImage:getWidth(), tilesetImage:getHeight())
	-- parquet flooring
	tileQuads[2] = love.graphics.newQuad(4 * tileSize, 0 * tileSize, tileSize, tileSize,
		tilesetImage:getWidth(), tilesetImage:getHeight())
	-- middle of red carpet
	tileQuads[3] = love.graphics.newQuad(3 * tileSize, 9 * tileSize, tileSize, tileSize,
		tilesetImage:getWidth(), tilesetImage:getHeight())
	tileQuads[4] = love.graphics.newQuad(116, 534, 51, 38,
		tilesetImage:getWidth(), tilesetImage:getHeight())

	tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, tilesDisplayWidth * tilesDisplayHeight)

  updateTilesetBatch()
end


function updateTilesetBatch()

	tilesetBatch:clear()
	-- for x=0, tilesDisplayWidth-1 do
		-- for y=0, tilesDisplayHeight-1 do
			-- tilesetBatch:addq(tileQuads[map[x+math.floor(mapX)][y+math.floor(mapY)]],
				-- x*tileSize, y*tileSize)
		-- end
	-- end

    tilesetBatch:addq(tileQuads[4], 300, 200)
end

function moveMap(dx, dy)
end


function RunGame(runbool)

	worldupdate = runbool

end


function love.update(dt)

	if player then
		camx, camy = camera1:toCameraCoords(vector(bodies[player]:getX(),bodies[player]:getY())):unpack()
		camx = camx - love.graphics.getWidth()/2
		camy = camy - love.graphics.getHeight()/2
		
		camera1:translate(vector(camx, camy) * dt * 10)
	end
	
	if worldupdate == true then
		world:update(dt)
	end

	TEsound.cleanup()		
    ArrowProcessing()
	PlayerProcessing(dt)
    FlyProcessing()


	ContinueDrawing(CheckMouse())
end


function love.keypressed(key, unicode)
	PlayerKeyPressed(key) 
end

function love.keyreleased(key, unicode)
	PlayerKeyReleased(key)
end

function love.draw()

    camera1:predraw()
	love.graphics.draw(tilesetBatch,
		math.floor(-zoomX*(mapX%1)*tileSize), math.floor(-zoomY*(mapY%1)*tileSize),
		0, zoomX, zoomY)
		
	temporarilyDrawSomeThings()

	
	camera1:postdraw()
	
	-- temp code for draw type display
	--1 = player, 2 = enemy, 3 = ground, 4 = ice, 5 = swarm zone
	drawTypeName = ""
	if drawType == 1 then
		drawTypeName = "Player"
	elseif drawType == 2 then
		drawTypeName = "Enemy"
	elseif drawType == 3 then
		drawTypeName = "Ground"
	elseif drawType == 4 then
		drawTypeName = "Ice"
	elseif drawType == 5 then
		drawTypeName = "Swarm Zone"
	end
	
	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
	love.graphics.print("DRAWING: "..drawTypeName, 10, 30)	
end