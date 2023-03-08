require "scenes.Scene"
require "entities.PoolTable"
require "entities.Ball"
require "entities.Cue"
require "utilities.builders"

PlayScene = { poolTable,  balls = {}, whiteBall }

function PlayScene:new(word, active)
    self.poolTable = PoolTable:new()
    self.whiteBall, self.balls = buildInitialPositionOfBalls(self.poolTable, Ball)   
    self.cue = Cue:new(word, self.whiteBall)

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
    self.cue:draw()

    for _, ball in pairs(self.balls) do       
        ball:draw()
    end                                               
end

function PlayScene:mousepressed(x, y, button, istouch) 
    self.cue:mousepressed(x, y, button, istouch) 
end

function PlayScene:mousemoved(x, y, dx, dy, istouch)
    self.cue:mousemoved(x, y, dx, dy, istouch)     
end

function PlayScene:beginContact(a, b, coll)    
    if a:getUserData() == "pocket" then 
        local numberOfBall = b:getUserData()
        print("removed " .. numberOfBall + 1)

        if(numberOfBall > 1) then
            table.remove(self.balls, numberOfBall + 1)
            b:getShape():release()
            --b:getBody():release()
       -- b:release()             
        end
    end
end   
