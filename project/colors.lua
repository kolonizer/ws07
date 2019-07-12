--- определение цветов для поддержки love 0.10.2 и новой 11.0

local colors = {
    white = { 1, 1, 1},
    black = {0, 0, 0},
    red = {1, 0, 0},
    green = {0, 1, 0},
    blue = {0, 0, 1},
    purple = {1, 0, 1},
    lightGray = { 0.25, 0.25, 0.25},
    gray = { 0.75, 0.75, 0.75},
}

local function set( c )
    local major, minor, revision, codename = love.getVersion( )
    --print(major, minor, revision, codename)
    if not colors[c] then
        c = "red"
    end
    if major == 0 and minor == 10 then
    -- LOVE2D 0.10.2
        love.graphics.setColor( colors[c][1]*255,colors[c][2]*255,colors[c][3]*255  )
    else
    -- LOVE 11.x
        love.graphics.setColor( colors[c][1],colors[c][2],colors[c][3]  )
    end
end

return { set = set }