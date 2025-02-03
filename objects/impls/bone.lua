LevelObject = require("objects/level_object")

Bone = LevelObject:extend()

_BONE_SPRITE = love.graphics.newImage("assets/images/bone.png")

function Bone:new(x, y)
    Bone.super.new(self, _BONE_SPRITE, x, y)
end

function Bone:update(dt)
    -- todo update
end

-- function Bone:draw()
--     -- todo draw
-- end