Animation = Object:extend()

function Animation:new(spritesheet, width, height, duration)
    self.spritesheet = spritesheet
    self.quads = {}

    for y = 0, spritesheet:getHeight() - height do
        for x = 0, spritesheet:getWidth() - width do
            table.insert(self.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
    self.duration = duration
    self.currentTime = 0
end

function Animation:update(dt)
    -- todo update
end

function Animation:draw()
    -- todo draw
end

return Animation