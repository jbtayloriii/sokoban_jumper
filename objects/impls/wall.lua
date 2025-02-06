LevelEntity = require("objects/level_entity")

Wall = LevelEntity:extend()

_WALL_SPRITE = love.graphics.newImage("assets/images/wall.png")

function Wall:new()
    Wall.super.new(self, _WALL_SPRITE, "wall")
end

function Wall:canMoveHere()
    return false
end

return Wall