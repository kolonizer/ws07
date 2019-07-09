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

    math.randomseed(os.time())
    size = 403
    n = 10
    --загрузка ресурсов
    heroSprite = newSpr("spr/dracula", 31, 80, 0.3, 4, 3)
    -- таблица главного героя
    height = love.graphics.getHeight()
    mapSize = height / n
    dourSize = mapSize / 5
    X = 400
    Y = 300
    castl, graph, Dours = gra.generate()
	id = max_vert1
    Hero = {id = id, cellX = id % n, cellY = math.floor(id / n) + 1, name="Hero", Type = "circle", mode = "line", sprite = heroSprite, x = collide.XYFromID(max_vert1)[1] * size + size / 2, y = (collide.XYFromID(max_vert1)[2] + 2) * size + size / 2, radius = 10, colour = { 255, 255, 255, 255 } }
    cam = gamera.new(0, 0, size * (n + 2), size * (n + 2))
    cam:setWindow(0, 0, 800, 600)
    cam:setScale(0.5)
end
function love.draw()
    if love.keyboard.isDown("tab") then
        drawMiniMap.drawMiniMap(castl)
    else
        cam:draw(function(l, t, w, h)
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
    local A = RoomCollision.neighbours(visited, graph)
    for i = 1, #A do
        visited = {}
        RoomCollision.dfs(graph, A[i], n, (collide.XYFromID(A[i])[1] + 0) * size + size / 2, (collide.XYFromID(A[i])[2] + 2) * size + size / 2, size, 5, 3, { 50, 50, 50, 255 })
    end
    control.control({"a","w","s","d","q","e"}, Hero, 300 * dt, 100 * dt)
    updateSpr(heroSprite, dt)
    cam:setPosition(Hero.x, Hero.y)
end