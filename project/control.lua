local function Touch()
    for i = 1, #Objects do
        if collide.collide(Objects[i], Hero) then
            return true
        end
    end
    return false
end
local function control(TypeControl, speed, GrowthSpeed)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if TypeControl == "keyboard" then
        if love.keyboard.isDown("a", "d") and love.keyboard.isDown("s", "w") then
            speed = speed / (math.sqrt(2))
        end
        if love.keyboard.isDown("a") then
            Hero.x = Hero.x - speed
            if Touch() then
                Hero.x = Hero.x + speed
            end
        end
        if love.keyboard.isDown("d") then
            Hero.x = Hero.x + speed
            if Touch() then
                Hero.x = Hero.x - speed
            end
        end
        if love.keyboard.isDown("w") then
            Hero.y = Hero.y - speed
            if Touch() then
                Hero.y = Hero.y + speed
            end
        end
        if love.keyboard.isDown("s") then
            Hero.y = Hero.y + speed
            if Touch() then
                Hero.y = Hero.y - speed
            end
        end
    end
    if love.keyboard.isDown("q") then
        if Hero.Type == "circle" then
            Hero.radius = Hero.radius + GrowthSpeed
        elseif Hero.Type == "rectangle" then
            Hero.wigth, Hero.height = Hero.wigth + GrowthSpeed, Hero.height + GrowthSpeed * Hero.height / Hero.wigth
        end
        if Touch() then
            if Hero.Type == "circle" then
                Hero.radius = Hero.radius - GrowthSpeed
            elseif Hero.Type == "rectangle" then
                Hero.wigth, Hero.height = Hero.wigth - GrowthSpeed, Hero.height - GrowthSpeed * Hero.height / Hero.wigth
            end
        end
    end
    if love.keyboard.isDown("e") then
        if Hero.Type == "circle" and Hero.radius > GrowthSpeed then
            Hero.radius = Hero.radius - GrowthSpeed
        elseif Hero.Type == "rectangle" and Hero.wigth > GrowthSpeed and Hero.height > GrowthSpeed then
            Hero.wigth, Hero.height = Hero.wigth - GrowthSpeed, Hero.height - GrowthSpeed * Hero.height / Hero.wigth
        end
        if Touch() then
            if Hero.Type == "circle" then
                Hero.radius = Hero.radius + GrowthSpeed
            elseif Hero.Type == "rectangle" then
                Hero.wigth, Hero.height = Hero.wigth + GrowthSpeed, Hero.height + GrowthSpeed * Hero.height / Hero.wigth
            end
        end
    end
end
return { control = control }