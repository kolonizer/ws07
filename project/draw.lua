-- Отрисовка всех юнитов
local function drawUnit(u)
    love.graphics.setColor(u.colour[1], u.colour[2], u.colour[3], u.colour[4])
    if u.Type == "rectangle" then
        love.graphics.rectangle(u.mode, u.x - u.wigth / 2, u.y - u.height / 2, u.wigth, u.height)
    elseif u.Type == "circle" then
        love.graphics.circle(u.mode, u.x, u.y, u.radius)
        -- если у этого объекта естьполе sprite то рисуем его
		love.graphics.setColor(255,255,255,255)
        if u.sprite then
            drawSpr(u.sprite, u.x, u.y)
        end
    end
end
local function draw(o)
    for i = #o, 1, -1 do
        drawUnit(o[i])
    end
end
return { draw = draw }