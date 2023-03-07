require "entities.GameObject"

Cue = { whiteBall }

setmetatable(Cue, GameObject)

function Cue:new(word, whiteBall)

    self.__index = self

    local _ = setmetatable({}, Cue)

    _.whiteBall = whiteBall

    return _
end    

function Cue:update(dt)
   
end

function Cue:draw()

    love.graphics.line(self.whiteBall.body:getX(), self.whiteBall.body:getY(), 100, 100)    
end 