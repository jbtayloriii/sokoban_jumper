LevelObjects = Object:extend()

function LevelObjects:new(objects)
    self.object_pos = {}
    for _, obj in pairs(objects) do
        self:_add(obj)
    end
end

function LevelObjects:_add(obj)
    local key = obj.x..","..obj.y
    if not self.object_pos[key] then
        self.object_pos[key] = {}
    end
    self.object_pos[key][obj.uuid] = obj
end

function LevelObjects:_remove(obj)
    local key = obj.x..","..obj.y
    local obj_check = self.object_pos[key][obj.uuid]
    if obj ~= obj_check then
        error(string.format("Got wrong object in level objects table: %s", obj_check))
    end
    self.object_pos[key][obj.uuid] = nil

    -- Hack, return without deleting cell table if there are any others remaining
    for _ in pairs(self.object_pos[key]) do
        return
    end
end

function LevelObjects:move(obj, newX, newY)
    self:_remove(obj)
    obj.x = newX
    obj.y = newY
    self:_add(obj)
end

function LevelObjects:getObjectsAt(x, y)
    if not self.object_pos[key] then
        return nil
    end

    local key = x..","..y
    local objs = {}
    for _, obj in pairs(self.object_pos[key]) do
        table.insert(objs, obj)
    end
    return objs
end

-- Returns a flat list of objects
function LevelObjects:getObjects()
    local objs = {}
    for _, obj_list in pairs(self.object_pos) do
        for _, obj in pairs(obj_list) do
            table.insert(objs, obj)
        end
    end

    return objs
end

return LevelObjects