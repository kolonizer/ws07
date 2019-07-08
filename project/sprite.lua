-- Библиотека загрузки и рисования спрайтов

local framesOrderMobs = {2,1,2,3}
local framesOrderBurn = {1,2}
local framesOrderItem = {1}

function newSpr(name, width, height, delay, view, anima)
	local t = {
		name = name,
		width = width,
		height = height,
		spr = {},
		curAnim = "Down",
		curFrame = 1,
		viewSprite = {"Down", "Up", "Left", "Right"},
		frameDelay = delay or 0.5, --КОНСТАНТА через сколько переключаться на новый кадр
		curDelay = 0, -- сколько осталось времени до переключения на новый кадр анимации
	}

	for i = 1, view do
		for j = 1, anima do
			local f = t.viewSprite[i]..j
			--print(name..t.viewSprite[i]..j..".png")
			t.spr[f] = love.graphics.newImage(name..t.viewSprite[i]..j..".png")
		end
	end
	return t
end

--[[function newSpr2(name, width, height)
	local t2 = {
		name = name,
		width = width,
		height = height,
		spr = {},
		curAnim = "Down",
		curFrame = 1,
		viewSprite = {"Up", "Down", "Left", "Right"},
		frameDelay = 0.2, --КОНСТАНТА через сколько переключаться на новый кадр
		curDelay = 0, -- сколько осталось времени до переключения на новый кадр анимации
	}
	
	for i = 1, 4 do
		for j = 1, 3 do
			local f = t2.viewSprite[i]..j
			t2.spr[f] = love.graphics.newImage(name..t2.viewSprite[i]..j..".png")
		end
	end
	return t2
end--]]

function setSprAnim(t, anim)
	t.curAnim = anim
end

function updateSpr(t, dt)
	-- ждем delay и увеличиваем номер фрейма в анимации
	t.curDelay = t.curDelay - dt
	if t.curDelay < 0 then
		t.curDelay = t.frameDelay
		t.curFrame = t.curFrame + 1
		-- если фрэймбольше 4 то делаем снова 1
		if t.curFrame > #framesOrderMobs then
			t.curFrame = 1
		end
	end
end

function updateSpr2(t, dt)
	-- ждем delay и увеличиваем номер фрейма в анимации
	t.curDelay = t.curDelay - dt
	if t.curDelay < 0 then
		t.curDelay = t.frameDelay
		t.curFrame = t.curFrame + 1
		-- если фрэймбольше 4 то делаем снова 1
		if t.curFrame > #framesOrderBurn then
			t.curFrame = 1
		end
	end
end


function drawSpr(t, x, y)
--	print(t.curAnim..t.curFrame)
	love.graphics.draw(t.spr[t.curAnim..framesOrderMobs[t.curFrame]], x - t.width / 2, y - t.height / 2)
end

function drawSpr2(t, x, y)
	--print(t.curAnim..t.curFrame)
	love.graphics.draw(t.spr[t.curAnim..framesOrderBurn[t.curFrame]], x - t.width / 2, y - t.height / 2)
end

function drawSpr0(t, x, y)
	--print(t.curAnim..t.curFrame)
	love.graphics.draw(t.spr[t.curAnim..framesOrderItem[t.curFrame]], x - t.width / 2, y - t.height / 2)
end