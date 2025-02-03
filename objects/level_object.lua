LevelEntity = require("objects/level_entity")

LevelObject = LevelEntity:extend()

function LevelObject:new(sprite, x, y)
    LevelObject.super.new(self, sprite)
    self.sprite = sprite
    self.x = x or 0
    self.y = y or 0
end

function LevelObject:update(dt)
    -- todo update
end

-- function LevelObject:draw(x, y)
--     love.graphics.draw(self.sprite, x, y)
-- end

-- -- Useful for debugging issues
-- function LevelObject:drawDebug(x, y)
--     local font = love.graphics.getFont()

--     x_pos = x / 16
--     y_pos = y / 16
--     local text = love.graphics.newText(font, {{0,0,0},string.format("[%s,%s]", x_pos, y_pos)})
--     love.graphics.draw(text, x, y)
-- end

return LevelObject