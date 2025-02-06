LevelEntity = require("objects/level_entity")

Pit = LevelEntity:extend()

_PIT_SPRITE = love.graphics.newImage("assets/images/pit.png")

function Pit:new()
    Pit.super.new(self, _PIT_SPRITE, "pit")
end

return Pit