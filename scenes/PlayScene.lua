require "scenes.Scene"
require "entities.PoolTable"
require "entities.Ball"
require "entities.UIStrengthBar"
require "entities.UIMoves"
require "entities.Cue"
require "utilities.builders"
require "utilities.general"
require "utilities.StateManager"
require "entities.UIGameOver"

PlayScene = {} 
PlayScene.__index = PlayScene
setmetatable(PlayScene, Scene)

local _poolTable = nil
local _uiStrengthBar = nil
local _uiMoves = nil
local _whiteBall = nil
local _balls = nil
local _uiListBalls = nil
local _cue = nil
local _matchState = nil
local _allBallsIsSleeping = nil
local _uiGameOver = nil
local ATTEMPTS = 10

function PlayScene.new()    
    local instance = setmetatable({}, PlayScene)
   
    _poolTable = PoolTable.new(_G._world)   
   
    _uiStrengthBar = UIStrengthBar.new(585, 10, false) 
    _whiteBall, _balls = buildInitialPositionOfBalls(_G._world, _poolTable, Ball)       
    _uiMoves = UIMoves.new(50, 10, ATTEMPTS)   
    _cue = Cue.new(_G._world, _whiteBall, _uiStrengthBar.hit)    
    _uiGameOver = UIGameOver.new()

    _matchState = StateManager.new()
    
    _matchState:add("analyzing")
    _matchState:add("strike")
    _matchState:add("rolling")
    _matchState:add("fault")
    _matchState:add("gameOver")
    _matchState:add("won")

    _matchState:setActive("analyzing")    

    return instance
end

function PlayScene:update(dt)

    if _matchState:isActive("analyzing") then        
        _uiGameOver:update(dt)

        if _uiMoves:getRemainingMoves() < 1 then
            _matchState:setActive("gameOver")
            return nil
        end
        --print(#_balls)  
        if #_balls == 1 then
            _uiGameOver.message = "YOU WON!"     
            _matchState:setActive("won")
            return nil
        end

        _uiMoves:update(dt)
        return nil
    end

    if _matchState:isActive("strike") then
        _uiStrengthBar:update(dt)
        return nil
    end

    if _matchState:isActive("rolling") then
        _allBallsIsSleeping = true

        for _, ball in pairs(_balls) do
            ball:update(dt)
            
            if ball.body:isAwake() then                
                _allBallsIsSleeping = false
            end
        end

        if _allBallsIsSleeping then
            if not _poolTable:hasPoint() then 
                _uiMoves:substractMove()
            end
            _poolTable:resetPoint()
            _matchState:setActive("analyzing")
            _uiStrengthBar:reset()
        end

        return nil
    end
end

function PlayScene:draw() 
    _uiMoves:draw() 
    _uiStrengthBar:draw()
    _poolTable:draw()  
    _cue:draw()

    for _, ball in pairs(_balls) do       
        ball:draw()
    end    

    if _matchState:isActive("gameOver") or _matchState:isActive("won") then
       _uiGameOver:draw()
    end

    if enableDebug then        
        debugBalls(_balls)
    end
end

function PlayScene:mousepressed(x, y, button, istouch)  
    if button == 2 then         
        enableDebug = not enableDebug
        return nil
    end
    
    if _matchState:isActive("analyzing") then
        _matchState:setActive("strike")  
        return nil     
     end

    if _matchState:isActive("strike") then       
        _cue:mousepressed(x, y, button, istouch)
        _matchState:setActive("rolling") 
        return nil      
    end 

    if _matchState:isActive("fault") then       
        _matchState:setActive("analyzing")
        return nil
    end

    if _matchState:isActive("gameOver")  or _matchState:isActive("won")  then       
        _G._stateScene:setActive("start")        
    end
end

function PlayScene:mousemoved(x, y, dx, dy, istouch)  
    if _matchState:isActive("analyzing") then
        _cue:mousemoved(x, y, dx, dy, istouch)
    end  
    
    if _matchState:isActive("fault") then
        _whiteBall.body:setPosition(x, y)
    end
end

function PlayScene:beginContact(a, b, coll)    
    if _matchState:isActive("rolling") then
        if a:getUserData() == "pocket" then 
            local numberOfBall = b:getUserData()        

            if(numberOfBall >= 1) then
                for index, ball in pairs(_balls) do
                    if ball.number == numberOfBall then
                        table.remove(_balls, index) 
                        _poolTable:beginContact(a, b, coll)   
                    end
                end

                b:destroy() 
            else            
                _matchState:setActive("fault")  
                _whiteBall.body:setAwake(false)
                _uiMoves:substractMove()                            
            end
        end
    end

    if _matchState:isActive("fault") then
        if type(a:getUserData()) == "number" then
            _uiMoves:substractMove()     
        end
    end        
end

function PlayScene:unload()
    _poolTable = nil
    _uiStrengthBar = nil
    _uiMoves = nil    
    
    for index, ball in pairs(_balls) do              
        -- table.remove(_balls, index)        
        ball.body:destroy()
        ball.shape:release()
        ball = nil        
    end
    _balls = nil
    _whiteBall = nil

    --_uiListBalls = nil
    --_cue.body:destroy()
    _cue = nil
    _matchState = nil
    _allBallsIsSleeping = nil
    _uiGameOver = nil 
    self = nil
end    