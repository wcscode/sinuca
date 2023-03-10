UIStrengthBar = { x, y, width, height, strength }

function UIStrengthBar:new(x, y, active)    
    self.x = x
    self.y = y
    self.width = 150
    self.height = 20   
    self.coinWidth = 20 
    self.coinMaxXPosition = self.width / 2 - self.coinWidth / 2
    self.hit = {strength = 0}
    self.active = active
    self.acc = 0

    return setmetatable(self, {__index = UIStrengthBar})
end   

function UIStrengthBar:update(dt)
    self.acc = self.acc + dt + 0.02
   
    self.hit.strength = normalize(math.cos(self.acc), 0, 1)
  
    if self.hit.strength >= self.width then
        self.hit.strength = 1
        self.acc = 0
    end
end

function UIStrengthBar:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x + self.hit.strength * self.coinMaxXPosition, self.y, self.coinWidth , self.height)

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    love.graphics.reset()
end    

