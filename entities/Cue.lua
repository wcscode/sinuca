require "entities.GameObject"

Cue = {}
Cue.__index = Cue
setmetatable(Cue, GameObject)

local _MAX_STRENGTH = 100

function Cue.new(word, targetBall, hit)
    local instance = setmetatable({}, Cue) 

    instance.targetBall = targetBall 
    instance.targetX = 0
    instance.targetY = 0  
    instance.hit = hit

    return instance
end    

function Cue:update(dt)
   return nil
end

function Cue:draw()    
    love.graphics.translate(
        self.targetBall.body:getX(),
        self.targetBall.body:getY()
    )   
    love.graphics.line(0, 0, self.targetX, self.targetY) 
    love.graphics.reset()
 end 

function Cue:mousepressed(x, y, button, istouch)
    if button == 1 then 
        self.targetBall.body:applyLinearImpulse(
            self.targetX * self.hit.strength * _MAX_STRENGTH, 
            self.targetY * self.hit.strength * _MAX_STRENGTH
        )       
    end
end

function Cue:mousemoved(x, y, dx, dy, istouch)       
    local angle = math.atan2(
        y - self.targetBall.body:getY(), 
        x - self.targetBall.body:getX()
    )       
    self.targetX = math.cos(angle) * 100
    self.targetY = math.sin(angle) * 100   
 end