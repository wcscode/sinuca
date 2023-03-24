SceneManager = {}
SceneManager.__index = SceneManager
setmetatable(SceneManager, StateManager)

function SceneManager.new()
    local instance = setmetatable({}, SceneManager)

    instance.states = {}
   -- instance.currentState = nil
    
    return instance
end

function SceneManager:setActive(name)
    for _, state in pairs(self.states) do                       
        if state.name == name then 
            if self.currentState then
                self.currentState.value:unload()
                --self.currentState.value = nil
            end

            self.currentState = { name = name, value = state.value.new() }
        end
    end    
    
   -- StateManager.setActive(self, name)   
end