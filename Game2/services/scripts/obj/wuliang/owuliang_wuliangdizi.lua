local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owuliang_wuliangdizi = class("owuliang_wuliangdizi", script_base)
owuliang_wuliangdizi.script_id = 006007
function owuliang_wuliangdizi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  无量派正在#G剑湖宫#W举行五年一度的比武斗剑。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return owuliang_wuliangdizi
