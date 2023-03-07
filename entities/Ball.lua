require "entities.GameObject"

Ball = { startX, startY, number, radius  }

setmetatable(Ball, GameObject)

function Ball:new(word, startX, startY, number)
   
    self.__index = self
    
    local _ = setmetatable({}, Ball)

    _.startX = startX or 0
    _.startY = startY or 0
    _.number = number or 0

    if _.number == 0 then self.radius = 14 else self.radius = 12 end

    _.body = love.physics.newBody(world, _.startX, _.startY, "dynamic")
    _.shape = love.physics.newCircleShape(self.radius)
    _.fixture = love.physics.newFixture(_.body, _.shape)
    _.image = love.graphics.newImage("images/ball_" .. _.number .. ".png", {dpiscale = 6 })   
    _.centerOrigin = _.image:getWidth() / 2
    return _
end

function Ball:update(dt)
   
end

function Ball:draw()

    love.graphics.draw(self.image, self.body:getX(),  self.body:getY(), 0, 1, 1, self.centerOrigin, self.centerOrigin)
    --love.graphics.circle("fill", self.body:getX(),  self.body:getY(), self.shape:getRadius())   
end 