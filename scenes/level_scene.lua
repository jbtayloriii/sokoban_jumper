Input = require("libraries/boipushy/Input")

LevelScene = Object:extend()

local _CAMERA_SIZE = 7

function LevelScene:new(level)

  self.level = level

  self:bindInput()

  self:resetLevel()
end

function LevelScene:resetLevel()
  print("Loading level "..self.level)
  self.levelData = LevelData(self.level)
  self.camera = Camera{width=_CAMERA_SIZE, height=_CAMERA_SIZE, levelData=self.levelData}
end

function LevelScene:bindInput()
  self.input = Input()

  -- Player movement
  self.input:bind("up", "up")
  self.input:bind("down", "down")
  self.input:bind("left", "left")
  self.input:bind("right", "right")

  -- Player special move
  self.input:bind("a", "zip")

  -- Undo, reset
  self.input:bind("z", "undo")
  self.input:bind("r", "reset")

  -- Debug functions
  self.input:bind("a", "loadPrev")
  self.input:bind("d", "loadNext")
  self.input:bind("q", "quit")
end


function LevelScene:update(dt)
  if self.input:pressed("quit") then
    love.event.quit()
  end

  if self.input:pressed("reset") then
    self:resetLevel()
    return
  end

  if self.input:pressed("loadPrev") then
  end

  -- todo: remove this
  if self.input:pressed("zip") then
    self.levelData:StartZip()
  else
    local playerInput = nil
    if self.input:pressed("up") then
      playerInput = {x=0, y=-1}
    elseif self.input:pressed("down") then
      playerInput = {x=0, y=1}
    elseif self.input:pressed("left") then
      playerInput = {x=-1, y=-0}
    elseif self.input:pressed("right") then
      playerInput = {x=1, y=0}
    end
    if playerInput then
      self.levelData:handlePlayerMove(playerInput)
    end
  end
  self.levelData:update(dt)

  local loadNext = self.levelData:handleState()
  if loadNext then
    self.level = self.level + 1
    self:resetLevel()
  end

  -- Camera should be the last thing to update, to prevent tear
  self.camera:updateView(self.levelData)
end

function LevelScene:draw()
  -- Draw level onto canvas
  local canvas = love.graphics.newCanvas()
  love.graphics.clear()
  love.graphics.setCanvas(canvas)
  self.camera:drawTilesToCanvas(canvas, self.levelData)
  self.camera:drawObjectsToCanvas(canvas, self.levelData)
  love.graphics.setCanvas()

  -- Draw level canvas to the screen
  love.graphics.draw(canvas, 16, 16, 0, 2)

  -- Draw level title
  love.graphics.print(self.levelData.metadata.title)
end

return LevelScene