LevelObject = require("objects/level_object")

Fire = LevelObject:extend()

_FIRE_SPRITE = love.graphics.newImage("assets/images/fire.png")

function Fire:new(x, y)
    Fire.super.new(self, _FIRE_SPRITE, x, y)
end

function Fire:update(dt)
    -- todo update
end

-- function Fire:draw()
--     -- todo draw
-- end