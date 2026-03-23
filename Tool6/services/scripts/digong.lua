local class = require "class"
local gbk = require "gbk"
local define = require "define"
local script_base = require "script_base"
local digong = class("digong", script_base)
digong.is_open = false
function digong:OnSceneTimer()
    if not self.is_open then
        local count = self:LuaFnGetCopyScene_HumanCount()
        for i = 1, count do
            local selfId = self:LuaFnGetCopyScene_HumanObjId(i)
            if self:LuaFnIsObjValid(selfId) then
                self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 99, 174,10)
            end
        end
    end
end

function digong:IsClose()
    return not self.is_open
end

return digong