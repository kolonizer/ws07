-- проверка на столкновение
function CollideWith(person)
    if person=="Hero" then
		for i = 1, #Objects do
            if collide.collide(Objects[i], Hero) then
			    return true
            end
		end
		return false
    end
end
function XYfromID(ID)
    local x = ID % n
    local y = math.floor(ID / n) - 1
    if x == 0 then
        x = n
        y = y - 1
    end
    return { x, y }
end
local function collide(O, M)
    if O == M then
        return false
    end
    if O.Type == "circle" and M.Type == "circle" then
        if (O.radius + M.radius) ^ 2 >= (O.x - M.x) ^ 2 + (O.y - M.y) ^ 2 then
            return 1
        end
    elseif O.Type == "rectangle" and M.Type == "rectangle" then
        if O.wigth + M.wigth >= math.abs(O.x - M.x) * 2 and O.height + M.height >= math.abs(O.y - M.y) * 2 then
            return 1
        end
    elseif O.Type == "rectangle" and M.Type == "circle" then
        if O.x - O.wigth / 2 <= M.x and O.x + O.wigth / 2 >= M.x and M.radius >= math.abs(M.y - O.y) - O.height / 2 then
            return 1
        elseif O.y - O.height / 2 <= M.y and O.y + O.height / 2 >= M.y and M.radius >= math.abs(M.x - O.x) - O.wigth / 2 then
            return 1
        else
            if M.radius ^ 2 >= (math.abs(O.x - M.x) - O.wigth / 2) ^ 2 + (math.abs(O.y - M.y) - O.height / 2) ^ 2 then
                return 1
            end
        end
    elseif O.Type == "circle" and M.Type == "rectangle" then
        if M.x - M.wigth / 2 <= O.x and M.x + M.wigth / 2 >= O.x and O.radius >= math.abs(O.y - M.y) - M.height / 2 then
            return 1
        elseif M.y - M.height / 2 <= O.y and M.y + M.height / 2 >= O.y and O.radius >= math.abs(O.x - M.x) - M.wigth / 2 then
            return 1
        else
            if O.radius ^ 2 >= (math.abs(M.x - O.x) - M.wigth / 2) ^ 2 + (math.abs(M.y - O.y) - M.height / 2) ^ 2 then
                return 1
            end
        end
    end
    return false
end
return { collide = collide }