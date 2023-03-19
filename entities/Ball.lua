require "entities.GameObject"

Ball = {}
Ball.__index = Ball
setmetatable(Ball, GameObject)

local _centerOrigin

function Ball.new(world, startX, startY, number) 
    local instance = setmetatable({}, Ball)
    
    instance.number = number or 0
    local radius = 12
    
    instance.body = love.physics.newBody(world, startX, startY, "dynamic")

    if instance.number == 0 then 
        radius = 14 
        instance.body:setBullet(true)
    end

    instance.shape = love.physics.newCircleShape(radius)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    instance.fixture:setUserData(instance.number)
    instance.fixture:setFriction(1)
    instance.body:setMass(1)
    instance.fixture:setRestitution(0.5)
    instance.image = love.graphics.newImage("assets/images/ball_" .. instance.number .. ".png", {dpiscale = 6 })   
    instance.body:setLinearDamping(0.3)
    _centerOrigin = instance.image:getWidth() / 2
       
    return instance
end

function Ball:update(dt)
    
    local threshold = 1.3
    local x, y = self.body:getLinearVelocity()
    if  x < threshold and y > -threshold and y < threshold and y > -threshold then
       -- print(self.body:getLinearVelocity())
      -- Put the ball to sleep if its velocity is below the threshold
      self.body:setAwake(false)
    end
    
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