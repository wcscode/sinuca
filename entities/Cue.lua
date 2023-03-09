require "entities.GameObject"

Cue = { targetBall, targetX, targetY, angle, MIN_FORCE = 5, MAX_FORCE = 70 }

setmetatable(Cue, GameObject)

function Cue:new(word, targetBall)
    self.__index = self
    self.image = love.graphics.newImage("images/cue.png")
    local _ = setmetatable({}, Cue)

    _.targetBall = targetBall
    _.targetX = 0
    _.targetY = 0
    _.angle = 0

    return _
end    

function Cue:update(dt)
   
end

function Cue:draw()    
    love.graphics.translate( self.targetBall.body:getX(), self.targetBall.body:getY())   
    love.graphics.line(0,0,        
        self.targetX,
        self.targetY
    )   
    
    love.graphics.reset()
end 

function Cue:mousepressed(x, y, button, istouch)
    if button == 1 then 
        self.targetBall.body:applyLinearImpulse(self.targetX * self.MAX_FORCE, self.targetY * self.MAX_FORCE)       
    end
end

function Cue:mousemoved(x, y, dx, dy, istouch)   
    self.angle = math.atan2(y - self.targetBall.body:getY(), x - self.targetBall.body:getX())    
    self.targetX = math.cos(self.angle) * 100
    self.targetY = math.sin(self.angle) * 100   
 end