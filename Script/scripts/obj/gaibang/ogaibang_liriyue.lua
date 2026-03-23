local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ogaibang_liriyue = class("ogaibang_liriyue", script_base)
ogaibang_liriyue.script_id = 010011
ogaibang_liriyue.g_shoptableindex = 49
function ogaibang_liriyue:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  来看看吧，我这里有上好的坐骑。")
    self:AddNumText("骑术介绍", 11, 101)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ogaibang_liriyue:OnEventRequest(selfId, targetId, arg, index)
    if index == 100 then
    elseif index == 101 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_012}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

return ogaibang_liriyue
