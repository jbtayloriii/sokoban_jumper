LevelData = Object:extend()

local _MAX_LEVEL_NUMBER = 1

function LevelData:new(levelNumber)
    local all_data = self:LoadLevel(levelNumber)
    self.data = all_data["tiles"]
    self.character = all_data["character"]
    self.objects = all_data["objects"]
    self.width = all_data["width"]
    self.height = all_data["height"]
end

-- Loads a single tile for a level
-- Adds a floor under objects and adds objects to the "objects" param
-- Returns the tile (floor, pit, wall)
local function _parseLevelChar(c, objects, charTable, x, y)
    if c == "b" then
      table.insert(objects, Bone(x, y))
      return Floor()
    elseif c == "s" then
      local character = Character(x, y)
      charTable["character"] = character
      table.insert(objects, character)
      return Floor()
    elseif c == "f" then
      table.insert(objects, Fire(x, y))
      return Floor()
    elseif c == "." then
      return Floor()
    elseif c == "m" then
      table.insert(objects, MetalCrate(x, y))
      return Floor()
    elseif c == "w" then
      table.insert(objects, WoodenCrate(x, y))
      return Floor()
    elseif c == "x" then
      return Wall()
    end
  
    print("hit bad spot loading level data: "..c)
    return nil
end

function LevelData:handlePlayerInput(playerInputDirection)
  local newX = self.character.x + playerInputDirection.x
  local newY = self.character.y + playerInputDirection.y

  if self:canMoveHere(newX, newY) then
    self.character.x = newX
    self.character.y = newY
  end

  -- Otherwise play a sound?
end

function LevelData:canMoveHere(x, y)
  local tile = self:getCell(x, y)
  if tile then
    return tile:canMoveHere()
  else
    return false
  end
end

function LevelData:LoadLevel(levelNumber)
  if levelNumber < 1 then
    levelNumber = _MAX_LEVEL_NUMBER
  elseif levelNumber > _MAX_LEVEL_NUMBER then
    levelNumber = 1
  end

  local levelName = "assets/levels/level_"..levelNumber..".txt"

  io.input(levelName)
  local text = io.read("*all")

  local levelWidth = 1
  local tileData = {}
  local objects = {}
  local charTable = {}
  local y = 1
  for line in text:gmatch("[^\n]+\n") do
      local x = 1
      local levelRow = {}
      for c in line:gmatch("[^\n]") do
        table.insert(levelRow, _parseLevelChar(c, objects, charTable, x, y))
        x = x + 1
      end
      levelWidth = math.max(levelWidth, table.getn(levelRow))
      table.insert(tileData, levelRow)
      y = y + 1
  end

  levelHeight = table.getn(tileData)

  return {tiles=tileData, objects=objects, character = charTable["character"], width=levelWidth, height=levelHeight}
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

function LevelData:getObjects()
  return self.objects
end



function LevelData:GetDimensions()

end

return LevelData