require "scenes.Scene"
require "entities.PoolTable"
require "entities.Ball"
require "entities.Cue"

PlayScene = { poolTable,  balls = {}, whiteBall }

function PlayScene:new(word, active)

    self.poolTable = PoolTable:new()
    self.whiteBall, self.balls = PlayScene:setInitialPositionOfBalls(self.poolTable, Ball)
   
    self.cue = Cue:new(word, self.whiteBall)

    local _ = PlayScene
    clientX = 0
    clientY = 0
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

    love.graphics.print("x: "..  self.cue.targetX .." y: "..  self.cue.targetY, 10, 10)
                                               
end

function PlayScene:setInitialPositionOfBalls(poolTable, ball)

    local balls = {}

    table.insert(balls, ball:new(word, 555, 290))

    local ballPerColumn = 5
    local ballInitialPosition = { x = 200, y = (poolTable.image:getHeight() / 2) + 20  }
    local gapBetweenBall = 20
    local offsetYPosition = 12
    local number = 1

    for x = 1, 5 do        
        for y = 1, ballPerColumn  do   

            table.insert(balls, ball:new(word, ballInitialPosition.x + (x * gapBetweenBall), ballInitialPosition.y + (y * gapBetweenBall) + (offsetYPosition * x -1), number))            
            number = number + 1
        end

        ballPerColumn = ballPerColumn - 1
    end

    return balls[1], balls   
end 

function PlayScene:mousepressed(x, y, button, istouch)  
   
    if button == 1 then 
        self.whiteBall.body:applyLinearImpulse(-1000, 0)       
    end
 end

 function PlayScene:mousemoved(x, y, dx, dy, istouch)

    --self.whiteBall.body:
    self.cue.angle = math.atan2(y, x)
    self.cue.targetX = x --math.cos(angle)
    self.cue.targetY = y --math.sin(angle)    
 end

