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
local function drawDoor(x)
	if collide.collide(x,Hero)==false then
	    if x.colour[1]==255 and x.colour[2]==255 and x.colour[3]==255 and x.colour[4]==255 then
			love.graphics.setColor(100,100,255,255)
		else
			love.graphics.setColor(x.colour[1],x.colour[2],x.colour[3],x.colour[4])
		end
	    love.graphics.rectangle("line", x.x - x.wigth / 2, x.y - x.height / 2, x.wigth, x.height)
	end
end
local function drawFloor()
	love.graphics.setColor(50,50,50,255)
	for i=1,#v do
		love.graphics.rectangle("fill",(collide.XYFromID(v[i])[1])*size-2.5,(collide.XYFromID(v[i])[2]+2)*size-2.5,size+5,size+5)
	end
end
local function draw(o)
	--drawFloor()
	for i=#DoorsOfRoom,1,-1 do
		drawDoor(DoorsOfRoom[i])
	end
    for i = #o, 1, -1 do
        drawUnit(o[i])
    end
end
return { draw = draw, drawFloor = drawFloor }