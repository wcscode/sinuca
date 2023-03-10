require "entities.GameObject"

Ball = { startX, startY, number, radius  }

setmetatable(Ball, GameObject)

function Ball:new(world, startX, startY, number)   
    self.__index = self
    
    local _ = setmetatable({}, Ball)

    _.startX = startX or 0
    _.startY = startY or 0
    _.number = number or 0

    if _.number == 0 then self.radius = 14 else self.radius = 12 end

    _.body = love.physics.newBody(world, _.startX, _.startY, "dynamic")
    _.shape = love.physics.newCircleShape(self.radius)
    _.fixture = love.physics.newFixture(_.body, _.shape)
    _.fixture:setUserData(_.number)
    _.fixture:setFriction(1)
    _.fixture:setDensity(1)
    _.fixture:setRestitution(0.5)
    _.image = love.graphics.newImage("assets/images/ball_" .. _.number .. ".png", {dpiscale = 6 })   
    _.centerOrigin = _.image:getWidth() / 2
    
    return _
end

function Ball:update(dt)
   
end

function Ball:draw()
   -- print("O número da bola é" .. self.number)
   -- if self.body then
        love.graphics.draw(self.image, self.body:getX(),  self.body:getY(), 0, 1, 1, self.centerOrigin, self.centerOrigin)  
   -- end
end 

