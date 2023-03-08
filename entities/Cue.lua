require "entities.GameObject"

Cue = { whiteBall, targetX, targetY, angle }

setmetatable(Cue, GameObject)

function Cue:new(word, whiteBall)

    self.__index = self

    local _ = setmetatable({}, Cue)

    _.whiteBall = whiteBall
    _.targetX = 0
    _.targetY = 0
    _.angle = 0

    return _
end    

function Cue:update(dt)
   
end

function Cue:draw()
    love.graphics.rotate( self.angle )
    love.graphics.translate( self.whiteBall.body:getX(), self.whiteBall.body:getY() )
    love.graphics.line(
        self.whiteBall.body:getX(), 
        self.whiteBall.body:getY(), 
        self.whiteBall.body:getX() + 100,
        self.whiteBall.body:getY() + 100
    )   
    love.graphics.rotate(0) 
    love.graphics.translate(-self.whiteBall.body:getX(), -self.whiteBall.body:getY())
end 