local class = require "class"
local iostream = require "iostream"
local pathparser = class("pathparser")

function pathparser:load(f)
    local f = io.open(f, "rb")
    local buffer = f:read("*a")
    local bistream = iostream.bistream
    local is = bistream.new()
    is:attach(buffer)
    local version = is:readushort()
    print("version =", version)
    local offset = is:readuint()
    offset = offset * 8
    print("offset =", offset)
    local polygons = {}
    for i = 1, math.floor(offset / ( 5 * 2 * 4)) do
        local polygon = {}
        for j = 1, 5 do
            local point = {}
            local x = is:readfloat()
            local y = is:readfloat()
            point.x = x
            point.y = y
            table.insert(polygon, point)
        end
        print("i =", i, ";polygon =", table.tostr(polygon))
        table.insert(polygons, polygon)
    end
    return polygons
end

return pathparser