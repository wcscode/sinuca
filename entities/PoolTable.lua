require "entities.GameObject"
require "utilities.debug"
require "utilities.builders"

PoolTable = { borders = {}, pockets = {} }

setmetatable(PoolTable, GameObject)

function PoolTable:new()

    self.__index = self

    local _ = setmetatable({}, PoolTable)

    table.insert(self.borders, buildPoolBordersShape(100, 132, 270, 11, "horizontal", false, false))  
    table.insert(self.borders, buildPoolBordersShape(404, 132, 272, 11, "horizontal", true, false))  
    table.insert(self.borders, buildPoolBordersShape(100, 454, 270, 11, "horizontal", false, true))  
    table.insert(self.borders, buildPoolBordersShape(404, 454, 272, 11, "horizontal", true, true))  
    table.insert(self.borders, buildPoolBordersShape(82, 156, 11, 275, "vertical", false, false))  
    table.insert(self.borders, buildPoolBordersShape(701, 156, 11, 275, "vertical", true, false))    

    table.insert(self.pockets, buildPoolPocketShape(82, 136, 17))
    table.insert(self.pockets, buildPoolPocketShape(387, 127, 17))
    table.insert(self.pockets, buildPoolPocketShape(696, 136, 17))

    table.insert(self.pockets, buildPoolPocketShape(696, 450, 17))
    table.insert(self.pockets, buildPoolPocketShape(387, 458, 17))
    table.insert(self.pockets, buildPoolPocketShape(83, 451, 17))
    self.image = love.graphics.newImage("images/table.png", {dpiscale = 6.66})

    return _
end 

function PoolTable:update(dt)
    
end

function PoolTable:draw()    

    love.graphics.draw(self.image, 50, 100)

    --debugLineEdges(self.shs)
    
    debugCircleShapes(self.pockets)
    debugWorldPolygonsShapes(self.borders)
   
end 

