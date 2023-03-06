require "entities.GameObject"

Ball = {}

function Ball:new(word, startX, startY, number)
    self.__index = self
    setmetatable(Ball, GameObject)
    local _ = setmetatable({}, Ball)
    _.startX = startX or 0
    _.startY = startY or 0
    _.number = number or 0
    _.body = love.physics.newBody(world, _.startX, _.startY, "dynamic")

    if _.number ~= 0 then 
        _.shape = love.physics.newCircleShape(12)
    else
        _.shape = love.physics.newCircleShape(14)
    end

    _.fixture = love.physics.newFixture(_.body, _.shape)
    return _
end

function Ball:update(dt)
    --self.body:applyForce(100, 100)
end

function Ball:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", self.body:getX(),  self.body:getY(), self.shape:getRadius())
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.number, self.body:getX() - 3, self.body:getY() - 7)
end 