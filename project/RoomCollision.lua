-- добавляет в Objects все стены комнат
-- TODO таблица visited сейчас глобальная. Не хорошо. И не инициализируется здесь.
-- 3 функции в этом модуле глобальные. а файл модуль. они не передаются в return модуля а используются напрямую. плохо
local function containElem(g, n)
    for i = 1, #g do
        if g[i] == n then
            return true
        end
    end
    return false
end
local function neighbours(g, graph)
    local A = {}
	for j = 1, #g do
        for i = 1, #graph do
            if graph[i][g[j]] ~= 0 and containElem(A, i) == false and containElem(g, i) == false then
                A[#A + 1] = i
            end
        end
    end
    return A
end
local function dfs(graph, id, n, x, y, size, w, q, colour)
    visited[#visited + 1] = id
    if (id - 1 >= 1 and graph[id][id - 1] == 0 and containElem(visited, id - 1) == false) or id % n == 1 then
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x - size / 2, y = y, wigth = w, height = size + w, colour = colour }
    end
    if (id + 1 <= n ^ 2 and graph[id][id + 1] == 0 and containElem(visited, id + 1) == false) or id % n == 0 then
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x + size / 2, y = y, wigth = w, height = size + w, colour = colour }
    end
    if (id - n >= 1 and graph[id][id - n] == 0 and containElem(visited, id - n) == false) or id <= n then
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x, y = y - size / 2, wigth = size + w, height = w, colour = colour }
    end
    if (id + n <= n ^ 2 and graph[id][id + n] == 0 and containElem(visited, id + n) == false) or id >= n * (n - 1) + 1 then
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x, y = y + size / 2, wigth = size + w, height = w, colour = colour }
    end
    if id - 1 >= 1 and graph[id][id - 1] == 1 and containElem(visited, id - 1) == false then
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x - size / 2, y = y - size * (q + 1) / 4 / q, wigth = w, height = size * (q - 1) / 2 / q + w, colour = colour }
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x - size / 2, y = y + size * (q + 1) / 4 / q, wigth = w, height = size * (q - 1) / 2 / q + w, colour = colour }
    end
    if id + 1 <= n ^ 2 and graph[id][id + 1] == 1 and containElem(visited, id + 1) == false then
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x + size / 2, y = y - size * (q + 1) / 4 / q, wigth = w, height = size * (q - 1) / 2 / q + w, colour = colour }
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x + size / 2, y = y + size * (q + 1) / 4 / q, wigth = w, height = size * (q - 1) / 2 / q + w, colour = colour }
    end
    if id - n >= 1 and graph[id][id - n] == 1 and containElem(visited, id - n) == false then
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x - size * (q + 1) / 4 / q, y = y - size / 2, wigth = size * (q - 1) / 2 / q + w, height = w, colour = colour }
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x + size * (q + 1) / 4 / q, y = y - size / 2, wigth = size * (q - 1) / 2 / q + w, height = w, colour = colour }
    end
    if id + n <= n ^ 2 and graph[id][id + n] == 1 and containElem(visited, id + n) == false then
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x - size * (q + 1) / 4 / q, y = y + size / 2, wigth = size * (q - 1) / 2 / q + w, height = w, colour = colour }
        Objects[#Objects + 1] = { Type = "rectangle", mode = "line", x = x + size * (q + 1) / 4 / q, y = y + size / 2, wigth = size * (q - 1) / 2 / q + w, height = w, colour = colour }
    end
    if id - 1 >= 1 and graph[id][id - 1] == 2 and containElem(visited, id - 1) == false then
        dfs(graph, id - 1, n, x - size, y, size, w, q, colour)
    end
    if id + 1 <= n ^ 2 and graph[id][id + 1] == 2 and containElem(visited, id + 1) == false then
        dfs(graph, id + 1, n, x + size, y, size, w, q, colour)
    end
    if id - n >= 1 and graph[id][id - n] == 2 and containElem(visited, id - n) == false then
        dfs(graph, id - n, n, x, y - size, size, w, q, colour)
    end
    if id + n <= n ^ 2 and graph[id][id + n] == 2 and containElem(visited, id + n) == false then
        dfs(graph, id + n, n, x, y + size, size, w, q, colour)
    end
end
return { dfs = dfs, neighbours=neighbours}
