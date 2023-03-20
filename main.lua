require "scenes.StartScene"
require "scenes.PlayScene"
require "utilities.debug"

local _world 
_stateScene = {}
enableDebug = false

function love.load()         
    _world = love.physics.newWorld(0, 0, true) 
    love.mouse.setVisible(false) 
    --love.mouse.setRelativeMode(true)
    --for n in pairs(_G) do print(n) end
    _world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    _stateScene = StateManager.new()
 
    _stateScene:add("start", StartScene.new())
    _stateScene:add("play", PlayScene.new(_world))
   
    _stateScene:setActive("start")
end 

function love.update(dt)
    _world:update(dt)
    
    _stateScene.currentState.value:update(dt)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)

    _stateScene.currentState.value:draw()  
 
    if enableDebug then
        debugShapes(_world)   
        debugMousePosition(love.mouse.getX(), love.mouse.getY())
    end
end

function love.mousepressed(x, y, button, istouch)
    _stateScene.currentState.value:mousepressed(x, y, button, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
    _stateScene.currentState.value:mousemoved(x, y, dx, dy, istouch)
end

function beginContact(a, b, coll)    
    _stateScene.currentState.value:beginContact(a, b, coll)
end    
