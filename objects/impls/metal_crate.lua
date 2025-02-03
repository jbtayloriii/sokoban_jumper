LevelObject = require("objects/level_object")

MetalCrate = LevelObject:extend()

_METAL_CRATE_SPRITE = love.graphics.newImage("assets/images/metal_crate.png")

function MetalCrate:new(x, y)
    MetalCrate.super.new(self, _METAL_CRATE_SPRITE, x, y)
end

function MetalCrate:update(dt)
    -- todo update
end

-- function MetalCrate:draw()
--     -- todo draw
-- end