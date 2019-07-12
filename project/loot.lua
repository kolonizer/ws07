Inventory = {}
local function takeTool()

local mapHeight = love.graphics.getHeight() / 6
  
  for i = 1,#Rooms[Hero.id].loot do
  
  if Rooms[Hero.id].loot[i] ~= nil then
    if collide.collide(Rooms[Hero.id].loot[i], Hero) == 1 and love.keyboard.isDown("q") and Rooms[Hero.id].loot[i].taken == 0 then    
      Rooms[Hero.id].loot.taken = 1
      
      if #Inventory < 10 then 
          Inventory[#Inventory + 1] = Rooms[Hero.id].loot[i]
      end
        
        Rooms[Hero.id].loot[i] = {}
        
      for y = 1,5 do
        for x = 1,2 do
          drawSpr(Rooms[Hero.id].loot[i].t, love.graphics.getWidth() - 3 * mapHeight + x * mapHeight,
          y * mapHeight)
        end 
      end
      
      end
    end
  end
end
return{takeTool = takeTool}