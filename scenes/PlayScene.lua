require "scenes.Scene"
require "entities.PoolTable"
require "entities.Ball"
require "entities.UIStrengthBar"
require "entities.UIMoves"
require "entities.Cue"
require "utilities.builders"
require "utilities.general"
require "utilities.StateManager"

PlayScene = {} 
PlayScene.__index = PlayScene
setmetatable(PlayScene, Scene)

local _poolTable
local _uiStrengthBar
local _uiMoves
local _whiteBall
local _balls
local _uiListBalls
local _cue
local _matchState
local _allBallsIsSleeping

function PlayScene.new(world)    
    local instance = setmetatable({}, PlayScene)
   
    _poolTable = PoolTable.new(world)
   
    _uiStrengthBar = UIStrengthBar.new(585, 10, false) 
    _whiteBall, _balls = buildInitialPositionOfBalls(world, _poolTable, Ball)       
    _uiMoves = UIMoves.new(50, 10, 10)   
    _cue = Cue.new(world, _whiteBall, _uiStrengthBar.hit)    

    _matchState = StateManager.new()
    
    _matchState:add("analyzing")
    _matchState:add("strike")
    _matchState:add("rolling")

    _matchState:setActive("analyzing")    

    return instance
end

function PlayScene:update(dt)
    if _matchState:isActive("analyzing") then
        _uiMoves:update(dt)
    end

    if _matchState:isActive("strike") then
        _uiStrengthBar:update(dt)
    end

    _allBallsIsSleeping = true

    for _, ball in pairs(_balls) do
        ball:update(dt)

        if _matchState:isActive("rolling") then
            if ball.body:isAwake() then                
                _allBallsIsSleeping = false
            end             
        end
    end

    if  _matchState:isActive("rolling") and _allBallsIsSleeping then
        _matchState:setActive("analyzing")
        
        if not _poolTable:hasPoint() then
            _poolTable:resetPoint()
            _uiMoves:substractMove()
        end
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
    
    if enableDebug then        
        debugBalls(_balls)
    end
end

function PlayScene:mousepressed(x, y, button, istouch)    
    if _matchState:isActive("strike") then
        _matchState:setActive("rolling")
        _cue:mousepressed(x, y, button, istouch)
    end 

    if _matchState:isActive("analyzing") then
       _matchState:setActive("strike")
    end

    if button == 2 then         
        enableDebug = not enableDebug
    end
end

function PlayScene:mousemoved(x, y, dx, dy, istouch)  
    if _matchState:isActive("analyzing") then
        _cue:mousemoved(x, y, dx, dy, istouch)
    end     
end

function PlayScene:beginContact(a, b, coll)    
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
        end
    end
end   
