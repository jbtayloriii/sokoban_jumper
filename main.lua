Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'

-- UUID = require 'libraries/utils'

function love.load()
  love.window.maximize()

  love.graphics.setDefaultFilter("nearest")
  love.graphics.setBackgroundColor(1,1,1,1)
  
  local object_files = {}
  recursiveEnumerateLoad('objects', object_files)
  recursiveEnumerateLoad('scenes', object_files)
  requireFiles(object_files)

  input = Input()
  input:bind("a", "a")

  input:bind("down", "down")
  input:bind("up", "up")
  input:bind("left", "left")
  input:bind("right", "right")

  scenes = {}
  current_scene = nil

  goToScene("TestScene", "testing")
end

function love.update(dt)
  if current_scene then current_scene:update(dt) end
end

function love.draw()
  if current_scene then current_scene:draw() end
end

-- Recursively loads game objects
function recursiveEnumerateLoad(folder, file_list)
  local items = love.filesystem.getDirectoryItems(folder)
  for _, item in ipairs(items) do
    local file = folder .. '/' .. item
    local file_info = love.filesystem.getInfo(file)
    if file_info.type == 'file' then
      table.insert(file_list, file)
    elseif file_info.type == 'directory' then
      recursiveEnumerateLoad(file, file_list)
    end
  end
end

function requireFiles(files)
  for _, file in ipairs(files) do
    local file = file:sub(1, -5)
    require(file)
  end
end

function addScene(scene_type, scene_name, ...)
  local scene = _G[scene_type](scene_name, ...)
  scenes[scene_name] = scene
  return scene
end

function goToScene(scene_type, scene_name, ...)
  if current_scene and scenes[scene_name] then
    if current_scene.deactivate then current_scene:deactivate() end
    current_scene = scenes[scene_name]
    if current_scene.activate then current_scene:activate() end
  else current_scene = addScene(scene_type, scene_name, ...) end
end