function buildPoolBordersShape(x, y, width, height)

    coords = {0, 0,  1, 1.5,  1, 2,  4, 2,  4.5, 1.5,  5.5, 0}

    x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6 = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    
    for i, coord in ipairs(coords) do

        if i % 2 == 0 then
            coords[i] = (coord * height) + y
        else
            coords[i] = (coord * width) + x
        end

    end
   
    return love.physics.newPolygonShape(coords)   

end

function love.load()
    
    love.graphics.setBackgroundColor(.2, .2, .2)
    world = love.physics.newWorld(0, 0, true)

    borders = {}
   border = {}
    
    border.offsetX = 300
    border.offsetY = 5
    border.x = 110
    border.y = 134
    border.width = 250
    border.height = 10
    border.body = love.physics.newBody(world, border.x, border.y, "static")
    border.shape = buildPoolBordersShape(100, 100, 100, 10) 
    border.fixture = love.physics.newFixture(border.body, border.shape)

  table.insert(borders, border)  

   --[[   border = {}

    border.offsetX = 300
    border.offsetY = 5
    border.x = 20
    border.y = 442
    border.width = 600
    border.height = 10
    border.body = love.physics.newBody(world, border.x, border.y, "static")
    border.shape = love.physics.newRectangleShape(border.offsetX, border.offsetY, border.width, border.height)    
    border.fixture = love.physics.newFixture(border.body, border.shape)

    table.insert(borders, border)*/
    --]]
    pool = {} 
    pool.image = love.graphics.newImage( "table.png" )     
   
end

function love.update(dt)
    world:update(dt)
   
end

function love.draw()
    --love.graphics.setColor(.4, .4, .4)
   -- love.graphics.rectangle("fill", bodyPlatform:getX(), bodyPlatform:getY(), 600, 10)
   -- love.graphics.circle("fill", bodyBall:getX(), bodyBall:getY(), 10)
  -- love.graphics.draw(table.image, 50, 100, 0 , 0.15, 0.15)

  --local vertices  = {100,100, 200,100, 200,200, 300,200, 300,300, 100,300} -- Concave "L" shape.
--local triangles = love.math.triangulate(vertices)

--for i, triangle in ipairs(triangles) do
--	love.graphics.polygon("fill", triangle)
--end

   love.graphics.setColor(1, 1, 1)

    for  _, border in pairs(borders) do
      
        local triangles = love.math.triangulate({ border.shape:getPoints() })

        for _, triangle in ipairs(triangles) do
            love.graphics.polygon("fill", triangle)
        end

    end 

end