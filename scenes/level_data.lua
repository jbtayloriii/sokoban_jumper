
LevelParser = require("scenes/level_parser")

LevelData = Object:extend()

function LevelData:new(levelNumber)
  local loadedData = LevelParser.loadLevel(levelNumber)
  self.data = loadedData["tiles"]

  self.level_objects = LevelObjects(loadedData["objects"])
  self.character = loadedData["character"]
  self.level_objects:_add(self.character)
  
  self.width = loadedData["width"]
  self.height = loadedData["height"]
  self.metadata = loadedData["metadata"]
end

function LevelData:handlePlayerZip()
  -- todo
end

function LevelData:handlePlayerMove(inputDirection)
  local newCharX = self.character.x + inputDirection.x
  local newCharY = self.character.y + inputDirection.y

  local moveableObjects = self:getObjectsToMove(self.character, newCharX, newCharY, inputDirection)
  if moveableObjects then
    for _, obj in pairs(moveableObjects) do
      local newX = obj.x + inputDirection.x
      local newY = obj.y + inputDirection.y
      self:moveObject(obj, newX, newY)
    end

    -- todo: handle player landing
  else
    -- Otherwise play a sound for not being able to move?
  end
end

function LevelData:moveObject(obj, newX, newY)
  local oldKey = obj.x..","..obj.y
  local newKey = newX..","..newY

  if oldKey == newKey then
    error("Moving object to same position at "..oldKey)
  end

  self.level_objects:move(obj, newX, newY)

end

-- Returns a list of objects that should move, or nil if they cannot
-- Recursively calls into itself for pushing blocks
function LevelData:getObjectsToMove(objMoving, newCharX, newCharY, direction)
  local tile = self:getCell(newCharX, newCharY)
  if not tile:canMoveHere() then return nil end

  -- For objects, first check we can move through them
  -- Pushable objects like wooden blocks are able to be moved through
  local objs = self.level_objects:getObjectsAt(newCharX, newCharY)
  if not objs then return {objMoving} end

  for _, obj in pairs(objs) do
    if not obj:canMoveThrough() then return nil end
  end

  -- Then check if we can/need to push
  for _, obj in pairs(objs) do
    if obj:canMovePush() then 
      local objNewX = obj.x + direction.x
      local objNewY = obj.y + direction.y
      local pushedObjs = self:getObjectsToMove(obj, objNewX, objNewY, direction)

      -- If we can't push the objects then we end
      if not pushedObjs then return nil end

      table.insert(pushedObjs, objMoving)

      -- We're assuming there can only be one pushable block in a given cell,
      -- which is why we return in the loop. This might backfire...
      return pushedObjs
    end
  end

  return {objMoving}
end

function LevelData:canObjMoveHere(x, y)
  local tile = self:getCell(x, y)
  if not tile:canMoveHere() then return false end

  local objs = self.level_objects:getObjectsAt(newCharX, newCharY)
  if not objs then return true end

  for _, obj in pairs(objs) do
    if not obj:canMoveThrough() then return nil end
  end
  return true
end


function LevelData:_canPushHere(x, y)
  local tile = self:getCell(x, y)
  if not tile:canMoveHere() then return false end

end

function LevelData:getCell(x, y)
  local row = self:getRow(y)
  if row then
    return row[x]
  else
    return nil
  end
end

function LevelData:getRow(row)
  return self.data[row]
end

-- Returns a flat list of objects in the level
function LevelData:getObjectsAndCharacter()
  -- return {}
  return self.level_objects:getObjects()
end



function LevelData:GetDimensions()

end

return LevelData