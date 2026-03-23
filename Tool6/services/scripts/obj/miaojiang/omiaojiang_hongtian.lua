local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omiaojiang_hongtian = class("omiaojiang_hongtian", script_base)
omiaojiang_hongtian.script_id = 029006
omiaojiang_hongtian.g_shoptableindex = 109
function omiaojiang_hongtian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("看货可以，别想打听我这儿宝石的来路，我们兄弟几个可就这条生路了。")
    self:AddNumText("看看你有什麽好货", 7, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function omiaojiang_hongtian:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if (self:GetLevel(selfId) < 30) then
            self:BeginEvent(self.script_id)
            self:AddText("#{BSSR_20080131_01}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
end

return omiaojiang_hongtian
