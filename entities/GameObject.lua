GameObject = {}
GameObject.__index = GameObject

function Scene:update(dt)
    error("method 'update' needs to be overriden")
end

function Scene:draw()
    error("method 'draw' needs to be overriden")
end