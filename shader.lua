function love.load()
    shader = love.graphics.newShader("shader.fs")
end

function love.draw()
    love.graphics.setShader(shader)
    love.graphics.rectangle("fill", 100, 100, 100, 100)
    love.graphics.setShader()
end