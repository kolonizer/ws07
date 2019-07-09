local function control(TypeControl, person, speed, GrowthSpeed)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if love.keyboard.isDown(TypeControl[1], TypeControl[4]) and love.keyboard.isDown(TypeControl[3], TypeControl[2]) then
        speed = speed / (math.sqrt(2))
    end
    if love.keyboard.isDown(TypeControl[1]) then
        person.x = person.x - speed
        if CollideWith(person.name) then
            person.x = person.x + speed
        end
    end
    if love.keyboard.isDown(TypeControl[4]) then
        person.x = person.x + speed
        if CollideWith(person.name) then
            person.x = person.x - speed
        end
    end
    if love.keyboard.isDown(TypeControl[2]) then
        person.y = person.y - speed
        if CollideWith(person.name) then
            person.y = person.y + speed
        end
    end
    if love.keyboard.isDown(TypeControl[3]) then
        person.y = person.y + speed
        if CollideWith(person.name) then
            person.y = person.y - speed
        end
    end
    if love.keyboard.isDown(TypeControl[5]) then
        if person.Type == "circle" then
            person.radius = person.radius + GrowthSpeed
        elseif person.Type == "rectangle" then
            person.wigth, person.height = person.wigth + GrowthSpeed, person.height + GrowthSpeed * person.height / person.wigth
        end
        if CollideWith(person.name) then
            if person.Type == "circle" then
                person.radius = person.radius - GrowthSpeed
            elseif person.Type == "rectangle" then
                person.wigth, person.height = person.wigth - GrowthSpeed, person.height - GrowthSpeed * person.height / person.wigth
            end
        end
    end
    if love.keyboard.isDown(TypeControl[6]) then
        if person.Type == "circle" and person.radius > GrowthSpeed then
            person.radius = person.radius - GrowthSpeed
        elseif person.Type == "rectangle" and person.wigth > GrowthSpeed and person.height > GrowthSpeed then
            person.wigth, person.height = person.wigth - GrowthSpeed, person.height - GrowthSpeed * person.height / person.wigth
        end
        if CollideWith(person.name) then
            if person.Type == "circle" then
                person.radius = person.radius + GrowthSpeed
            elseif person.Type == "rectangle" then
                person.wigth, person.height = person.wigth + GrowthSpeed, person.height + GrowthSpeed * person.height / person.wigth
            end
        end
    end
end
return { control = control }