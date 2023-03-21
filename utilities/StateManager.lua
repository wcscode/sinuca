StateManager = {}
StateManager.__index = StateManager

function StateManager.new()
    local instance = setmetatable({}, StateManager)
    
    instance.states = {}
    instance.currentState = nil

    return instance
end

function StateManager:add(name, value)   
    table.insert(self.states, {name = name, value = value})
end

function StateManager:setActive(name, value)  
    assert(name,"'name' parameter must be filled")     
    value = value or nil

    if value == nil then    
        for _, state in pairs(self.states) do                       
            if state.name == name then 
            self.currentState = state
            end
        end
    else
        self.currentState = { name = name, value = value }
    end
end

function StateManager:getActive()    
    return self.currentState.name, self.currentState.value
end

function StateManager:isActive(name)    
    return self.currentState.name == name
end