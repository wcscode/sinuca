Scene = {}
Scene.__index = Scene

function Scene:update(dt)
    error("method 'update' needs to be overriden")
end

function Scene:draw()
    error("method 'draw' needs to be overriden")
end

function Scene:mousepressed(x, y, button, istouch)
    return nil
end

function Scene:mousemoved(x, y, dx, dy, istouch)
    return nil
end

function Scene:beginContact(a, b, coll)
    return nil
end    
