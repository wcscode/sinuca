function normalize(value, min, max)
    return (value - min) / (max - min) + max
end

function screenCenterXY()
    return love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
end    

