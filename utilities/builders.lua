function buildInitialPositionOfBalls(world, poolTable, ball)

    local balls = {}

    table.insert(balls, ball:new(word, 555, 290))

    local ballPerColumn = 5
    local ballInitialPosition = { x = 200, y = (poolTable.image:getHeight() / 2) + 20  }
    local gapBetweenBall = 25
    local offsetYPosition = 12
    local number = 1

    for x = 1, 5 do        
        for y = 1, ballPerColumn  do   

            table.insert(balls, ball:new(word, ballInitialPosition.x + (x * gapBetweenBall), ballInitialPosition.y + (y * gapBetweenBall) + (offsetYPosition * x -1), number))            
            number = number + 1
        end

        ballPerColumn = ballPerColumn - 1
    end

    return balls[1], balls   
end 

function buildPoolBordersShape(world, x, y, width, height, orientation, invertX, invertY)  

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
   
    local border = {}

    border.x = x
    border.y = y
    border.width = width
    border.height = height
    border.body = love.physics.newBody(world, border.x, border.y, "static")
    border.shape = love.physics.newPolygonShape(coords)
    border.fixture = love.physics.newFixture(border.body, border.shape)

    return border   

end

function buildPoolPocketShape(x, y, radius)

    local pocket = {}

    pocket.body = love.physics.newBody(world, x, y, "static")
    pocket.shape = love.physics.newCircleShape(radius)
    pocket.fixture = love.physics.newFixture(pocket.body, pocket.shape)
    pocket.fixture:setUserData("pocket")

    return pocket
end    