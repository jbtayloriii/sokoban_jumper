LevelObject = require("objects/level_object")

WoodenCrate = LevelObject:extend()

_WOODEN_CRATE_SPRITE = love.graphics.newImage("assets/images/wooden_crate.png")

function WoodenCrate:new(x, y)
    WoodenCrate.super.new(self, _WOODEN_CRATE_SPRITE, x, y)
end

function WoodenCrate:update(dt)
    -- todo update
end

-- function WoodenCrate:draw()
--     -- todo draw
-- end