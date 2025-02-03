TestScene = LevelScene:extend()

function TestScene:new()
  TestScene.super.new(self, "assets/levels/level_1.txt")

end

function TestScene:update(dt)
  TestScene.super.update(self, dt)

end

function TestScene:draw()
  TestScene.super.draw(self)
end

