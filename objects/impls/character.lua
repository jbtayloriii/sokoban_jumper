LevelObject = require("objects/level_object")

Character = LevelObject:extend()

_CHARACTER_SPRITE = love.graphics.newImage("assets/images/character.png")

_CHARACTER_POWERING_UP_SHEET = love.graphics.newImage

function Character:new(x, y)
    Character.super.new(self, _CHARACTER_SPRITE, "character", x, y)

    self.moves = {}
end

function Character:draw(x, y)

    -- Draw flames under self if we are about to zip
    if table.getn(self.moves) == 2 and self.moves[1] == self.moves[2] then
        love.graphics.setColor(.5, .5, 0)
        love.graphics.rectangle("fill", x + 1, y + 1, 14, 14)
        love.graphics.setColor(1, 1, 1)
    end

    Character.super.draw(self, x, y)
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