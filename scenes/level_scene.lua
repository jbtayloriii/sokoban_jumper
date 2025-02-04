Input = require("libraries/boipushy/Input")

LevelScene = Object:extend()

local _CAMERA_SIZE = 7

function LevelScene:new(level)

  self.level = level

  self.levelData = LevelData(level)
  self:bindInput()

  self.camera = Camera{width=_CAMERA_SIZE, height=_CAMERA_SIZE, levelData=self.levelData}
  self.main_canvas = love.graphics.newCanvas(gw, gh)
end

function LevelScene:bindInput()
  self.input = Input()

  -- Player movement
  self.input:bind("up", "up")
  self.input:bind("down", "down")
  self.input:bind("left", "left")
  self.input:bind("right", "right")

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

  if self.input:pressed("loadPrev") then
  end

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
    self.levelData:handlePlayerInput(playerInput)
    self.camera:updateView(self.levelData)
  end
end

function LevelScene:draw()
  local canvas = love.graphics.newCanvas()
  love.graphics.clear()
  love.graphics.setCanvas(canvas)

  self.camera:drawTilesToCanvas(canvas, self.levelData)
  self.camera:drawObjectsToCanvas(canvas, self.levelData)
  love.graphics.setCanvas()

  love.graphics.draw(canvas,0,0,0,2)
end

return LevelScene