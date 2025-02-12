
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

-- Puts a player in zip mode
function LevelData:StartZip()
  if not self.character:zipActive() then
    return
  end

  self.isZipping = true
  self.zipTimer = 0
end

function LevelData:handlePlayerZip()
  if not self.character:zipActive() then
    return nil
  end

  -- Parse zip direction
  local playerDirection = self.character.moves[1]

  local xMove, yMove
  local woodenCrates = {}
  for x, y in string.gmatch(playerDirection, "(-?%d),(-?%d)") do
    xMove = x
    yMove = y
    break
  end

  -- Figure out spaces until we hit a wall or metal crate
  local canMove = true
  local metalCrate = nil
  local objects = {}
  nextLocation = {x = self.character.x, y = self.character.y}
  print("Zipping character at "..self.character.x..","..self.character.y)
  print("Direction: "..xMove..","..yMove)
  while canMove do
    nextLocation = {x = nextLocation.x + xMove, y = nextLocation.y + yMove}

    print(nextLocation.x..","..nextLocation.y)
    local tile = self:getTile(nextLocation.x, nextLocation.y)
    if not tile or not tile:canMoveHere() then
      print("bad tile")
      canMove = false
    end

    local objs = self.level_objects:getObjectsAt(nextLocation.x, nextLocation.y)
    if objs then
      for _, obj in ipairs(objs) do
        if obj.name == "wooden_crate" then
          table.insert(woodenCrates, obj)
        end
  
        if obj.name == "metal_crate" then
          canMove = false
          metalCrate = obj
          print("found metal crate")
        else
          print(obj.name)
        end
      end
    end

    -- canMove = false
  end
  print("wooden_crates: "..table.getn(woodenCrates))

  -- nextLocation now has the location of either a metal crate or a wall
  local xDiff = nextLocation.x - self.character.x
  local yDiff = nextLocation.y - self.character.y

  -- Walk back nextLocation and place wooden crates, then the player
  -- Wooden crates might get shifted around, we are assuming individuality doesn't matter
  nextLocation.x = nextLocation.x - xMove
  nextLocation.y = nextLocation.y - yMove

  for _, crate in ipairs(woodenCrates) do
    self:moveObject(crate, nextLocation.x, nextLocation.y)
    nextLocation.x = nextLocation.x - xMove
    nextLocation.y = nextLocation.y - yMove
  end

  self:moveObject(self.character, nextLocation.x, nextLocation.y)

  -- todo: handle pushing metal crate here

end

function LevelData:update(dt)
  if not self.isZipping then
    return
  end

  -- Decrement zip timer
  self.zipTimer = self.zipTimer - dt
  if self.zipTimer > 0 then
    return
  end

  -- handle zip movement and reset timer

  -- Parse zip direction
  local playerDirection = self.character.moves[1]

  local xMove, yMove
  local woodenCrates = {}
  for x, y in string.gmatch(playerDirection, "(-?%d),(-?%d)") do
    xMove = x
    yMove = y
    break
  end

  local inputDirection = {x = xMove, y = yMove}
  local didMove = self:tryMoveCharacter(inputDirection, true)

  -- todo: handle false more?
  if not didMove then
    self.isZipping = false
  end

  self.zipTimer = 1/60
end

function LevelData:handlePlayerMove(inputDirection)
  if self.isZipping then
    return
  end

  local didMove = self:tryMoveCharacter(inputDirection, false)

  -- todo: play bump sound if we cannot move?
end


function LevelData:tryMoveCharacter(inputDirection, isZipping)
  local newCharX = self.character.x + inputDirection.x
  local newCharY = self.character.y + inputDirection.y

  local moveableObjects = self:getObjectsToMove(self.character, newCharX, newCharY, inputDirection, isZipping)
  if moveableObjects then
    for _, obj in pairs(moveableObjects) do
      local newX = obj.x + inputDirection.x
      local newY = obj.y + inputDirection.y
      self:moveObject(obj, newX, newY)
    end

    -- Handle objects on top of each other now
    for _, obj in pairs(moveableObjects) do
      -- Todo: handle objects on top of each other now
    end
    return true
  else
    return false
  end
end

function LevelData:moveObject(obj, newX, newY)
  local oldKey = obj.x..","..obj.y
  local newKey = newX..","..newY

  self.level_objects:move(obj, newX, newY)

end

-- Returns a list of objects that should move, or nil if they cannot
-- Recursively calls into itself for pushing blocks
function LevelData:getObjectsToMove(objMoving, newCharX, newCharY, direction, isZipping)
  local tile = self:getTile(newCharX, newCharY)
  if not tile:canMoveHere() then return nil end

  -- For objects, first check we can move through them
  -- Pushable objects like wooden blocks are able to be moved through
  local objs = self.level_objects:getObjectsAt(newCharX, newCharY)
  if not objs then return {objMoving} end

  for _, obj in pairs(objs) do
    if not obj:canMoveThrough() then return nil end
  end

  -- Then recursively check if we can/need to push
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


function LevelData:getTile(x, y)
  local row = self:getRow(y)
  if row then
    return row[x]
  end
end

function LevelData:getRow(row)
  return self.data[row]
end

-- Returns a flat list of objects in the level
function LevelData:getObjectsAndCharacter()
  return self.level_objects:getObjects()
end



function LevelData:GetDimensions()

end

return LevelData