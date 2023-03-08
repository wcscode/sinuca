function debugWorldPolygonsShapes(objs)
    
    for  _, obj in pairs(objs) do
        local triangles = love.math.triangulate({ obj.body:getWorldPoints(obj.shape:getPoints()) })

        for _, triangle in ipairs(triangles) do
            love.graphics.polygon("line", triangle)
        end
    end
end   

function debugCircleShapes(objs)
    
    for  _, obj in pairs(objs) do
        
            love.graphics.circle("line", obj.body:getX(), obj.body:getY(), obj.shape:getRadius())
        
    end
end 

function debugLineEdges(objs)
    
    for  _, obj in pairs(objs) do

        local x1, y1, x2, y2 = obj.body:getWorldPoints(obj.shape:getPoints())       
        love.graphics.line(x1, y1, x2, y2)        
    end
end  

function debugBall(ball)
    love.graphics.circle("fill", ball.body:getX(),  ball.body:getY(), ball.shape:getRadius())   
end
function debugMousePosition(x, y)
    
    print("x: "..  x .." y: "..  y)
end    
