LevelEntity = require("objects/level_entity")

Floor = LevelEntity:extend()

_FLOOR_SPRITE = love.graphics.newImage("assets/images/floor.png")

function Floor:new()
    Floor.super.new(self, _FLOOR_SPRITE)
end
function Floor:update(dt)
    -- todo update
end

-- function Floor:draw()
--     -- todo draw
-- end