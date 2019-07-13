  function CreateMonster(id, tip)
	local k = (size - 2 * ws) / Ls-3 -- кол-во клеток в высоту комнаты, в которые спавнят вещи
	local d=math.random(k*k)
	Rooms[id].T[d]=1
	local e_x = (d % k)  --x
	if e_x == 0 then
		e_x = k
	end
	local e_y = ((d - e_x - 1) / k) * Ls+36       --y
	e_x = (e_x - 1) * Ls+36
    if tip == 'Skelet' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Skelet", Type = "circle", mode = "line", sprite = newSpr("spr/mobSkelet", 51, 51, 0.4, 4, 1, { 1 }),
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 10, colour = { 255, 255, 255, 0 }, HP = 80, Def = 1, speed = 100,lastTime=0,
		hit={cd=2,radius=25,x=0,y=0,Type="circle",damage=25}}
    end
    if tip == 'Slime' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Slime", Type = "circle", mode = "line", sprite = newSpr("spr/modelSlime", 51, 51, 0.23, 1, 2, {1, 2}),
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 30, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, speed = 50,lastTime=0,
		hit={cd=2,radius=45,x=0,y=0,Type="circle",damage=70}}
    end
	if tip == 'Drakula' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Drakula", Type = "circle", mode = "line", sprite = newSpr("spr/dracula", 31, 80, 0.3, 4, 3, { 1, 2, 3, 2 }),
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 15, colour = { 255, 255, 255, 0 }, HP = 600 , Def = 1, speed = 100, lastTime=0,
		hit={cd=3.5,radius=30,x=0,y=0,Type="circle",damage=40}}
    end
    if tip == 'Ghost' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Ghost", Type = "circle", mode = "line", sprite = newSpr("spr/modelGost", 51, 51, 0.7, 1, 2, {1, 2}),
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 15, colour = { 255, 255, 255, 0 }, HP = 60 , Def = 1, speed = 100,lastTime=0,
		hit={cd=3,radius=25,x=0,y=0,Type="circle",damage=30}}
    end
    if tip == 'Snake' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Snake", Type = "circle", mode = "line", sprite = newSpr("spr/modelSnake", 51, 51, 0.7, 1, 2, {1, 2}),
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 20, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, speed = 10,lastTime=0,
		hit={cd=2,radius=30,x=0,sy=0,Type="circle",damage=60}}
    end
    if tip == 'Wolf' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Wolf", Type = "circle", mode = "line", sprite = newSpr("spr/modelWolf", 51, 51, 0.52, 1, 2, {1, 2}),
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 15, colour = { 255, 255, 255, 0 }, HP = 100,Def=1, speed = 180, active = false,lastTime=0,
		hit={cd=1,radius=25 ,x=0,y=0,Type="circle",damage=20}}
    end
    if tip == 'Mushroom' then
        Objects[#Objects + 1] = { id = id, cellX = id % n, cellY = math.floor(id / n) + 1,
		name = "Mushroom", Type = "circle", mode = "line", sprite = newSpr("spr/modelMushroom", 51, 51, 0.7, 1, 2, {1, 2}),
		x = collide.XYFromID(id)[1] * size + e_x, y = (collide.XYFromID(id)[2] + 2) * size + e_y,
		radius = 20, colour = { 255, 255, 255, 0 }, HP = 1, Def = 1, speed = 0, lastTime=0,
		hit={cd=2,radius=40,x=0,y=0,Type="circle",damage=20}}
    end
end
function direction(deltaX,deltaY)
	if deltaY>0 and deltaY>math.abs(deltaX) then
		return "Up"
	elseif deltaY<0 and math.abs(deltaY)>math.abs(deltaX) then
		return "Down"
	elseif deltaX>0 and deltaX>math.abs(deltaY) then
		return "Right"
	elseif deltaX<0 and math.abs(deltaX)>math.abs(deltaY) then
		return "Left"
	end
end --FFFF 
function UpdateMonster(dt)
    --print(inspect( Objects, { depth = 2 } ) )
    for i = 1, #Objects do
        if Objects[i].sprite then
            updateSpr(Objects[i].sprite, dt)
        end
        if Objects[i].name == "Skelet" or Objects[i].name == "Slime" or Objects[i].name == "Mushroom" or Objects[i].name == "Snake" or Objects[i].name=='Drakula' then
            Objects[i].cellX = (Objects[i].x - (Objects[i].x % size)) / size
            Objects[i].cellY = (Objects[i].y - (Objects[i].y % size)) / size
            Objects[i].id = (Objects[i].cellY - 1) * n + Objects[i].cellX
            Objects[i].hit.x, Objects[i].hit.y = Objects[i].x, Objects[i].y
            if roomCollision.containElem(v,Objects[i].id) then
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
			if collide.collide(Hero,Objects[i].hit) and Objects[i].hit.cd<timer-Objects[i].lastTime then
				Objects[i].lastTime=timer
                Hero.HP=Hero.HP-Objects[i].hit.damage
            end
        end
        if Objects[i].name == "Ghost" then
            Objects[i].cellX = (Objects[i].x - (Objects[i].x % size)) / size
            Objects[i].cellY = (Objects[i].y - (Objects[i].y % size)) / size
            Objects[i].id = (Objects[i].cellY - 1) * n + Objects[i].cellX
			Objects[i].hit.x,Objects[i].hit.y=Objects[i].x,Objects[i].y
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
			if collide.collide(Hero,Objects[i].hit) and Objects[i].hit.cd<timer-Objects[i].lastTime then
				Objects[i].lastTime=timer
                Hero.HP=Hero.HP-Objects[i].hit.damage
			end
        end

        if Objects[i].name == 'Wolf' then
            Objects[i].cellX = (Objects[i].x - (Objects[i].x % size)) / size
            Objects[i].cellY = (Objects[i].y - (Objects[i].y % size)) / size
            Objects[i].id = (Objects[i].cellY - 1) * n + Objects[i].cellX
			Objects[i].hit.x,Objects[i].hit.y=Objects[i].x,Objects[i].y
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
			if collide.collide(Hero,Objects[i].hit) and Objects[i].hit.cd<timer-Objects[i].lastTime then
				Objects[i].lastTime=timer
                Hero.HP=Hero.HP-Objects[i].hit.damage*(100-Hero.Def)/100
            end
        end
    end
end
return { CreateMonster = CreateMonster, UpdateMonster = UpdateMonster }