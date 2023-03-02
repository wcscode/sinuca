function buildPoolBordersShape(x, y, width, height, invertX, invertY)

    invertX = invertX or false
    invertY = invertY or false

    if invertY then 
        multiplyBy = -1 
    else 
        multiplyBy = 1 
    end

    if invertX then 
        chamferA, chamferB = 0.96, 0.02          
    else 
        chamferA, chamferB = 0.04, 0.98 
    end

    coords = { 0, 0,  chamferA, multiplyBy * 1, chamferB, multiplyBy * 1,  1, 0 }
    
    for i, coord in ipairs(coords) do

        if i % 2 == 0 then
            coords[i] = (coord * height) + y
        else
            coords[i] = (coord * width) + x
        end

    end
   
    border = {}
    
    border.offsetX = 300
    border.offsetY = 5
    border.x = 110
    border.y = 134
    border.width = 250
    border.height = 10
    border.body = love.physics.newBody(world, border.x, border.y, "static")
    border.shape = love.physics.newPolygonShape(coords)
    border.fixture = love.physics.newFixture(border.body, border.shape)

    return border   

end

function love.load()
    
    love.graphics.setBackgroundColor(.2, .2, .2)
    world = love.physics.newWorld(0, 0, true)

    borders = {}
 

    table.insert(borders, buildPoolBordersShape(100, 132, 270, 11))  
    table.insert(borders, buildPoolBordersShape(404, 132, 272, 11, true, false))  
    table.insert(borders, buildPoolBordersShape(100, 454, 270, 11, false, true))  
    table.insert(borders, buildPoolBordersShape(404, 454, 272, 11, true, true))  

    pool = {} 
    pool.image = love.graphics.newImage( "table.png" )     
   
end

function love.update(dt)
    world:update(dt)
   
end

function love.draw()

   love.graphics.draw(pool.image, 50, 100, 0 , 0.15, 0.15)
   love.graphics.setColor(1, 1, 1)

    for  _, border in pairs(borders) do
      
        local triangles = love.math.triangulate({ border.shape:getPoints() })

        for _, triangle in ipairs(triangles) do
            love.graphics.polygon("line", triangle)
        end

    end 

end