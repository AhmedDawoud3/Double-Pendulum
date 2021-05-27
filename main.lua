Class = require("class")
require 'doublePendulum'

g = 1
p = {}
function love.load()
    love.window.setMode(900, 600)
    love.window.setTitle("Double Pendulum")
    for i = 1, 10000 do
        p[i] = DoublePendulum(200, 200, 1, 1, math.pi / 2 + 0.000001 * i, math.pi / 2)
    end
end

function love.update(dt)
    for i, v in ipairs(p) do
        v:Update(dt, g)
    end
end

function love.draw()

    love.graphics.clear(0, 0, 0, 1)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.translate(love.graphics.getWidth() / 2, 50)

    for i, v in ipairs(p) do
        love.graphics.setColor(HSL(i / #p * 255, 255, 100, 1))
        v:Render()
    end
end

function sin(x)
    return math.sin(x)
end
function cos(x)
    return math.cos(x)
end

function HSL(h, s, l, a)
    if s <= 0 then
        return l, l, l, a
    end
    h, s, l = h / 256 * 6, s / 255, l / 255
    local c = (1 - math.abs(2 * l - 1)) * s
    local x = (1 - math.abs(h % 2 - 1)) * c
    local m, r, g, b = (l - .5 * c), 0, 0, 0
    if h < 1 then
        r, g, b = c, x, 0
    elseif h < 2 then
        r, g, b = x, c, 0
    elseif h < 3 then
        r, g, b = 0, c, x
    elseif h < 4 then
        r, g, b = 0, x, c
    elseif h < 5 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end
    return (r + m), (g + m), (b + m), a
end
