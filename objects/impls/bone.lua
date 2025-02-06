LevelObject = require("objects/level_object")

Bone = LevelObject:extend()

_BONE_SPRITE = love.graphics.newImage("assets/images/bone.png")

function Bone:new(x, y)
    Bone.super.new(self, _BONE_SPRITE, "bone", x, y)
end

return Bone