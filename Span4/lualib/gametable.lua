local laiscript = require "laiscript"
local class = require "class"
local configenginer = require "configenginer":getinstance()
local gametable = class("gametable")
function gametable:getinstance()
    if gametable.instance == nil then
        gametable.instance = gametable.new()
    end
    return gametable.instance
end

function gametable:ctor()

end

function gametable:init()
    self.ai_scripts = {}
    local ai_script_dat = configenginer:get_config("ai_script_dat")
    for i = 0, #ai_script_dat - 1 do
        local file = ai_script_dat[i]
        if file then
            local path = string.format("configs/AIScript/%s", file)
            local as = laiscript.AIScript.new()
            as:ParseScript(path)
            self.ai_scripts[i] = as
        end
    end
end

function gametable:get_ai_script(id)
    return self.ai_scripts[id]
end

return gametable