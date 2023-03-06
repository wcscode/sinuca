require "entities.GameObject"

Ball = { radius = 12 }

function Ball:new(word, startX, startY, number)

    self.__index = self

    setmetatable(Ball, GameObject)
    local _ = setmetatable({}, Ball)

    _.startX = startX or 0
    _.startY = startY or 0
    _.number = number or 0

    if _.number == 0 then self.radius = 14 end

    _.body = love.physics.newBody(world, _.startX, _.startY, "dynamic")
    _.shape = love.physics.newCircleShape(self.radius)
    _.fixture = love.physics.newFixture(_.body, _.shape)
    _.image = love.graphics.newImage("images/ball_" .. _.number .. ".png", {dpiscale = 6})

    return _
end

function Ball:update(dt)
    --self.body:applyForce(100, 100)
end

function Ball:draw()
   
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.image, self.body:getX(),  self.body:getY())   

    love.graphics.circle("fill", self.body:getX(),  self.body:getY(), self.shape:getRadius())
   -- love.graphics.setColor(0, 0, 0)  
    --love.graphics.print(self.number, self.body:getX() - 3, self.body:getY() - 7)
end 