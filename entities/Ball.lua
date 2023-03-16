require "entities.GameObject"

Ball = {}
Ball.__index = Ball
setmetatable(Ball, GameObject)

local _centerOrigin

function Ball.new(world, startX, startY, number) 
    local instance = setmetatable({}, Ball)
    
    instance.number = number or 0
    local radius = 12

    if instance.number == 0 then radius = 14 end

    instance.body = love.physics.newBody(world, startX, startY, "dynamic")
    instance.shape = love.physics.newCircleShape(radius)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    instance.fixture:setUserData(instance.number)
    instance.fixture:setFriction(1)
    instance.fixture:setDensity(1)
    instance.fixture:setRestitution(0.5)
    instance.image = love.graphics.newImage("assets/images/ball_" .. instance.number .. ".png", {dpiscale = 6 })   
    _centerOrigin = instance.image:getWidth() / 2
    
    return instance
end

function Ball:update(dt)
   return nil
end

function Ball:draw()   
    love.graphics.draw(
        self.image, 
        self.body:getX(), 
        self.body:getY(), 
        0, 
        1, 
        1, 
        _centerOrigin, 
        _centerOrigin
    ) 
end 