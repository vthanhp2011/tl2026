local class = require "class"
local gbk = require "gbk"
local reader = class("reader")

function reader:ctor()
    self.fs = {}
end

local function load(fileName)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.')
    local fullFilName = string.format("%s", fileName)
	local file = assert(io.open(fullFilName, 'r'), 'Error loading file : ' .. fullFilName)
	local data = {}
	local section
	for line in file:lines() do
        line = gbk.toutf8(line)
		local tempSection = line:match('%[([_%w]+)%]')
		if(tempSection)then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection
			data[section] = data[section] or {}
        else
            local param, value = line:match("([_%w]+)=([^%;-%\r-%\t]+)")
            if(param and value)then
                if(tonumber(value))then
                    value = tonumber(value)
                elseif(value == 'true')then
                    value = true
                elseif(value == 'false')then
                    value = false
                end
                if(tonumber(param))then
                    param = tonumber(param)
                end
                data[section][param] = value
            else
                param, value = line:match("([_%w]+):([^%;-%\r-%\t]+)")
                if param and value then
                    if(tonumber(param))then
                        param = tonumber(param)
                    end
                    data[section][param] = value
                end
            end
		end
	end
	file:close()
	return data
end

function reader:load(fn)
    if self.fs[fn] == nil then
        self.fs[fn] = load(fn)
    end
    return self.fs[fn]
end

function reader:get(fn)
    return self.fs[fn]
end

return reader