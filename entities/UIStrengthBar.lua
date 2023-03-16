UIStrengthBar = {}
UIStrengthBar.__index = UIStrengthBar
setmetatable(UIStrengthBar, GameObject)

local _x
local _y
local _width = 150
local _height = 20   
local _coinWidth = 20 
local _coinMaxXPosition = _width / 2 - _coinWidth / 2
local _hit = {strength = 0}
local _active
local _acc = 0

function UIStrengthBar.new(x, y, active)    
    local instance = setmetatable({}, UIStrengthBar)
    _x = x
    _y = y   
    _active = active

    return instance
end   

function UIStrengthBar:update(dt)
    _acc = _acc + dt + 0.02
   
    _hit.strength = normalize(math.cos(_acc), 0, 1)
  
    if _hit.strength >= _width then
        _hit.strength = 1
        _acc = 0
    end
end

function UIStrengthBar:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", _x + _hit.strength * _coinMaxXPosition, _y, _coinWidth , _height)

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", _x, _y, _width, _height)
    love.graphics.reset()
end    

