-- проверка на столкновение
local function CollideWith(person)
	if person.name=="Hero" then
		for i = 1, #Objects do
            if Objects[i].name~="Ghost" and collide.collide(Objects[i], person) then
		        return true
		    end
	    end
	else
		for i = 1, #Objects do
            if (Objects[i].name=="wall" or Objects[i].name=="Hero") and collide.collide(Objects[i], person) then
		        return true
		    end
	    end
	end
	return false
end
local function XYFromID(ID)
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
        if O.width + M.width >= math.abs(O.x - M.x) * 2 and O.height + M.height >= math.abs(O.y - M.y) * 2 then
            return 1
        end
    elseif O.Type == "rectangle" and M.Type == "circle" then
        if O.x - O.width / 2 <= M.x and O.x + O.width / 2 >= M.x and M.radius >= math.abs(M.y - O.y) - O.height / 2 then
            return 1
        elseif O.y - O.height / 2 <= M.y and O.y + O.height / 2 >= M.y and M.radius >= math.abs(M.x - O.x) - O.width / 2 then
            return 1
        else
            if M.radius ^ 2 >= (math.abs(O.x - M.x) - O.width / 2) ^ 2 + (math.abs(O.y - M.y) - O.height / 2) ^ 2 then
                return 1
            end
        end
    elseif O.Type == "circle" and M.Type == "rectangle" then
        if M.x - M.width / 2 <= O.x and M.x + M.width / 2 >= O.x and O.radius >= math.abs(O.y - M.y) - M.height / 2 then
            return 1
        elseif M.y - M.height / 2 <= O.y and M.y + M.height / 2 >= O.y and O.radius >= math.abs(O.x - M.x) - M.width / 2 then
            return 1
        else
            if O.radius ^ 2 >= (math.abs(M.x - O.x) - M.width / 2) ^ 2 + (math.abs(M.y - O.y) - M.height / 2) ^ 2 then
                return 1
            end
        end
    end
    return false
end
return { collide = collide, CollideWith = CollideWith, XYFromID = XYFromID}