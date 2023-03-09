require "scenes.Scene"
require "entities.PoolTable"
require "entities.Ball"
require "entities.UIStrengthBar"
require "entities.Cue"
require "utilities.builders"

PlayScene = { poolTable,  balls = {}, whiteBall }

function PlayScene:new(world, active)
    self.poolTable = PoolTable:new(world)
    self.uiStrengthBar = UIStrengthBar:new(550, 10, false)     
    self.whiteBall, self.balls = buildInitialPositionOfBalls(world, self.poolTable, Ball)  
    self.cue = Cue:new(world, self.whiteBall, self.uiStrengthBar.hit)    

    local _ = PlayScene

    return setmetatable(_, {__index = Scene})
end

function PlayScene:update(dt)
    self.uiStrengthBar:update(dt)

    for _, ball in pairs(self.balls) do
        ball:update(dt)
    end
end

function PlayScene:draw()  
    self.uiStrengthBar:draw()
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

        if(numberOfBall > 1) then
            table.remove(self.balls, numberOfBall + 1)            
          --  print("a")
            print(b:getShape())
            b:destroy()
          --  print("b")
            print(b:getShape())
           -- print("end" .. numberOfBall .. " length ".. #self.balls)
       -- b:release()             
        end
    end
end   
