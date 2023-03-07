require "entities.GameObject"

PoolTable = { borders = {} }

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
    
    _.startX = 200
    _.startY = 400 
    _.radius = 12    
    _.body = love.physics.newBody(world, _.startX, _.startY, "dynamic")
    _.shape = love.physics.newCircleShape(_.radius)
    _.fixture = love.physics.newFixture(_.body, _.shape)
    _.image = love.graphics.newImage("images/table.png", {dpiscale = 6.66})
    
    return _
end 

function PoolTable:update(dt)
    
end

function PoolTable:draw()    

    love.graphics.draw(self.image, 50, 100)

    for  _, border in pairs(self.borders) do
    
        local triangles = love.math.triangulate({ border.body:getWorldPoints(border.shape:getPoints()) })

        for _, triangle in ipairs(triangles) do
            love.graphics.polygon("line", triangle)
        end

    end 
end 

function buildPoolBordersShape(x, y, width, height, orientation, invertX, invertY)  
    local multiplyBy = 1
    local chamferA, chamferB = 0.04, 0.98  
    local coords

    if orientation == "horizontal" then
        if invertY then 
            multiplyBy = -1     
        end

        if invertX then 
            chamferA, chamferB = 0.96, 0.02              
        end

        coords = { 0, 0,  chamferA, multiplyBy * 1, chamferB, multiplyBy * 1,  1, 0 }
    else        
        if invertX then 
            multiplyBy = -1     
        end

        chamferA, chamferB = 0.04, 0.96        
            
        coords = { 0, 0,  0, 1,  multiplyBy * 1, chamferA,  multiplyBy * 1, chamferB }        
    end

    for i, coord in ipairs(coords) do

        if i % 2 == 0 then
            coords[i] = (coord * height)
        else
            coords[i] = (coord * width) 
        end

    end
   
    border = {}
    
   -- border.offsetX = 300
  --  border.offsetY = 5
    border.x = x
    border.y = y
    border.width = width
    border.height = height
    border.body = love.physics.newBody(world, border.x, border.y, "static")
    border.shape = love.physics.newPolygonShape(coords)
    border.fixture = love.physics.newFixture(border.body, border.shape)

    return border   

end