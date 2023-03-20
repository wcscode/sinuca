require "entities.GameObject"
require "utilities.debug"
require "utilities.builders"

PoolTable = {}
PoolTable.__index = PoolTable
setmetatable(PoolTable, GameObject)

local _hasPoint = false

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

    table.insert(borders, buildPoolPocketShape(world, 82, 136, 8)) --17
    table.insert(borders, buildPoolPocketShape(world, 387, 127, 8))
    table.insert(borders, buildPoolPocketShape(world, 696, 136, 8))
    table.insert(borders, buildPoolPocketShape(world, 696, 450, 8))
    table.insert(borders, buildPoolPocketShape(world, 387, 458, 8))
    table.insert(borders, buildPoolPocketShape(world, 83, 451, 8))

    instance.image = love.graphics.newImage("assets/images/table.png", {dpiscale = 6.66})

    return instance
end 
    
function PoolTable:update(dt)
    return nil
end

function PoolTable:draw() 
    love.graphics.draw(self.image, 50, 100)   
end

function PoolTable:beginContact(a, b, coll)    
    _hasPoint = true 
end

function PoolTable:hasPoint() 
    return _hasPoint 
end

function PoolTable:resetPoint()
    _hasPoint = false
end
