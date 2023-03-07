require "scenes.Scene"
require "entities.PoolTable"
require "entities.Ball"

PlayScene = { poolTable,  balls = {}, whiteBall }

function PlayScene:new(word, active)

    self.poolTable = PoolTable:new()

    table.insert(self.balls, Ball:new(word, 300, 300))
    --table.insert(self.balls, Ball:new(word, 400, 200, 1))
    --table.insert(self.balls, Ball:new(word, 200, 200, 2))
    
    self.whiteBall = self.balls[1]

    local _ = PlayScene

    return setmetatable(_, {__index = Scene})
end

function PlayScene:update(dt)

    for _, ball in pairs(self.balls) do
        ball:update(dt)
    end
end

function PlayScene:draw()
    
    self.poolTable:draw()

    for _, ball in pairs(self.balls) do       
        ball:draw()
    end

    love.graphics.setColor(1, 1, 1)
end

function PlayScene:mousepressed(x, y, button, istouch)
    if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
        self.whiteBall.body:applyForce((x - self.whiteBall.body:getX()) * 10, (y - self.whiteBall.body:getY()) * 10)
       -- print(((x - ball.body:getX()) * 10).." "..((y - ball.body:getY()) * 10))
    end
 end