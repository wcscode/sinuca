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

function love.load()
    
    love.graphics.setBackgroundColor(.2, .2, .2)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact) --, endContact, preSolve, postSolve*/)

    borders = {} 

    table.insert(borders, buildPoolBordersShape(100, 132, 270, 11, "horizontal", false, false))  
    table.insert(borders, buildPoolBordersShape(404, 132, 272, 11, "horizontal", true, false))  
    table.insert(borders, buildPoolBordersShape(100, 454, 270, 11, "horizontal", false, true))  
    table.insert(borders, buildPoolBordersShape(404, 454, 272, 11, "horizontal", true, true))  

    table.insert(borders, buildPoolBordersShape(82, 156, 11, 275, "vertical", false, false))  
    table.insert(borders, buildPoolBordersShape(701, 156, 11, 275, "vertical", true, false))  

    pool = {} 
    pool.image = love.graphics.newImage( "table.png" )     
   
    ball = {}
    
   -- ball.offsetX = 300
   -- ball.offsetY = 5
    ball.x = 200
    ball.y = 400 
    ball.radius = 12    
    ball.body = love.physics.newBody(world, ball.x, ball.y, "dynamic")
    ball.shape = love.physics.newCircleShape(ball.radius)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape)
    
    ball.fixture:setRestitution(0.5)
end

function love.update(dt)
    world:update(dt)
   
end

function love.draw()

   love.graphics.draw(pool.image, 50, 100, 0 , 0.15, 0.15)
   love.graphics.setColor(1, 1, 1)

    for  _, border in pairs(borders) do
      
        local triangles = love.math.triangulate({ border.body:getWorldPoints(border.shape:getPoints()) })

        for _, triangle in ipairs(triangles) do
            love.graphics.polygon("line", triangle)
        end

    end 

    --love.graphics.circle("fill", ball.body:getX()  , ball.body:getY(), ball.radius)


    for _, body in pairs(world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
    
            if shape:typeOf("CircleShape") then
                local cx, cy = body:getWorldPoints(shape:getPoint())
                love.graphics.circle("fill", cx, cy, shape:getRadius())
            elseif shape:typeOf("PolygonShape") then
                love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
            else
                love.graphics.line(body:getWorldPoints(shape:getPoints()))
            end
        end
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
        ball.body:applyForce((x - ball.body:getX()) * 10, (y - ball.body:getY()) * 10)
       -- print(((x - ball.body:getX()) * 10).." "..((y - ball.body:getY()) * 10))
    end
 end


function beginContact(a, b, coll)
    x,y = coll:getNormal()
   print(x.." "..y)
end