UIStrengthBar = {}
UIStrengthBar.__index = UIStrengthBar
setmetatable(UIStrengthBar, GameObject)

local _width = 150
local _height = 20   
local _coinWidth = 20 
local _coinMaxXPosition = _width / 2 - _coinWidth / 2

function UIStrengthBar.new(x, y)    
    local instance = setmetatable({}, UIStrengthBar)

    instance.x = x
    instance.y = y 
    instance.hit = { strength = 0 }    
    instance.acc = 0

    return instance
end   

function UIStrengthBar:update(dt)
    self.acc = self.acc + dt + 0.02
   
    self.hit.strength = normalize(math.cos(self.acc), 0, 1)
  
    if self.hit.strength >= _width then
        self.hit.strength = 1
        self.acc = 0
    end
end

function UIStrengthBar:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x + self.hit.strength * _coinMaxXPosition, self.y, _coinWidth , _height)

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", self.x, self.y, _width, _height)
    
    love.graphics.reset()
end   

function UIStrengthBar:reset()
    self.acc = 0
end

