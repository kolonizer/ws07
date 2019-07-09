function XYfromID(ID)
    local x = ID % n
    local y = math.floor(ID / n) - 1
    if x == 0 then
        x = n
        y = y - 1
    end
    return { x, y }
end
function love.load()
    gamera = require "gamera"
    sprite = require "sprite"
    collide = require "collide"
    control = require "control"
    draw = require "draw"
    gra = require "generate"
    RoomCollision = require "RoomCollision"
    drawMiniMap = require "drawMiniMap"

    math.randomseed(os.time())
    size = 200
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
    Hero = { Type = "circle", mode = "line", sprite = heroSprite, x = XYfromID(max_vert1)[1] * size + size / 2, y = (XYfromID(max_vert1)[2] + 2) * size + size / 2, radius = 10, colour = { 255, 255, 255, 255 } }
    id = max_vert1
    heroId = id
    heroX = id % n
    heroY = math.floor(id / n) + 1
    cam = gamera.new(0, 0, size * (n + 2), size * (n + 2))
    cam:setWindow(0, 0, 800, 600)
    cam:setScale(0.5)
end
function love.draw()
    if love.keyboard.isDown("tab") then
        drawMiniMap.drawMiniMap()
    else
        cam:draw(function(l, t, w, h)
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.print(math.floor(fps), 780, 0)
            --love.graphics.print(heroId,0,0)
            --love.graphics.print(heroX.." "..heroY,0,10)
            --love.graphics.print(X2.." "..Y2,0,20)
            draw.draw(Objects)
        end)
    end
end
function love.update(dt)
    fps = 1 / dt
    local speed = 300 * dt
    local GrowthSpeed = 100 * dt
    Objects = { Hero }
    visited = {}
    heroX = (Hero.x - (Hero.x % size)) / size
    heroY = (Hero.y - (Hero.y % size)) / size
    heroId = (heroY - 1) * n + heroX
    RoomCollision.dfs(graph, heroId, n, heroX * size + size / 2, heroY * size + size / 2, size, 5, 3, { 255, 255, 255, 255 })
    local A = neighbours(visited, graph)
    for i = 1, #A do
        --roomX,roomY=XYfromID(A[i])
        visited = {}
        RoomCollision.dfs(graph, A[i], n, (XYfromID(A[i])[1] + 0) * size + size / 2, (XYfromID(A[i])[2] + 2) * size + size / 2, size, 5, 3, { 50, 50, 50, 255 })
    end
    --RoomCollision.dfs(graph,heroId,n,heroX*size+size/2,heroY*size+size/2,size,5,3,{255,255,255,255})
    control.control("keyboard", speed, GrowthSpeed)
    updateSpr(heroSprite, dt)
    cam:setPosition(Hero.x, Hero.y)
end