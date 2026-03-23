local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_tongren_1 = class("otianlong_tongren_1", script_base)
function otianlong_tongren_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  手太阴肺经要穴如下：中府、云门、天府、侠白、尺泽、孔最、列缺、经渠、太渊、鱼际、少商。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_tongren_1
