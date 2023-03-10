Scene = { active = false }

Scene.__index = Scene

function Scene:mousepressed(x, y, button, istouch)
    return nil
end

function Scene:mousemoved(x, y, dx, dy, istouch)
    return nil
end

function Scene:beginContact(a, b, coll)
    return nil
end    
