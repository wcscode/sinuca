UIListBalls = {}
UIListBalls.__index = UIListBalls
setmetatable(UIListBalls, GameObject)

local _x
local _y
local _width
local _height
local _balls = {}
local _gapX = 30
local _gapY = 10

function UIListBalls.new(x, y, balls)     
    local instance = setmetatable({}, UIListBalls)

    _x = x
    _y = y
    _width = _gapX * 15 + _gapX * 2
    _height = 45
    _balls = balls

    return instance
end

function UIListBalls:update(dt)
    return nil
end

function UIListBalls:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", _x, _y, _width, _height)

    love.graphics.reset()

    for i = 2, #_balls do        
        love.graphics.draw(_balls[i]:getImage(), _x + _gapX * (i - 1), _y + _gapY)  
    end   
end