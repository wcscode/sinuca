Scene = {}
Scene.__index = Scene

function Scene:update(dt)
    error("method 'update' needs to be overriden")
end

function Scene:draw()
    error("method 'draw' needs to be overriden")
end

function Scene:mousepressed(x, y, button, istouch)
  
end

function Scene:mousemoved(x, y, dx, dy, istouch)
   
end

function Scene:beginContact(a, b, coll)
  
end 

function Scene:restart()
end