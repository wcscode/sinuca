UIMoves = {}
UIMoves.__index = UIMoves
setmetatable(UIMoves, GameObject)

local _x
local _y
local _width
local _height
local _move
local _font = love.graphics.newFont("assets/fonts/Kenney Future Narrow.ttf", 20)

function UIMoves.new(x, y, move)     
    local instance = setmetatable({}, UIMoves)

    _x = x
    _y = y
    _width = 300
    _height = 33
    _move = move
   
    return instance
end

function UIMoves:update(dt)
    return nil
end

function UIMoves:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", _x, _y, _width, _height)

    love.graphics.setFont(_font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(_move.." tentativas restantes", _x + 10, _y + 5)
end

function UIMoves:getRemainingMoves()
    return _move
end

function UIMoves:substractMove()
    _move = _move - 1
    return _move
end