require "scenes.Scene"
require "entities.Ball"

PlayScene = {}

function PlayScene:new(word, active)

    balls = {}

    table.insert(balls, Ball:new(word, 300, 300))
    table.insert(balls, Ball:new(word, 100, 100, 1))
    table.insert(balls, Ball:new(word, 200, 200, 2))
    
    local _ = PlayScene

    return setmetatable(_, {__index = Scene})

end

function PlayScene:update(dt)
    for _, ball in pairs(balls) do
        ball:update(dt)
    end
end

function PlayScene:draw()
    for _, ball in pairs(balls) do       
        ball:draw()
    end
end