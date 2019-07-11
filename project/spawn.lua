-- Разбросать вещи в комнате
local function AddLotLoot(id, rooms)
    local k = (size - 2 * ws) / Ls -- кол-во клеток в высоту комнаты, в которые спавнят вещи
    local Q = {}
    Q.x = (id % k)
    if Q.x == 0 then
        Q.x = k
    end
    Q.y = collide.XYFromID(id)[2] * size
    Q.x = collide.XYFromID(id)[1] * size
    Q.h = size      -- длина
    local rand100 = math.random(1, 100)
    local d = math.random(((size - 2 * ws) / Ls) * ((size - 2 * ws) / Ls))
    while rooms[id].T[d] == 1 do
        d = math.random(((size - 2 * ws) / Ls) * ((size - 2 * ws) / Ls))
    end
	
	local e_x = (d % k)  --x
            if e_x == 0 then
                e_x = k
            end
            local e_y = ((d - e_x - 1) / k) * Ls        --y
            e_x = (e_x - 1) * Ls
            e_x = e_x + rooms[id].x_pix + ws
            e_y = e_y + rooms[id].y_pix + 2 * ws
			
    rooms[id].T[d] = 1  --If you dont know English ask for translate your master PLZ
    rooms[id].loot[#rooms[id].loot + 1] = { id = d, number = rand100, tip = rand[rand100][2],x=e_x, y=e_y,Type='rectangle', width = 31, height = 31, taken = 0 }
end
local function drawLoot(tab, rooms)
    local k = (size - 2 * ws) / Ls
    for i = 1, #tab do
        for o = 1, #rooms[tab[i]].loot do
            drawSpr(rand[rooms[tab[i]].loot[o].number][1], rooms[tab[i]].loot[o].x+15, rooms[tab[i]].loot[o].y+15)
        end
    end
end
return { AddLotLoot = AddLotLoot, drawLoot = drawLoot }