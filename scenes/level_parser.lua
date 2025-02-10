local LevelParser = {}

local _MAX_LEVEL_NUMBER = 1

function LevelParser.loadLevel(levelNumber)
  if levelNumber < 1 then
    levelNumber = _MAX_LEVEL_NUMBER
  elseif levelNumber > _MAX_LEVEL_NUMBER then
    levelNumber = 1
  end
  local levelName = "assets/levels/level_"..levelNumber..".txt"

  io.input(levelName)
  local text = io.read("*all")

  levelIterator = text:gmatch( "([^-]+)---")

  local levelMetadata = LevelParser._parseMetadata(levelIterator())

  local levelWidth = 1
  local tileData = {}
  local objects = {}
  local charTable = {}
  local y = 1
  for line in levelIterator():gmatch("[^\n]+") do
    local x = 1
    local levelRow = {}
    for c in line:gmatch("[^\n]") do
    table.insert(levelRow, LevelParser._parseLevelChar(c, objects, charTable, x, y))
    x = x + 1
    end
    levelWidth = math.max(levelWidth, table.getn(levelRow))
    table.insert(tileData, levelRow)
    y = y + 1
  end

  levelHeight = table.getn(tileData)

  return {
    tiles=tileData,
    objects=objects,
    character = charTable["character"],
    width=levelWidth,
    height=levelHeight,
    metadata=levelMetadata,
  }
end

function LevelParser._parseMetadata(metadata_text)
  local title = metadata_text:gmatch("([^\n]+)")()
  return {
    title=title
  }
end

-- Loads a single tile for a level
-- Adds a floor under objects and adds objects to the "objects" param
-- Returns the tile (floor, pit, wall)
 function LevelParser._parseLevelChar(c, objects, charTable, x, y)
    if c == "b" then
      objects[x..","..y] = Bone(x, y)
      return Floor()
    elseif c == "s" then
      local character = Character(x, y)
      charTable["character"] = character
      objects[x..","..y] = character
      return Floor()
    elseif c == "f" then
      objects[x..","..y] = Fire(x, y)
      return Floor()
    elseif c == "." then
      return Floor()
    elseif c == "m" then
      objects[x..","..y] = MetalCrate(x, y)
      return Floor()
    elseif c == "w" then
      objects[x..","..y] = WoodenCrate(x, y)
      return Floor()
    elseif c == "x" then
      return Wall()
    elseif c == "e" then
      objects[x..","..y] = Exit(x, y)
      return Floor()
    end
  
    error("Unable to parse level char "..c)
end

return LevelParser