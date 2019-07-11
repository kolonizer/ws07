function CreateMonster(id, tip)
	local k = (size - 2 * ws) / Ls -- кол-во клеток в высоту комнаты, в которые спавнят вещи
	local d=math.random(((size - 2 * ws) / Ls) * ((size - 2 * ws) / Ls))
	while Rooms[id].T[d] == 1 do
		local d=math.random(((size - 2 * ws) / Ls) * ((size - 2 * ws) / Ls))
		Rooms[id].T[d]=1
	end
	local e_x = (d % k)  --x
	if e_x == 0 then
		e_x = k
	end
	local e_y = ((d - e_x - 1) / k) * Ls+15        --y
	e_x = (e_x - 1) * Ls+15
    if tip == 'Skelet' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Skelet", Type = "circle", mode = "line", sprite = heroSprite,
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 10, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, Hit = 1, Range = 30, speed = 100,cooldawn=1,Time=0 }
        --print(inspect( Objects[#Objects], { depth = 2 } ) )
    end
    if tip == 'Slime' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Slime", Type = "circle", mode = "line", sprite = heroSprite,
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 30, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, Hit = 1, Range = 30, speed = 50,cooldawn=1,Time=0  }
    end
    if tip == 'Ghost' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Ghost", Type = "circle", mode = "line", sprite = heroSprite,
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 15, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, Hit = 1, Range = 30, speed = 100,cooldawn=1,Time=0  }
        --print(inspect( Objects[#Objects], { depth = 2 } ) )
    end
    if tip == 'Snake' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Snake", Type = "circle", mode = "line", sprite = heroSprite,
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 15, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, Hit = 1, Range = 30, speed = 10,cooldawn=1,Time=0  }
        --print(inspect( Objects[#Objects], { depth = 2 } ) )
    end
    if tip == 'Wolf' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Wolf", Type = "circle", mode = "line", sprite = heroSprite,
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 5, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, Hit = 1, Range = 30, speed = 290, active = false,cooldawn=1,Time=0 }
        --print(inspect( Objects[#Objects], { depth = 2 } ) )
    end
    if tip == 'Mushroom' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Mushroom", Type = "circle", mode = "line", sprite = heroSprite,
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 5, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, Hit = 1, Range = 30, speed = 0,cooldawn=1,Time=0 }
        --print(inspect( Objects[#Objects], { depth = 2 } ) )
    end
end

function UpdateMonster(dt)
	roomCollision=require "roomCollision"
    --print('qqq')
    --print(inspect( Objects, { depth = 2 } ) )
    for i = 1, #Objects do
		--if Objects[i].name
        --print(Objects[i].x,Objects[i].y)
        --print(Objects[i].name)
		
        if Objects[i].name == "Skelet" or Objects[i].name == "Slime" or Objects[i].name == "Mushroom" or Objects[i].name == "Snake" then
            Objects[i].cellX = (Objects[i].x - (Objects[i].x % size)) / size
            Objects[i].cellY = (Objects[i].y - (Objects[i].y % size)) / size
            Objects[i].id = (Objects[i].cellY - 1) * n + Objects[i].cellX
            if Hero.id ~= Objects[i].id then

            else
                --x1=collide.XYFromID(Hero.id)[1] * size + size / 2
                --y1=(collide.XYFromID(Hero.id)[2] + 2) * size + size / 2
                x1 = Hero.x
                y1 = Hero.y

                x2 = Objects[i].x
                y2 = Objects[i].y
                local u_x = ((Objects[i].speed * dt) / math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) * (x1 - x2))
                Objects[i].x = Objects[i].x + u_x
                if collide.CollideWith(Objects[i]) then
                    Objects[i].x = Objects[i].x - u_x
                end
                local u_y = ((Objects[i].speed * dt) / math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) * (y1 - y2))
                Objects[i].y = Objects[i].y + u_y
                if collide.CollideWith(Objects[i]) then
                    Objects[i].y = Objects[i].y - u_y
                end
            end
        end
        if Objects[i].name == "Ghost" then
            Objects[i].cellX = (Objects[i].x - (Objects[i].x % size)) / size
            Objects[i].cellY = (Objects[i].y - (Objects[i].y % size)) / size
            Objects[i].id = (Objects[i].cellY - 1) * n + Objects[i].cellX
            --x1=collide.XYFromID(Hero.id)[1] * size + size / 2
            --y1=(collide.XYFromID(Hero.id)[2] + 2) * size + size / 2
            x1 = Hero.x
            y1 = Hero.y

            x2 = Objects[i].x
            y2 = Objects[i].y
            local u_x = ((Objects[i].speed * dt) / math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) * (x1 - x2))
            Objects[i].x = Objects[i].x + u_x
            local u_y = ((Objects[i].speed * dt) / math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) * (y1 - y2))
            Objects[i].y = Objects[i].y + u_y
        end

        if Objects[i].name == 'Wolf' then
            Objects[i].cellX = (Objects[i].x - (Objects[i].x % size)) / size
            Objects[i].cellY = (Objects[i].y - (Objects[i].y % size)) / size
            Objects[i].id = (Objects[i].cellY - 1) * n + Objects[i].cellX
            --print(Objects[i].id,Hero.id)
            if roomCollision.containElem(v,Objects[i].id) then
                Objects[i].active = true
            end
            if Objects[i].active then
                if Hero.id ~= Objects[i].id then
                    x1 = collide.XYFromID(Hero.id)[1] * size + size / 2
                    y1 = (collide.XYFromID(Hero.id)[2] + 2) * size + size / 2
                else
                    x1 = Hero.x
                    y1 = Hero.y
                end
                x2 = Objects[i].x
                y2 = Objects[i].y
                local u_x = ((Objects[i].speed * dt) / math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) * (x1 - x2))
                Objects[i].x = Objects[i].x + u_x
                if collide.CollideWith(Objects[i]) then
                    Objects[i].x = Objects[i].x - u_x
                end
                local u_y = ((Objects[i].speed * dt) / math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) * (y1 - y2))
                Objects[i].y = Objects[i].y + u_y
                if collide.CollideWith(Objects[i]) then
                    Objects[i].y = Objects[i].y - u_y
                end
            end
        end
    end
end
return { CreateMonster = CreateMonster, UpdateMonster = UpdateMonster }