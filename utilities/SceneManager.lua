SceneManager = {}
SceneManager.__index = SceneManager
setmetatable(SceneManager, StateManager)

function SceneManager.new()
    local instance = setmetatable({}, SceneManager)

    instance.states = {}
    instance.currentState = nil
    
    return instance
end

function SceneManager:setActive(name)
    self:setActive(name)
end