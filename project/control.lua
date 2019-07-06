local function Touch()
	for i=1,#Objects do
		if collide.collide(Objects[i],Mous) then
			return true
		end
	end
	return false
end	
local function control(TypeControl,speed,GrowthSpeed)
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
	if TypeControl=="mous" then
		cursor = love.mouse.getCursor()
		X,Y = love.mouse.getPosition()
		local q=math.sqrt((Y-Mous.y)^2+(X-Mous.x)^2)/speed
		local qx=math.abs(X-Mous.x)/q
		local qy=math.abs(Y-Mous.y)/q
		if X-speed>Mous.x then
			Mous.x=Mous.x+qx
			if Touch() then 
				Mous.x=Mous.x-qx
			end
		elseif X+speed<Mous.x then
			Mous.x=Mous.x-qx
			if Touch() then 
				Mous.x=Mous.x+qx
			end
		end
		if Y-speed>Mous.y then
			Mous.y=Mous.y+qy
			if Touch() then 
				Mous.y=Mous.y-qy
			end
		elseif Y+speed<Mous.y then
			Mous.y=Mous.y-qy
			if Touch() then 
				Mous.y=Mous.y+qy
			end
		end
	elseif TypeControl=="keyboard" then
		if love.keyboard.isDown("a") then
			Mous.x=Mous.x-speed
			if Touch() then
				Mous.x=Mous.x+speed
			end
		end
		if love.keyboard.isDown("d") then
			Mous.x=Mous.x+speed
			if Touch() then
				Mous.x=Mous.x-speed
			end
		end
		if love.keyboard.isDown("w") then
			Mous.y=Mous.y-speed
			if Touch()then
				Mous.y=Mous.y+speed
			end
		end
		if love.keyboard.isDown("s") then
			Mous.y=Mous.y+speed
			if Touch() then
				Mous.y=Mous.y-speed
			end
		end
	end
	if love.keyboard.isDown("q") then
		if Mous.Type=="circle" then
			Mous.radius=Mous.radius+GrowthSpeed
		elseif Mous.Type=="rectangle" then
			Mous.wigth,Mous.height=Mous.wigth+GrowthSpeed,Mous.height+GrowthSpeed*Mous.height/Mous.wigth
		end
		if Touch() then
			if Mous.Type=="circle" then
				Mous.radius=Mous.radius-GrowthSpeed
			elseif Mous.Type=="rectangle" then
				Mous.wigth,Mous.height=Mous.wigth-GrowthSpeed,Mous.height-GrowthSpeed*Mous.height/Mous.wigth
			end
		end
	end
	if love.keyboard.isDown("e") then
		if Mous.Type=="circle" and Mous.radius>GrowthSpeed then
			Mous.radius=Mous.radius-GrowthSpeed
		elseif Mous.Type=="rectangle" and Mous.wigth>GrowthSpeed and Mous.height>GrowthSpeed then
			Mous.wigth,Mous.height=Mous.wigth-GrowthSpeed,Mous.height-GrowthSpeed*Mous.height/Mous.wigth
		end
		if Touch() then
			if Mous.Type=="circle" then
				Mous.radius=Mous.radius+GrowthSpeed
			elseif Mous.Type=="rectangle" then
				Mous.wigth,Mous.height=Mous.wigth+GrowthSpeed,Mous.height+GrowthSpeed*Mous.height/Mous.wigth
			end
		end
	end
end
return {control=control}