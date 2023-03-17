require "scenes.Scene"
require "utilities.general"

StartScene = {}
StartScene.__index = StartScene
setmetatable(StartScene, Scene)

local _screenCenterX, _screenCenterY = screenCenterXY()
local _backgroundImage = love.graphics.newImage("assets/images/start_scene_background.png", {dpiscale = 1.7 })
local  _font = love.graphics.newFont("assets/fonts/Kenney Blocks.ttf", 40)
local _ROTATE_RADIAN = 0
local _SCALE_X, _SCALE_Y = 1, 1

function StartScene.new()
    local instance = setmetatable({}, StartScene) 
   
    return instance
end

function StartScene:update(dt)
    
end

function StartScene:draw()  
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.draw(_backgroundImage, 0, 0)
    love.graphics.setFont(_font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(
        "START NEW GAME" , 
        _screenCenterX, 
        _screenCenterY, 
        love.graphics:getWidth(), 
        "center", 
        _ROTATE_RADIAN, 
        _SCALE_X, 
        _SCALE_Y, 
        _screenCenterX
    )
    love.graphics.reset()
end

function StartScene:mousepressed(x, y, button, istouch)
    if _stateScene:isActive("start") then
        _stateScene:setActive("play")
    end
end