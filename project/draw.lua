-- Отрисовка всех юнитов
collide=require "collide"
local function drawUnit(u)
	colors.set( u.colour )
    if u.Type == "rectangle" then
        love.graphics.rectangle(u.mode, u.x - u.width / 2, u.y - u.height / 2, u.width, u.height)
    elseif u.Type == "circle" then
        love.graphics.circle(u.mode, u.x, u.y, u.radius)
        -- если у этого объекта естьполе sprite то рисуем его
        colors.set("white")
        if u.sprite then
            drawSpr(u.sprite, u.x, u.y)
        end
    end
end
local function drawDoor(x)
	if collide.collide(x,Hero)==false then
	    if x.colour then --== "white" then
			colors.set( "purple" )
		else
			colors.set( x.colour )
		end
	    love.graphics.rectangle("line", x.x - x.width / 2, x.y - x.height / 2, x.width, x.height)
	end
end
local function drawFloor()
	colors.set("lightGray")
	for i=1,#v do
		love.graphics.rectangle("fill",(collide.XYFromID(v[i])[1])*size-2.5,(collide.XYFromID(v[i])[2]+2)*size-2.5,size+5,size+5)
	end
end
local function draw(o)
	--drawFloor()
	roomCollision=require "roomCollision"
	for i=#DoorsOfRoom,1,-1 do
		drawDoor(DoorsOfRoom[i])
	end
	--
    for i = #o, 1, -1 do
        if (o[i].name=="Hero" or o[i].name=="wall" or roomCollision.containElem(v,Objects[i].id)) and o[i].name~="Oboltus" then
			drawUnit(o[i])
		end
    end
	if Hero.hit.visibility==true then
		colors.set( Hero.hit.colour )
		love.graphics.circle("line",Hero.x,Hero.y,Hero.hit.radius + math.sin(timer * 30) * 10)
	end

end
return { draw = draw, drawFloor = drawFloor }