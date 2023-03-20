UIGameOver = {}
UIGameOver.__index = UIGameOver
setmetatable(UIGameOver, GameObject)

local _width
local _height
local _font = love.graphics.newFont("assets/fonts/Kenney Future Narrow.ttf", 40)
local _screenCenterX, _screenCenterY = screenCenterXY()
local _ROTATE_RADIAN = 0
local _SCALE_X, _SCALE_Y = 1, 1

function UIGameOver.new()     
    local instance = setmetatable({}, UIGameOver)

    return instance
end

function UIGameOver:update(dt)
    return nil
end

function UIGameOver:draw()
    love.graphics.setColor(0, 0, 0, 0.8)    
    love.graphics.rectangle("fill", 0, 0, love.graphics:getWidth() , love.graphics:getHeight())
    love.graphics.setFont(_font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(
        "GAME OVER" , 
        _screenCenterX, 
        _screenCenterY, 
        love.graphics:getWidth(), 
        "center", 
        _ROTATE_RADIAN, 
        _SCALE_X, 
        _SCALE_Y, 
        _screenCenterX,        
    )
end

--function UIGameOver:mousepressed(x, y, button, istouch) 
--end 
