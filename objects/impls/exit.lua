LevelObject = require("objects/level_object")

Exit = LevelObject:extend()

_EXIT_SPRITE = love.graphics.newImage("assets/images/exit.png")

function Exit:new(x, y)
    Exit.super.new(self, _EXIT_SPRITE, "exit", x, y)
end

return Exit