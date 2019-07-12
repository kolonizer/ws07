local function takeTool()
	for i = 1,#Rooms[Hero.id].loot do
		if Rooms[Hero.id].loot[i] ~=nil then
			--print(#Inventory)
			if collide.collide(Rooms[Hero.id].loot[i], Hero) == 1 and love.keyboard.isDown("q") and #Inventory<=10 then 
				Inventory[#Inventory + 1] = Rooms[Hero.id].loot[i]
				Rooms[Hero.id].loot[i]=nil
			end
		end
	end
end
return{takeTool = takeTool}