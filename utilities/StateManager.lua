StateManager = {}

StateManager.__index = StateManager
local _states = {}
local _currentState

function StateManager:new()
    local instance = setmetatable({}, StateManager)

    return instance
end

function StateManager:add(name)
    table.insert(_states, name)
end

function StateManager:setActiveState(name)   
    for _, state in pairs(_states) do        
        if state == name then
            print(state)
            _currentState = state           
        end
    end
end

function StateManager:getActiveState()
    return _currentState
end