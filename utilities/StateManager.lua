StateManager = {}

StateManager.__index = StateManager
local _states = {}
local _currentState

function StateManager.new()
    local instance = setmetatable({}, StateManager)
    
    return instance
end

function StateManager:add(name, value)
    --print("value")
    --print(value)
    value = value or nil
    table.insert(_states, {name = name, value = value})
end

function StateManager:setActive(name)  
    assert(name,"'name' parameter must be filled") 
   
    for _, state in pairs(_states) do               
        if state.name == name then 
            _currentState = state           
        end
    end
end

function StateManager:isActive(name)    
    return _currentState.name == name
end

function StateManager:getActiveValue()
    return _currentState.value
end

function StateManager:getActiveName()
    return _currentState.name
end