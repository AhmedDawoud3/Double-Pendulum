r1 = 200
r2 = 200
m1 = 10
m2 = 10
a1 = 0
a2 = 0
a1_v = 0
a2_v = 0

g = 1

function love.load()
    love.window.setMode(900, 600)
    love.window.setTitle("Double Pendulum")

    a1 = math.pi / 2
    a2 = math.pi / 2
    canvas = {r1 * math.sin(a1) + r2 * math.sin(a2), r2 * math.cos(a1) + r2 * math.cos(a2)}

end

function love.update(dt)

end

function love.draw()

    num1 = -g * (2 * m1 + m2) * sin(a1)
    num2 = -m2 * g * sin(a1 - 2 * a2)
    num3 = -2 * sin(a1 - a2) * m2
    num4 = a2_v ^ 2 * r2 + a1_v ^ 2 * r1 * cos(a1 - a2)
    den = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2))

    a1_a = (num1 + num2 + num3 * num4) / den

    num1 = 2 * sin(a1 - a2)
    num2 = (a1_v ^ 2 * r1 * (m1 + m2))
    num3 = g * (m1 + m2) * cos(a1)
    num4 = a2_v ^ 2 * r2 * m2 * cos(a1 - a2)
    den = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2))

    a2_a = (num1 * (num2 + num3 + num4)) / den
    love.graphics.clear(1, 1, 1, 1)
    love.graphics.setColor(0, 0, 0, 1)
    -- love.graphics.setLineWidth(2)
    love.graphics.translate(love.graphics.getWidth() / 2, 50)

    x1 = r1 * math.sin(a1)
    y1 = r2 * math.cos(a1)

    x2 = x1 + r2 * math.sin(a2)
    y2 = y1 + r2 * math.cos(a2)
    table.insert(canvas, x2)
    table.insert(canvas, y2)

    love.graphics.line(0, 0, x1, y1)
    love.graphics.circle('fill', x1, y1, m1, m1)

    love.graphics.line(x1, y1, x2, y2)
    love.graphics.circle('fill', x2, y2, m2, m2)

    print(#canvas)

    love.graphics.line(canvas)

    a1_v = a1_v + a1_a
    a2_v = a2_v + a2_a
    a1 = a1 + a1_v
    a2 = a2 + a2_v
    -- a1_v = a1_v * 0.99
    -- a2_v = a2_v * 0.99
end

function sin(x)
    return math.sin(x)
end
function cos(x)
    return math.cos(x)
end
