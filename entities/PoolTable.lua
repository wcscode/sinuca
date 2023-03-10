require "entities.GameObject"
require "utilities.debug"
require "utilities.builders"

PoolTable = { borders = {}, pockets = {} }

setmetatable(PoolTable, GameObject)

function PoolTable:new(world)
    self.__index = self
    local _ = setmetatable({}, PoolTable)

    

    table.insert(self.borders, buildPoolBordersShape(world, 100, 132, 270, 11, "horizontal", false, false))  
    table.insert(self.borders, buildPoolBordersShape(world, 404, 132, 272, 11, "horizontal", true, false))  
    table.insert(self.borders, buildPoolBordersShape(world, 100, 454, 270, 11, "horizontal", false, true))  
    table.insert(self.borders, buildPoolBordersShape(world, 404, 454, 272, 11, "horizontal", true, true))  
    table.insert(self.borders, buildPoolBordersShape(world, 82, 156, 11, 275, "vertical", false, false))  
    table.insert(self.borders, buildPoolBordersShape(world, 701, 156, 11, 275, "vertical", true, false))    

    table.insert(self.pockets, buildPoolPocketShape(world, 82, 136, 17))
    table.insert(self.pockets, buildPoolPocketShape(world, 387, 127, 17))
    table.insert(self.pockets, buildPoolPocketShape(world, 696, 136, 17))
    table.insert(self.pockets, buildPoolPocketShape(world, 696, 450, 17))
    table.insert(self.pockets, buildPoolPocketShape(world, 387, 458, 17))
    table.insert(self.pockets, buildPoolPocketShape(world, 83, 451, 17))

    self.image = love.graphics.newImage("assets/images/table.png", {dpiscale = 6.66})

    return _
end 

function PoolTable:update(dt)
    
end

function PoolTable:draw() 
    love.graphics.draw(self.image, 50, 100)   
end 

