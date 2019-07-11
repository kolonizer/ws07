-- Ввод данных и управление с клавиатуры
collide = require "collide"
local function control(TypeControl, person, speed, GrowthSpeed)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if love.keyboard.isDown(TypeControl[1], TypeControl[4]) and love.keyboard.isDown(TypeControl[3], TypeControl[2]) then
        speed = speed / (math.sqrt(2))
    end
    if love.keyboard.isDown(TypeControl[1]) then
        person.x = person.x - speed
        if collide.CollideWith(person) then
            person.x = person.x + speed
        end
		heroSprite.curAnim = "Left" 
    end
    if love.keyboard.isDown(TypeControl[4]) then
        person.x = person.x + speed
        if collide.CollideWith(person) then
            person.x = person.x - speed
        end
		heroSprite.curAnim = "Right"
    end
    if love.keyboard.isDown(TypeControl[2]) then
        person.y = person.y - speed
        if collide.CollideWith(person) then
            person.y = person.y + speed
        end
		heroSprite.curAnim = "Up"
    end
    if love.keyboard.isDown(TypeControl[3]) then
        person.y = person.y + speed
        if collide.CollideWith(person) then
            person.y = person.y - speed
        end
		heroSprite.curAnim = "Down"
    end
    if love.keyboard.isDown("space") and Hero.hit.cd<timer-lastTime then
		lastTime=timer
		Hero.hit.visibility=true
		for i=1,#Objects do
			if Objects[i].name~="Hero" and Objects[i].name~="wall" and collide.collide(Objects[i],Hero.hit)then
				Objects[i].HP=Objects[i].HP-Hero.damage
				if Objects[i].HP<=0 then
			        Objects[i]={name="Oboltus"}
				end
			end
		end
	end
end
return { control = control }