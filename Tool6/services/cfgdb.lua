local skynet = require "skynet"
local class = require "class"
local CfgHelper = require "cfghelper":getinstance()
local CMD = setmetatable({}, {
    __index = function(_, k)
        local method = CfgHelper[k]
        assert(method, k)
        return function(...) return method(CfgHelper, ...) end
    end
})

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        print(...)
        local f = assert(CMD[command], command)
        skynet.ret(skynet.pack(f(...)))
    end)
end)
