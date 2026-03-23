local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxingxiu_tianxuanzi = class("oxingxiu_tianxuanzi", script_base)
oxingxiu_tianxuanzi.script_id = 016035
function oxingxiu_tianxuanzi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("前日苍龙出现于天，师父的神木王鼎竟发出嗡嗡之声，引来无数巨大蜘蛛，此正是修炼的好时机，你可愿意去看看？")
    self:AddNumText("打蜘蛛修炼", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxingxiu_tianxuanzi:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 51 then
            self:BeginEvent(self.script_id)
            local strText = "进入修炼的江湖中人，大都是51级以上，看你武功平平，我可不敢带你去。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 146, 91, 144)
        end
    end
end

return oxingxiu_tianxuanzi
