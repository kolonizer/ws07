-- ГРАФство. Процедурно генерируемый лабиринт
-- ws07 мастерская № 7. ЛШЮП 2019

function love.load()
    love.window.setTitle("Граф ДРАКУЛА. Мастерская № 7. ЛШЮП 2019. Управление WASD и Tab")
    love.graphics.setDefaultFilter("nearest", "nearest")
    inspect = require "inspect"    -- для печати в консоли содержимого таблиц
    gamera = require "gamera" -- библиотека камеры (показывать фрагмент уровня)
    sprite = require "sprite" -- загрузка картинок, рисование спрайтов
    collide = require "collide" --
    control = require "control"    -- управление с клавиатуры
    draw = require "draw"
    gra = require "generate"
    roomCollision = require "roomCollision"
    drawMiniMap = require "drawMiniMap"
    spawn = require "spawn"
    monster = require "monster"
    DoorsOfRoom = {}
    --загрузка ресурсов
    heroSprite = newSpr("spr/dracula", 31, 80, 0.3, 4, 3, { 1, 2, 3, 2 })
    woodTable = newSpr("spr/woodTable", 50, 50, 0, 1, 1, nil)
    candle = newSpr("spr/candles", 30, 30, 0.2, 1, 2, { 1, 2 })
    MP = newSpr("spr/item.MP", 31, 31, 1, 1, 1)
    Quiver1 = newSpr("spr/item.Quiver1", 31, 31, 1, 1, 1)
    Shield1 = newSpr("spr/item.Shield1", 31, 31, 1, 1, 1)
    Ax1 = newSpr("spr/itemAx1", 31, 31, 1, 1, 1)
    Bow1 = newSpr("spr/itemBow1", 31, 31, 1, 1, 1)
    HP1 = newSpr("spr/itemHP1", 31, 31, 1, 1, 1)
    LongSword1 = newSpr("spr/itemLongSword1", 31, 31, 1, 1, 1)
    Rod1 = newSpr("spr/itemRod1", 31, 31, 1, 1, 1)
    Rod2 = newSpr("spr/itemRod2", 31, 31, 1, 1, 1)
    Shield2 = newSpr("spr/itemShield2", 31, 31, 1, 1, 1)
    Shield3 = newSpr("spr/itemShield3", 31, 31, 1, 1, 1)
    Sword1 = newSpr("spr/itemSword1", 31, 31, 1, 1, 1)
    Sword2 = newSpr("spr/itemSword2", 31, 31, 1, 1, 1)
    IronHelmet = newSpr("spr/itemIronHelmet", 31, 31, 1, 1, 1)
    IronJacket = newSpr("spr/itemIronJacket", 31, 31, 1, 1, 1)
    IronPants = newSpr("spr/itemIronPants", 31, 31, 1, 1, 1)
    MailHelmet = newSpr("spr/itemMailHelmet", 31, 31, 1, 1, 1)
    MailJacket = newSpr("spr/itemMailJacket", 31, 31, 1, 1, 1)
    MailPants = newSpr("spr/itemMailPants", 31, 31, 1, 1, 1)

    Gold = newSpr("spr/itemGold", 31, 31, 1, 1, 1)
    Key = newSpr("spr/itemKey", 31, 31, 1, 1, 1)
    KeyBlue = newSpr("spr/itemKeyBlue", 31, 31, 1, 1, 1)
    KeyGreen = newSpr("spr/itemKeyGreen", 31, 31, 1, 1, 1)
    KeyRed = newSpr("spr/itemKeyRed", 31, 31, 1, 1, 1)

    chans = { { Key, 'Key', 0 },
              { KeyBlue, 'KeyBlue', 0 },
              { KeyGreen, 'KeyGreen', 0 },
              { KeyRed, 'KeyRed', 0 },
              { Gold, 'Gold', 10 },
              { MP, 'MP', 5 },
              { Quiver1, 'Quiver1', 5 },
              { Shield1, 'Shield1', 5 },
              { Ax1, 'Ax1', 5 },
              { Bow1, 'Bow1', 5 },
              { HP1, 'HP1', 5 },
              { LongSword1, 'LongSword1', 5 },
              { Rod1, 'Rod1', 5 },
              { Rod2, 'Rod2', 5 },
              { Shield2, 'Shield2', 5 },
              { Shield3, 'Shield3', 5 },
              { Sword1, 'Sword1', 5 },
              { Sword2, 'Sword2', 5 },
              { IronHelmet, 'IronHelmet', 5 },
              { IronJacket, 'IronJacket', 4 },
              { IronPants, 'IronPants', 4 },
              { MailHelmet, 'MailHelmet', 4 },
              { MailJacket, 'MailJacket', 4 },
              { MailPants, 'MailPants', 4 } }

    rand = {}
    for ch = 1, #chans do
        for f = 1, chans[ch][3] do
            rand[#rand + 1] = chans[ch]
        end
    end
    --print(inspect( range, { depth = 4 } ) )

    math.randomseed(os.time())
    Ls = 31
    ws = 3
    size = 403 + 2 * ws
    n = 7
    mapSize = love.graphics.getHeight() / n
    doorSize = mapSize / 5
    -- таблица главного героя
    --X = 400

    --гриб на месте

    --призрак через стены

    --волк догоняет

    --змея так змея

    --орк
    --Y = 300
    Rooms, graph, Doors = gra.generate()
    id = max_vert1
    for p = 1, #Rooms do
        --print(p,castl[p].tip)
        if Rooms[p].tip == 'treasure' then
            for i = 1, 169, 1 do
                spawn.AddLotLoot(p, Rooms)
            end
        end
    end
    --print(inspect( castl, { depth = 4 } ) )
    Hero = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1, name = "Hero", Type = "circle", mode = "line", sprite = heroSprite, x = collide.XYFromID(max_vert1)[1] * size + size / 2, y = (collide.XYFromID(max_vert1)[2] + 2) * size + size / 2, radius = 10, colour = { 255, 255, 255, 0 } }
    Inventory = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    Objects = { Hero }
    monster.CreateMonster(max_vert2, 'Wolf')
    cam = gamera.new(0, 0, size * (n + 2), size * (n + 2))
    cam:setWindow(0, 0, 800, 600)
    cam:setScale(1.2)
end
function love.draw()
    love.graphics.clear(0, 0, 0)
    if love.keyboard.isDown("tab") then
        drawMiniMap.drawMiniMap(Rooms)
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
            draw.drawFloor()
            spawn.drawLoot(v, Rooms)
            love.graphics.setColor(255, 255, 255, 255)
            spawn.drawLoot(v, Rooms)
            love.graphics.print(math.floor(fps), l, t)
            draw.draw(Objects)
        end)
    end
end
function love.update(dt)
    fps = 1 / dt
    local lenObjects = #Objects
    for i = lenObjects, 1, -1 do
        if Objects[i].name == "wall" then
            table.remove(Objects, i)
        end
    end
    DoorsOfRoom = {}
    visited = {}
    Hero.cellX = (Hero.x - (Hero.x % size)) / size
    Hero.cellY = (Hero.y - (Hero.y % size)) / size
    Hero.id = (Hero.cellY - 1) * n + Hero.cellX
    roomCollision.dfs(graph, Hero.id, n, Hero.cellX * size + size / 2, Hero.cellY * size + size / 2, size, 5, 3, { 255, 255, 255, 255 })
    v = visited
    local A = roomCollision.neighbours(visited, graph)
    for i = 1, #A do
        visited = {}
        roomCollision.dfs(graph, A[i], n, (collide.XYFromID(A[i])[1] + 0) * size + size / 2, (collide.XYFromID(A[i])[2] + 2) * size + size / 2, size, 5, 3, { 50, 50, 50, 255 })
    end
    control.control({ "a", "w", "s", "d", "q", "e" }, Hero, 300 * dt, 100 * dt)
    monster.UpdateMonster(dt)
    updateSpr(heroSprite, dt)
    cam:setPosition(Hero.x, Hero.y)
end