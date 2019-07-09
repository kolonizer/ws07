-- ГРАФство. Процедурно генерируемый лабиринт
-- ws07 мастерская № 7. ЛШЮП 2019

function love.load()
	inspect = require "inspect"
    gamera = require "gamera"
    sprite = require "sprite"
    collide = require "collide"
    control = require "control"
    draw = require "draw"
    gra = require "generate"
    RoomCollision = require "RoomCollision"
    drawMiniMap = require "drawMiniMap"
	spawn = require "spawn"

    math.randomseed(os.time())
	Ls=31
	ws=5
    size = 403
    n = 10
    --загрузка ресурсов
    heroSprite = newSpr("spr/dracula", 31, 80, 0.3, 4, 3, {1, 2, 3, 2})
	woodTable = newSpr("spr/woodTable", 50, 50, 0, 1, 1, nil)
	candle = newSpr("spr/candels", 30, 30, 0.2, 1, 2, {1, 2})
    -- таблица главного героя
    X = 400
    Y = 300
    castl, graph, Dours = gra.generate()
	id = max_vert1
	for p=1,#castl do
		--print(p,castl[p].tip)
		if castl[p].tip=='treasure' then
			spawn.AddLotLoot(p,castl)
		end
	end
	--print(inspect( castl, { depth = 4 } ) )
    Hero = {id = id, cellX = id % n, cellY = math.floor(id / n) + 1, name="Hero", Type = "circle", mode = "line", sprite = heroSprite, x = collide.XYFromID(max_vert1)[1] * size + size / 2, y = (collide.XYFromID(max_vert1)[2] + 2) * size + size / 2, radius = 10, colour = { 255, 255, 255, 0 } }
    cam = gamera.new(0, 0, size * (n + 2), size * (n + 2))
    cam:setWindow(0, 0, 800, 600)
    cam:setScale(1.4)
end
function love.draw()
	love.graphics.clear(0,0,0)
    if love.keyboard.isDown("tab") then
        drawMiniMap.drawMiniMap(castl)
		MousX, MousY = love.mouse.getPosition()
		if love.mouse.isDown(1) and MousX < 600 then
			Hero.cellX = math.floor(MousX / mapSize) + 2
			Hero.cellY = math.floor(MousY / mapSize) + 2
			Hero.id = (Hero.cellY - 1) * n + Hero.cellX
			Hero.x = Hero.cellX * size - size / 2
			Hero.y = Hero.cellY * size - size / 2
		end
    else
        cam:draw(function(l, t, w, h)
			spawn.drawLoot(v,castl)
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.print(math.floor(fps), l, t)
            draw.draw(Objects)
        end)
    end
end
function love.update(dt)
    fps = 1 / dt
    Objects = { Hero }
    visited = {}
    Hero.cellX = (Hero.x - (Hero.x % size)) / size
    Hero.cellY = (Hero.y - (Hero.y % size)) / size
    Hero.id = (Hero.cellY - 1) * n + Hero.cellX
    RoomCollision.dfs(graph, Hero.id, n, Hero.cellX * size + size / 2, Hero.cellY * size + size / 2, size, 5, 3, { 255, 255, 255, 255 })
	v=visited
    local A = RoomCollision.neighbours(visited, graph)
    for i = 1, #A do
        visited = {}
        RoomCollision.dfs(graph, A[i], n, (collide.XYFromID(A[i])[1] + 0) * size + size / 2, (collide.XYFromID(A[i])[2] + 2) * size + size / 2, size, 5, 3, { 50, 50, 50, 255 })
    end
    control.control({"a","w","s","d","q","e"}, Hero, 300 * dt, 100 * dt)
    updateSpr(heroSprite, dt)
    cam:setPosition(Hero.x, Hero.y)
end