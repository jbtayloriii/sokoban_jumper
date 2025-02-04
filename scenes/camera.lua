Camera = Object:extend()


_TILE_SIZE = 16 -- Sprites are 16x16 pixels

--
-- Creates a new Camera
-- 
-- Args:
--  width (number) - The width (radius, not diameter) of the camera
--  height (number) - The hegiht (radius, not diameter) of the camera
-- center (table) - An (x, y) coordinate of the initial camera center
function Camera:new(args)
    if type(args.width) ~= "number" then error("no width") end
    if type(args.height) ~= "number" then error("no height") end
    if type(args.center) ~= "table" then error("no center") end

    self.width = args.width
    self.height = args.height
    self.center = args.center
end

function Camera:update(dt)
    -- todo update
end

function Camera:drawTilesToCanvas(canvas, levelData)

    -- debugging, should not show this
    love.graphics.clear(1, 1, 0, 0)

    for x = self.center.x - self.width, self.center.x + self.width do
        for y = self.center.y - self.height, self.center.y + self.height do
            local didDraw = false
            local row = levelData:getRow(y)
            if row ~= nil then
                local obj = row[x]
                if obj ~= nil then
                    local x_pos, y_pos = x * _TILE_SIZE, y * _TILE_SIZE
                    obj:draw(x_pos, y_pos)
                    didDraw = True
                end
            end

            if not didDraw then
                -- Draw OOB
                -- love.graphics.polygon("fill")
            end
        end
    end
end

function Camera:update(levelData)
    -- Always center on player
    self.center = {x = levelData.character.x, y = levelData.character.y}
end

function Camera:isInView(x, y)
    if x < self.center.x - self.width or x > self.center.x + self.width then
        return false
    elseif y < self.center.y - self.height or y > self.center.y + self.height then
        return false
    end
    return true
end

function Camera:drawObjectsToCanvas(canvas, levelData)
    for _, obj in pairs(levelData:getObjects()) do
        if self:isInView(obj.x, obj.y) then
            local x_pos, y_pos = obj.x * _TILE_SIZE, obj.y * _TILE_SIZE
            obj:draw(x_pos, y_pos)
        end
    end
end

return Camera