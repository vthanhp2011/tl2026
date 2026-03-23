local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owudang_xiaotianyi = class("owudang_xiaotianyi", script_base)
owudang_xiaotianyi.script_id = 012035
function owudang_xiaotianyi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("古来修炼之士，皆会遇到心魔之事，适天师在武当山布下大阵，可有机会战败心魔，你愿意试试自己的实力吗？")
    self:AddNumText("去挑战心魔", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function owudang_xiaotianyi:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 71 then
            self:BeginEvent(self.script_id)
            local strText = "所谓先修外，后修内，你的等级不到71级，枉自进入，恐怕会走火入魔啊。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 142, 91, 183)
        end
    end
end

return owudang_xiaotianyi
