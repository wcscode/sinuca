require "scenes.PlayScene"

function love.load()

    world = love.physics.newWorld(0, 0, true)
    scenes = { PlayScene:new(true) }
    
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
end

function love.mousepressed(x, y, button, istouch)

    for _, scene in pairs(scenes) do
        scene:mousepressed(x, y, button, istouch)
    end
end

function love.mousemoved(x, y, dx, dy, istouch) 

    for _, scene in pairs(scenes) do
        scene:mousemoved(x, y, dx, dy, istouch)
    end
end