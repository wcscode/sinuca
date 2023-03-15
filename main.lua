require "scenes.StartScene"
require "scenes.PlayScene"
require "utilities.debug"

local _world 
local _stateScene

function love.load()    

    enableDebug = false
    
    _world = love.physics.newWorld(0, 0, true)  
    _world:setCallbacks(beginContact, endContact, preSolve, postSolve)      
    _stateScene = StateManager:new()
 
     startScene = StartScene:new()
     print(_world)
     playScene = PlayScene:new(_world)
     
    _stateScene:add("start", startScene)
    _stateScene:add("play", playScene)
   
    _stateScene:setActive("start")
end 

function love.update(dt)
    _world:update(dt)
    
    _stateScene:getActiveValue():update(dt)
   -- for _, scene in pairs(scenes) do        
   --     scene:update(dt)
   -- end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)

    _stateScene:getActiveValue():draw()
    --for _, scene in pairs(scenes) do
   --     scene:draw()
   -- end
 
    if enableDebug then
        debugShapes(_world)   
        debugMousePosition(love.mouse.getX(), love.mouse.getY())
    end
end

function love.mousepressed(x, y, button, istouch)
   -- for _, scene in pairs(scenes) do
   --     scene:mousepressed(x, y, button, istouch)
   -- end
    if _stateScene:isActive("start") then
        _stateScene:setActive("play")
    end

    _stateScene:getActiveValue():mousepressed(x, y, button, istouch)

    if button == 2 then
        enableDebug = not enableDebug
    end

end

function love.mousemoved(x, y, dx, dy, istouch)
  --  for _, scene in pairs(scenes) do
  --      scene:mousemoved(x, y, dx, dy, istouch)
  --  end
  _stateScene:getActiveValue():mousepressed(x, y, button, istouch)
end

function beginContact(a, b, coll)
    for _, scene in pairs(scenes) do
        scene:beginContact(a, b, coll)
    end
end    
