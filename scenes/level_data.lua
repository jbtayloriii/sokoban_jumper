LevelData = Object:extend()

function LevelData:new(text)
    -- todo new
    local all_data = self:LoadLevel(text)
    self.data = all_data["tiles"]
    self.objects = all_data["objects"]
end

-- Loads a single tile for a level
-- Adds a floor under objects and adds objects to the "objects" param
-- Returns the tile (floor, pit, wall)
local function _parseLevelChar(c, objects, x, y)
    if c == "b" then
      table.insert(objects, Bone(x, y))
      return Floor()
    elseif c == "s" then
      table.insert(objects, Character(x, y))
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

function LevelData:LoadLevel(text)
  local tileData = {}
  local objects = {}
  local y = 1
  for line in text:gmatch("[^\n]+\n") do
      local x = 1
      local levelRow = {}
      for c in line:gmatch("[^\n]") do
        table.insert(levelRow, _parseLevelChar(c, objects, x, y))
        x = x + 1
      end
      table.insert(tileData, levelRow)
      y = y + 1
  end

  return {tiles=tileData, objects=objects}
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