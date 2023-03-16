require "entities.GameObject"
require "utilities.debug"
require "utilities.builders"

PoolTable = {}
PoolTable.__index = PoolTable
setmetatable(PoolTable, GameObject)

function PoolTable:getImage() return _image end

function PoolTable.new(world)   
    local instance = setmetatable({}, PoolTable)

    local borders = {}

    table.insert(borders, buildPoolBordersShape(world, 100, 132, 270, 11, "horizontal", false, false))  
    table.insert(borders, buildPoolBordersShape(world, 404, 132, 272, 11, "horizontal", true, false))  
    table.insert(borders, buildPoolBordersShape(world, 100, 454, 270, 11, "horizontal", false, true))  
    table.insert(borders, buildPoolBordersShape(world, 404, 454, 272, 11, "horizontal", true, true))  
    table.insert(borders, buildPoolBordersShape(world, 82, 156, 11, 275, "vertical", false, false))  
    table.insert(borders, buildPoolBordersShape(world, 701, 156, 11, 275, "vertical", true, false))    

    table.insert(borders, buildPoolPocketShape(world, 82, 136, 17))
    table.insert(borders, buildPoolPocketShape(world, 387, 127, 17))
    table.insert(borders, buildPoolPocketShape(world, 696, 136, 17))
    table.insert(borders, buildPoolPocketShape(world, 696, 450, 17))
    table.insert(borders, buildPoolPocketShape(world, 387, 458, 17))
    table.insert(borders, buildPoolPocketShape(world, 83, 451, 17))

    instance.image = love.graphics.newImage("assets/images/table.png", {dpiscale = 6.66})

    return instance
end 
    
function PoolTable:update(dt)
    return nil
end

function PoolTable:draw() 
    love.graphics.draw(self.image, 50, 100)   
end