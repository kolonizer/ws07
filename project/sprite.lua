-- Библиотека загрузки и рисования спрайтов

function newSpr(name, width, height, delay, nViews, nFramesPerAnimation, framesOrder)
	-- nViews - (ракурс 1 или 4)
	-- nFramesPerAnimation - кол-во фреймов в анимации (идет вправо - 3 файла)
    local t = {
        name = name,
        width = width,
        height = height,
        spr = {},
        curAnim = "Down",
        curFrame = 1,
        viewSprite = { "Down", "Up", "Left", "Right" },
        frameDelay = delay or 0.5, --КОНСТАНТА через сколько переключаться на новый кадр
        curDelay = 0, -- сколько осталось времени до переключения на новый кадр анимации
		framesOrder = framesOrder or {1}
    }
    for i = 1, nViews do
        for j = 1, nFramesPerAnimation do
			if nViews == 1 then
				i = nil
			end
			if nFramesPerAnimation == 1 then
				j = nil
			end
            --local f = t.viewSprite[i] .. j
            --print(name..t.viewSprite[i]..j..".png")
			if i ~= nil and j ~= nil then
				local f = t.viewSprite[i] .. j
				t.spr[f] = love.graphics.newImage(name .. t.viewSprite[i] .. j .. ".png")
				print(name..t.viewSprite[i]..j..".png")
			elseif i == nil and j == nil then
				t.spr[1] = love.graphics.newImage(name .. ".png") 
				print(name..".png")
			elseif i == nil and j ~= nil then
				t.spr[j] = love.graphics.newImage(name .. j .. ".png")
				print(name .. j .. ".png")
			elseif i ~= nil and j == nil then
				t.spr[j] = love.graphics.newImage(name .. t.viewSprite[i] .. ".png")
				print(name .. t.viewSprite[i] .. ".png")
			end
		end
	end
    return t
end

function setSprAnim(t, anim)
	-- поменять направление спрайта (куда он смотрит Up Down Left Right)
    t.curAnim = anim
end

function updateSpr(t, dt)
    -- ждем delay и увеличиваем номер фрейма в анимации
    t.curDelay = t.curDelay - dt
    if t.curDelay < 0 then
        t.curDelay = t.frameDelay
        t.curFrame = t.curFrame + 1
        -- если фрэймбольше 4 то делаем снова 1
        if t.curFrame > #t.framesOrder then
            t.curFrame = 1
        end
    end
end

function drawSpr(t, x, y)
--	print(t.name.."  "..t.curAnim..t.curFrame)
	if #t.framesOrder == 1 then
		love.graphics.draw(t.spr[#t.spr], x - t.width / 2, y - t.height / 2)
	elseif #t.framesOrder == 2 then
	    love.graphics.draw(t.spr[t.framesOrder[t.curFrame]], x - t.width / 2, y - t.height / 2)
	else
		love.graphics.draw(t.spr[t.curAnim .. t.framesOrder[t.curFrame]], x - t.width / 2, y - t.height / 2)
	end
end