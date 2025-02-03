LevelEntity = require("objects/level_entity")

Wall = LevelEntity:extend()

_WALL_SPRITE = love.graphics.newImage("assets/images/wall.png")

function Wall:new()
    Wall.super.new(self, _WALL_SPRITE)
end

function Wall:update(dt)
    -- todo update
end

-- function Wall:draw()
--     -- todo draw
-- end