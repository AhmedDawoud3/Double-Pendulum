DoublePendulum = Class {}

function DoublePendulum:init(r1, r2, m1, m2, a1, a2, params)
    self.r1 = r1
    self.r2 = r2
    self.m1 = m1
    self.m2 = m2
    self.a1 = a1
    self.a2 = a2
    self.a1_v = 0
    self.a2_v = 0
    self.a1_a = 0
    self.a2_a = 0
    self.canvas = {self.r1 * math.sin(self.a1) + self.r2 * math.sin(self.a2),
                   self.r2 * math.cos(self.a1) + self.r2 * math.cos(self.a2)}
    if params then
        self.damping = params.damping or 1
    else
        self.damping = 1
    end
end

function DoublePendulum:Update(dt, g)
    self.a1_v = self.a1_v + self.a1_a
    self.a2_v = self.a2_v + self.a2_a
    self.a1 = self.a1 + self.a1_v
    self.a2 = self.a2 + self.a2_v
    self.a1_v = self.a1_v * self.damping
    self.a2_v = self.a2_v * self.damping
    self.a1_a = ((-g * (2 * self.m1 + self.m2) * math.sin(self.a1)) + (-self.m2 * g * math.sin(self.a1 - 2 * self.a2)) +
                    (-2 * math.sin(self.a1 - self.a2) * self.m2) *
                    (self.a2_v ^ 2 * self.r2 + self.a1_v ^ 2 * self.r1 * math.cos(self.a1 - self.a2))) /
                    (self.r1 * (2 * self.m1 + self.m2 - self.m2 * math.cos(2 * self.a1 - 2 * self.a2)))

    self.a2_a = ((2 * math.sin(self.a1 - self.a2)) *
                    ((self.a1_v ^ 2 * self.r1 * (self.m1 + self.m2)) + (g * (self.m1 + self.m2) * math.cos(self.a1)) +
                        (self.a2_v ^ 2 * self.r2 * self.m2 * math.cos(self.a1 - self.a2)))) /
                    (self.r2 * (2 * self.m1 + self.m2 - self.m2 * math.cos(2 * self.a1 - 2 * self.a2)))
end

function DoublePendulum:Render()
    self.x1 = self.r1 * math.sin(self.a1)
    self.y1 = self.r2 * math.cos(self.a1)

    self.x2 = self.x1 + self.r2 * math.sin(self.a2)
    self.y2 = self.y1 + self.r2 * math.cos(self.a2)
    table.insert(self.canvas, self.x2)
    table.insert(self.canvas, self.y2)

    love.graphics.line(0, 0, self.x1, self.y1)
    love.graphics.circle('fill', self.x1, self.y1, self.m1, self.m1)

    love.graphics.line(self.x1, self.y1, self.x2, self.y2)
    love.graphics.circle('fill', self.x2, self.y2, self.m2, self.m2)

    love.graphics.line(self.canvas)

end
