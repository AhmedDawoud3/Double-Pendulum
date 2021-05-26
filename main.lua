Class = require("class")
require 'doublePendulum'

g = 1

function love.load()
    love.window.setMode(900, 600)
    love.window.setTitle("Double Pendulum")

    p1 = DoublePendulum(200, 200, 10, 10, math.pi / 2, math.pi / 2)
end

function love.update(dt)
    p1:Update(dt, g)
end

function love.draw()

    love.graphics.clear(1, 1, 1, 1)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.translate(love.graphics.getWidth() / 2, 50)

    p1:Render()

end

function sin(x)
    return math.sin(x)
end
function cos(x)
    return math.cos(x)
end
