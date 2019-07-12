-- отрисовка мини-карты

local function drawInventory()
	love.graphics.setColor(0, 0, 0, 255)
	local mapHeight=love.graphics.getHeight()/6
	if not love.mouse.isDown(1) then
		mous1=false
	end
	if love.mouse.isDown(1) and not mous1 then
		mous1=true
		local mousX=love.mouse.getX()
		local mousY=love.mouse.getY()
		if mousX>love.graphics.getWidth()-2*mapHeight and mousY>mapHeight then
		    local inventoryID=math.floor((mousX-love.graphics.getWidth()+2*mapHeight)/mapHeight)*5+math.floor(mousY/mapHeight)
			if Inventory[inventoryID]~=nil then
				local q= Inventory[inventoryID].tip
				if q=='Shield1' or q=='Shield2' or q=='Shield3' then
					equipment.shield=q
				elseif q=='Sword1' or q=='Sword2' or q=='LongSword1' or q=='Bow1' or q=='Rod1' or q=='Rod2' or q=='Ax1' then
					equipment.sword=q
				elseif q=='IronHelmet' or q=='MailHelmet' then
					equipment.helmet=q
				elseif q=='IronJacket' or q=='MailJacket' then
					equipment.jacket=q
				elseif q=='MailPants' or q=='IronPants' then
					equipment.pants=q
				elseif q=='HP1' then
					Hero.HP=Hero.HP+100
					if Hero.HP>500 then
						Hero.HP=500
					end
				end
				print(inspect( equipment, { depth = 2 } ) )
				table.remove(Inventory,inventoryID)
			end
		end
	end
	love.graphics.print("INVENTORY", love.graphics.getWidth()-2*mapHeight ,mapHeight-15)
	for y = 1, 5 do
		for x = 1, 2 do
			local w=love.graphics.getWidth()-3*mapHeight + x * mapHeight
			local inventoryID=(x-1)*5+y
		    love.graphics.setColor(0, 0, 0, 255)
		    love.graphics.rectangle("line", w, y * mapHeight, mapHeight, mapHeight)
			love.graphics.rectangle("line", w+5, y * mapHeight + 5, mapHeight-10, mapHeight-10)
			if Inventory[inventoryID]~=nil then
			    love.graphics.setColor(255,255,255, 255)
		        drawSpr(Inventory[inventoryID].t, love.graphics.getWidth()-3*mapHeight + (x+0.5) * mapHeight, (y+0.5) * mapHeight)
				love.graphics.setColor(0,0,0, 255)
				love.graphics.print(Inventory[inventoryID].tip, love.graphics.getWidth()-3*mapHeight + x * mapHeight+5, y * mapHeight+5)
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