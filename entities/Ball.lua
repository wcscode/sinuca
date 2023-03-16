require "entities.GameObject"

Ball = {}
Ball.__index = Ball
setmetatable(Ball, GameObject)

local _startX
local _startY
local _number
local _radius = 12
local _body
local _shape
local _fixture
local _image
local _centerOrigin

function Ball:getBody() return _body end
function Ball:getImage() return _image end
function Ball:getNumber() return _number end
function Ball:getFixture() return _fixture end

function Ball.new(world, startX, startY, number) 
    local instance = setmetatable({}, Ball)

    _startX = startX or 0
    _startY = startY or 0
    _number = number or 0

    if _number == 0 then _radius = 14 else _radius = 12 end

    _body = love.physics.newBody(world, _startX, _startY, "dynamic")
    _shape = love.physics.newCircleShape(_radius)
    _fixture = love.physics.newFixture(_body, _shape)
    _fixture:setUserData(_number)
    _fixture:setFriction(1)
    _fixture:setDensity(1)
    _fixture:setRestitution(0.5)
    _image = love.graphics.newImage("assets/images/ball_" .. _number .. ".png", {dpiscale = 6 })   
    _centerOrigin = _image:getWidth() / 2
    
    return instance
end

function Ball:update(dt)
   
end

function Ball:draw()   
    love.graphics.draw(
        _image, 
        _body:getX(), 
        _body:getY(), 
        0, 
        1, 
        1, 
        _centerOrigin, 
        _centerOrigin
    ) 
end 