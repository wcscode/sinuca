require "scenes.Scene"
require "entities.PoolTable"
require "entities.Ball"
require "entities.UIStrengthBar"
require "entities.UIListBalls"
require "entities.Cue"
require "utilities.builders"
require "utilities.general"

PlayScene = { poolTable,  balls = {}, whiteBall }

function PlayScene:new(world, active)
    self.poolTable = PoolTable:new(world)
    self.uiStrengthBar = UIStrengthBar:new(585, 10, false) 
    self.whiteBall, self.balls = buildInitialPositionOfBalls(world, self.poolTable, Ball)
    self.uiListBalls = UIListBalls:new(50, 10, self.balls)   
    self.cue = Cue:new(world, self.whiteBall, self.uiStrengthBar.hit)    

    local _ = PlayScene

    return setmetatable(_, {__index = Scene})
end

function PlayScene:update(dt)
    self.uiListBalls:update(dt)
    self.uiStrengthBar:update(dt)

    for _, ball in pairs(self.balls) do
        ball:update(dt)
    end
end

function PlayScene:draw() 
    self.uiListBalls:draw() 
    self.uiStrengthBar:draw()
    self.poolTable:draw()
    self.cue:draw()

    for _, ball in pairs(self.balls) do       
        ball:draw()
    end    
    
    if not enableDebug then        
        debugBalls(self.balls)
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

        if(numberOfBall >= 1) then
            for index, ball in pairs(self.balls) do
                if ball.number == numberOfBall then
                    table.remove(self.balls, index)    
                end
            end

            b:destroy()            
        end
    end
end   
