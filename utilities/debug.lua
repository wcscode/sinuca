
function debugMousePosition(x, y)    
    love.graphics.print("x: "..  love.mouse.getX() .." y: "..  love.mouse.getY(), 10, 10) 
end   

function debugBalls(balls) 
    local nTables = ""
    local nDatas = ""
    for i, ball in pairs(balls) do
       
        nTables = nTables .."i "..i.." number "..ball.number.. "\n "

       -- if not ball.fixture:isDestroyed() then
            nDatas = nDatas .. ball.fixture:getUserData() .. " "
       -- end
    end
     
   love.graphics.print("tables\n"..nTables.. " datas\n".. nDatas, 10, 25) 
end

function debugShapes(world)
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
