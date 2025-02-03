LevelScene = Object:extend()

local _CAMERA_SIZE = 7
local _CAMERA_CENTER = {x = 1 + _CAMERA_SIZE, y = 1 + _CAMERA_SIZE}

function LevelScene:new(levelName)
  io.input(levelName)
  local text = io.read("*all")
  self.levelData = LevelData(text)
  
  -- self:LoadLevel(levelName)

  self.camera = Camera{width=_CAMERA_SIZE, height=_CAMERA_SIZE, center=_CAMERA_CENTER}

  self.main_canvas = love.graphics.newCanvas(gw, gh)
end


function LevelScene:update(dt)
    -- todo
end

function LevelScene:draw()
  local canvas = love.graphics.newCanvas()
  love.graphics.setCanvas(canvas)

  self.camera:drawTilesToCanvas(canvas, self.levelData)
  self.camera:drawObjectsToCanvas(canvas, self.levelData)
  love.graphics.setCanvas()

  love.graphics.draw(canvas,0,0,0,2)
end

return LevelScene