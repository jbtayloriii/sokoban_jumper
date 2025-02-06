LevelEntity = require("objects/level_entity")
Uuid = require("libraries/utils")

LevelObject = LevelEntity:extend()

function LevelObject:new(sprite, name, x, y)
    LevelObject.super.new(self, sprite, name)
    self.sprite = sprite
    self.x = x or 0
    self.y = y or 0
    self.uuid = Uuid:uuid()
end

function LevelObject:isPushable()
    return false
end

function LevelObject:canMoveThrough()
    return true
end

function LevelObject:canMovePush()
    return false
end

function LevelObject:moveTo(x, y)
    self.x = x
    self.y = y
end

return LevelObject