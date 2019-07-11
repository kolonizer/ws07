local function takeTool()
  for i = 1,#Rooms[Hero.id].loot do
    if Rooms[Hero.id].loot[i] ~= nil then
      if collide.collide(Rooms[Hero.id].loot[i], Hero) == 1 and love.keyboard.isDown("q") and                                                       Rooms[Hero.id].loot[i].taken == 0 then    
      Rooms[Hero.id].loot.taken = 1
      table.remove(Rooms[Hero.id].loot,i)
      end
    end
  end

end
return{takeTool = takeTool}

    