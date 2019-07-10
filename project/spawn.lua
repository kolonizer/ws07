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
    local T = {}
    local rand100 = math.random(1, 100)
    local d = math.random(((size - 2 * ws) / Ls) * ((size - 2 * ws) / Ls))
    while (rooms[id].T[d] == 1) do
        d = math.random(((size - 2 * ws) / Ls) * ((size - 2 * ws) / Ls))
    end
    rooms[id].T[d] = 1
    rooms[id].loot[#rooms[id].loot + 1] = { id = d, number = rand100, tip = range[rand100][2] }
end
local function drawLoot(tab, rooms)
    local k = (size - 2 * ws) / Ls
    for i = 1, #tab do
        for o = 1, #rooms[tab[i]].loot do
            local e_x = (rooms[tab[i]].loot[o].id % k)  --x
            if e_x == 0 then
                e_x = k
            end
            local e_y = ((rooms[tab[i]].loot[o].id - e_x - 1) / k) * Ls        --y
            e_x = (e_x - 1) * Ls
            e_x = e_x + rooms[tab[i]].x_pix + ws + 15
            e_y = e_y + rooms[tab[i]].y_pix + 2 * ws + 15
            drawSpr(range[rooms[tab[i]].loot[o].number][1], e_x, e_y)
        end
    end
end
return { AddLotLoot = AddLotLoot, drawLoot = drawLoot }