require "scenes.Scene"
require "utilities.general"

StartScene = {}
StartScene.__index = StartScene
setmetatable(StartScene, Scene)

local _screenCenterX
local _screenCenterY 
local _backgroundImage
local _font

function StartScene.new()
    local instance = setmetatable({}, StartScene) 
    
    _screenCenterX, _screenCenterY = screenCenterXY()
    _font = love.graphics.newFont("assets/fonts/Kenney Blocks.ttf", 40)
    _backgroundImage = love.graphics.newImage("assets/images/start_scene_background.png", {dpiscale = 1.7 })
            
    return instance
end

function StartScene:update(dt)
    
end

function StartScene:draw()  
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.draw(_backgroundImage, 0, 0)
    love.graphics.setFont(_font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("START NEW GAME" , _screenCenterX, _screenCenterY, love.graphics:getWidth(), "center", 0, 1, 1,_screenCenterX)
    love.graphics.reset()
end