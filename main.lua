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
    for _, scene in pairs(scenes) do
        scene:draw()
    end
end