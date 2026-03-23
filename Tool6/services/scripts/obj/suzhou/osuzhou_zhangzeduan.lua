local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_zhangzeduan = class("osuzhou_zhangzeduan", script_base)
function osuzhou_zhangzeduan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  再过几日就是清明节了，那时候苏州码头肯定会热闹无比。若能把这苏州的美景付于丹青之中，那该多好啊！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_zhangzeduan
