-- отрисовка мини-карты

local function drawInventory()
	--[[if love.mouse.isDown(1) and MousX > 600 and MousY > 100 then
		local inventoryID=math.floor((MousX-600)/100)*5+math.floor(MousY/100)
		Inventory[inventoryID]=nil
		for i=inventoryID,9 do
			if Inventory[i+1]==nil then
				break
			else
				Inventory[i]=Inventory[i+1]
				Inventory[i+1]=nil
			end
		end
		repeat
		until not love.mouse.isDown(1)
	end--]]
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print("INVENTORY", 600 ,60 ,0 ,3 ,3)
	for y = 1, 5 do
		for x = 1, 2 do
		    love.graphics.setColor(0, 0, 0, 255)
		    love.graphics.rectangle("line", 500 + x * 100, y * 100, 100, 100)
			love.graphics.rectangle("line", 505 + x * 100, y * 100 + 5, 90, 90)
			local inventoryID=(x-1)*5+y
			if Inventory[inventoryID]~=nil then
			    love.graphics.setColor(0,0,0, 255)
		        love.graphics.print(Inventory[inventoryID], 505 + x * 100, y * 100 + 5)
			end
		end
	end
end
local function drawDoor(d1, d2, Type)
    local x1 = d1 % n
	local y1 = math.floor(d1 / n) + 1
    local x2 = d2 % n
	local y2 = math.floor(d2 / n) + 1
    if x1 == 0 then
        x1, y1 = n, y1 - 1
    end
    if x2 == 0 then
        x2, y2 = n, y2 - 1
    end
    local widthLine = love.graphics.getLineWidth()
    if Type == 1 then
        love.graphics.rectangle("fill", (x1 + x2) / 2 * mapSize - doorSize / 2 - mapSize / 2, (y1 + y2) / 2 * mapSize - doorSize / 2 - mapSize / 2, doorSize, doorSize)
    elseif Type == 2 then
        love.graphics.rectangle("fill", (x1 + x2) / 2 * mapSize - mapSize + widthLine, (y1 + y2) / 2 * mapSize - mapSize + widthLine, mapSize - widthLine*2, mapSize - widthLine*2)
    end
end
local function drawMiniMap(castl)
    love.graphics.clear(255, 255, 255)
    q = 0
    for y = 0, (n - 1) * mapSize, mapSize do
        for x = 0, (n - 1) * mapSize, mapSize do
            q = q + 1
            if castl[q].use then
                love.graphics.setColor(200, 200, 200, 255)
                love.graphics.rectangle("fill", x, y, mapSize, mapSize)
                love.graphics.setColor(0, 0, 0, 255)
                love.graphics.rectangle("line", x, y, mapSize, mapSize)
            end
        end
    end
    love.graphics.setColor(200, 200, 200, 255)
    for i = 1, #Doors do
        drawDoor(Doors[i].v1, Doors[i].v2, Doors[i].Type)
    end
    love.graphics.setColor(0, 0, 0, 255)
    q = 0
    for y = 0, (n - 1) * mapSize, mapSize do
        for x = 0, (n - 1) * mapSize, mapSize do
            q = q + 1
            if castl[q].use then
				love.graphics.print(castl[q].tip,x,y+mapSize-13*mapSize/60,0,mapSize/60,mapSize/60)
                love.graphics.print(q, x, y,0,mapSize/60,mapSize/60)
            end
        end
    end
    love.graphics.setColor(0, 0, 0, 50)
    love.graphics.circle("fill", Hero.cellX * mapSize - mapSize / 2, Hero.cellY * mapSize - mapSize / 2, mapSize / 4)
    love.graphics.setColor(0, 255, 0, 100)
    love.graphics.circle("fill", collide.XYFromID(max_vert1)[1] * mapSize - mapSize / 2, (collide.XYFromID(max_vert1)[2] + 2) * mapSize - mapSize / 2, mapSize / 4)
    love.graphics.setColor(255, 0, 0, 100)
    love.graphics.circle("fill", collide.XYFromID(max_vert2)[1] * mapSize - mapSize / 2, (collide.XYFromID(max_vert2)[2] + 2) * mapSize - mapSize / 2, mapSize / 4)
	drawInventory()
end
return { drawMiniMap = drawMiniMap }