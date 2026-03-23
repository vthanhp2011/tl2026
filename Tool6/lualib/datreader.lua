local class = require "class"
local gbk = require "gbk"
local reader = class("reader")
local function load(fileName)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.')
    local fullFilName = string.format("configs/%s", fileName)
	local file = assert(io.open(fullFilName, 'r'), 'Error loading file : ' .. fullFilName)
    local dat = {}
    for line in file:lines() do
        line = gbk.toutf8(line)
        local key, val = string.match(line, "(%d+)=([%w-%.]+)")
        if key and val then
            dat[tonumber(key)] = val
        end
    end
    return dat
end

function reader:load(fn)
    return load(fn)
end

return reader