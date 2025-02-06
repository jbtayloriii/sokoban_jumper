LevelObject = require("objects/level_object")

Character = LevelObject:extend()

_CHARACTER_SPRITE = love.graphics.newImage("assets/images/character.png")

function Character:new(x, y)
    Character.super.new(self, _CHARACTER_SPRITE, "character", x, y)

    self.moves = {}
end


function Character:isZip(x, y)
    if table.getn(self.moves) < 2 then
        return false
    end

    local key = x..","..y
    for _, k in ipairs(self.moves) do
        if k ~= key then
            return false
        end
    end
    return true
end

function Character:moveTo(x, y)
    local diffX = x - self.x
    local diffY = y - self.y
    local key = diffX..","..diffY

    Character.super.moveTo(self, x, y)

    table.insert(self.moves, key)
    if table.getn(self.moves) > 2 then
        table.remove(self.moves, 1)
    end
end

return Character