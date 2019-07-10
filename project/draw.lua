-- Отрисовка всех юнитов
collide=require "collide"
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
	for i=#DoorsOfRoom,1,-1 do
		if collide.collide(DoorsOfRoom[i],Hero)==false then
		    love.graphics.setColor(DoorsOfRoom[i].colour[1],DoorsOfRoom[i].colour[2],DoorsOfRoom[i].colour[3],DoorsOfRoom[i].colour[4])
		    love.graphics.rectangle("line", DoorsOfRoom[i].x - DoorsOfRoom[i].wigth / 2, DoorsOfRoom[i].y - DoorsOfRoom[i].height / 2, DoorsOfRoom[i].wigth, DoorsOfRoom[i].height)
		end
	end
    for i = #o, 1, -1 do
        drawUnit(o[i])
    end
end
return { draw = draw }