local function drawUnit(u)
	if u.Type=="rectangle" then
		love.graphics.rectangle( u.mode, u.x - u.wigth/2, u.y - u.height/2, u.wigth, u.height)
	elseif u.Type=="circle" then
		love.graphics.circle( u.mode, u.x, u.y, u.radius)
		-- если у этого объекта естьполе sprite то рисуем его
		if u.sprite then
			drawSpr( u.sprite, u.x, u.y )
		end
	end
end
local function draw(o)
	for i=1,#o do
		drawUnit( o[i] )	
	end
end
return {draw=draw}