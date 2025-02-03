LevelObject = require("objects/level_object")

Character = LevelObject:extend()

_CHARACTER_SPRITE = love.graphics.newImage("assets/images/character.png")

function Character:new(x, y)
    Character.super.new(self, _CHARACTER_SPRITE, x, y)
end

-- function Character:update(dt)
--     -- todo update
-- end

-- function Character:draw(canvas, camera)
--     love.graphics.draw(_CHARACTER_SPRITE, 20, 20, 0, 5)
--     -- todo draw
-- end

return Character