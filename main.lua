require "scenes.PlayScene"
require "utilities.debug"

local world 

function love.load()    

    enableDebug = false

    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)  
    scenes = { PlayScene:new(world, true) }   
end 

function love.update(dt)
    world:update(dt)
    
    for _, scene in pairs(scenes) do        
        scene:update(dt)
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)

    for _, scene in pairs(scenes) do
        scene:draw()
    end
 
    if enableDebug then
        debugShapes(world)   
        debugMousePosition(love.mouse.getX(), love.mouse.getY())
    end
end

function love.mousepressed(x, y, button, istouch)
    for _, scene in pairs(scenes) do
        scene:mousepressed(x, y, button, istouch)
    end
    
    if button == 2 then
        enableDebug = not enableDebug
    end

end

function love.mousemoved(x, y, dx, dy, istouch)
    for _, scene in pairs(scenes) do
        scene:mousemoved(x, y, dx, dy, istouch)
    end
end

function beginContact(a, b, coll)
    for _, scene in pairs(scenes) do
        scene:beginContact(a, b, coll)
    end
end    
