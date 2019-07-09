-- отрисовка мини-карты

local function drawDour(d1, d2, Type)
    x1, y1 = d1 % n, math.floor(d1 / n) + 1
    x2, y2 = d2 % n, math.floor(d2 / n) + 1
    if x1 == 0 then
        x1, y1 = n, y1 - 1
    end
    if x2 == 0 then
        x2, y2 = n, y2 - 1
    end
    local widthLine = love.graphics.getLineWidth()
    if Type == 1 then
        love.graphics.rectangle("fill", (x1 + x2) / 2 * mapSize - dourSize / 2 - mapSize / 2, (y1 + y2) / 2 * mapSize - dourSize / 2 - mapSize / 2, dourSize, dourSize)
    elseif Type == 2 then
        love.graphics.rectangle("fill", (x1 + x2) / 2 * mapSize - mapSize + widthLine, (y1 + y2) / 2 * mapSize - mapSize + widthLine, mapSize - widthLine*2, mapSize - widthLine*2)
    end
end
local function drawMiniMap(castl)
    love.graphics.clear(255, 255, 255)
    q = 0
    for y = 0, (n - 1) * mapSize, mapSize do
        for x = 0, (n - 1) * mapSize, mapSize do
            q = q + 1
            if castl[q].use then
                love.graphics.setColor(200, 200, 200, 255)
                love.graphics.rectangle("fill", x, y, mapSize, mapSize)
                love.graphics.setColor(0, 0, 0, 255)
                love.graphics.rectangle("line", x, y, mapSize, mapSize)
            end
        end
    end
    love.graphics.setColor(200, 200, 200, 255)
    for i = 1, #Dours do
        drawDour(Dours[i][1], Dours[i][2], Dours[i][3])
    end
    love.graphics.setColor(0, 0, 0, 255)
    q = 0
    for y = 0, (n - 1) * mapSize, mapSize do
        for x = 0, (n - 1) * mapSize, mapSize do
            q = q + 1
            if castl[q].use then
				love.graphics.print(castl[q].tip,x,y+mapSize-13)
                love.graphics.print(q, x, y)
            end
        end
    end
    love.graphics.setColor(0, 0, 0, 50)
    love.graphics.circle("fill", Hero.cellX * mapSize - mapSize / 2, Hero.cellY * mapSize - mapSize / 2, mapSize / 4)
    love.graphics.setColor(0, 255, 0, 100)
    love.graphics.circle("fill", collide.XYFromID(max_vert1)[1] * mapSize - mapSize / 2, (collide.XYFromID(max_vert1)[2] + 2) * mapSize - mapSize / 2, mapSize / 4)
    love.graphics.setColor(255, 0, 0, 100)
    love.graphics.circle("fill", collide.XYFromID(max_vert2)[1] * mapSize - mapSize / 2, (collide.XYFromID(max_vert2)[2] + 2) * mapSize - mapSize / 2, mapSize / 4)
end
return { drawMiniMap = drawMiniMap }