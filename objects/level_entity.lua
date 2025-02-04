LevelEntity = Object:extend()

function LevelEntity:new(sprite)
    self.sprite = sprite
end

function LevelEntity:update(dt)
    -- todo update
end

function LevelEntity:draw(x, y)
    love.graphics.draw(self.sprite, x, y)
end

function LevelEntity:canMoveHere()
    return true
end

-- Useful for debugging issues
function LevelEntity:drawDebug(x, y)
    local font = love.graphics.getFont()

    x_pos = x / 16
    y_pos = y / 16
    local text = love.graphics.newText(font, {{0,0,0},string.format("[%s,%s]", x_pos, y_pos)})
    love.graphics.draw(text, x, y)
end

return LevelEntity