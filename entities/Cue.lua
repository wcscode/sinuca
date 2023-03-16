require "entities.GameObject"

Cue = {}
Cue.__index = Cue
setmetatable(Cue, GameObject)

local _targetBall
local _targetX = 0
local _targetY = 0
local _angle = 0
local _hit
local _MAX_STRENGTH = 100

function Cue.new(word, targetBall, hit)
    local instance = setmetatable({}, Cue) 

    _targetBall = targetBall   
    _hit = hit

    return instance
end    

function Cue:update(dt)
   return nil
end

function Cue:draw()    
    love.graphics.translate(
        _targetBall:getBody():getX(),
        _targetBall.getBody():getY()
    )   
    love.graphics.line(0, 0, _targetX, _targetY) 
    love.graphics.reset()
end 

function Cue:mousepressed(x, y, button, istouch)
    if button == 1 then 
        _targetBall.body:applyLinearImpulse(
            _targetX * _hit.strength * _MAX_STRENGTH, 
            _targetY * _hit.strength * _MAX_STRENGTH
        )       
    end
end

function Cue:mousemoved(x, y, dx, dy, istouch)   
    _angle = math.atan2(
        y - _targetBall:getBody():getY(), 
        x - _targetBall:getBody():getX()
    )    
    _targetX = math.cos(_angle) * 100
    _targetY = math.sin(_angle) * 100   
 end