require "scenes.Scene"
require "utilities.general"

StartScene = {}
StartScene.__index = StartScene
setmetatable(StartScene, Scene)

local _screenCenterX, _screenCenterY = screenCenterXY()

local _font = love.graphics.newFont("assets/fonts/Kenney Blocks.ttf", 40)

function StartScene.new()
    local instance = setmetatable({}, StartScene)         
    return instance
end

function StartScene:update(dt)
    
end

function StartScene:draw()  
    love.graphics.setFont(_font)
    love.graphics.printf("START NEW GAME" , _screenCenterX, _screenCenterY, love.graphics:getWidth(), "center", 0, 1, 1,_screenCenterX)
    love.graphics.reset()
end