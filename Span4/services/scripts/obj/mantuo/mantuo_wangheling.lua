local class = require "class"
local define = require "define"
local script_base = require "script_base"
local mantuo_wangheling = class("mantuo_wangheling", script_base)
mantuo_wangheling.script_id = 015042
function mantuo_wangheling:OnDefaultEvent(selfId, targetId)
    local nMenPai = self:GetMenPai(selfId)
    self:BeginEvent(self.script_id)
    self:AddText("#{MPSD_220622_10}")
    if nMenPai == 10 then
        self:AddNumText("#{XMPTM_130123_126}", 12, 0)
    end
    self:AddNumText("#{XMPTM_130123_127}", 11, 10)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function mantuo_wangheling:OnEventRequest(selfId, targetId, arg, index)
    if index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_xinfajieshao_001}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:DispatchXinfaLevelInfo(selfId, targetId, 12)
end

return mantuo_wangheling
