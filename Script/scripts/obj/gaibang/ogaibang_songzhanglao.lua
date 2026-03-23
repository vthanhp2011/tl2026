local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ogaibang_songzhanglao = class("ogaibang_songzhanglao", script_base)
ogaibang_songzhanglao.script_id = 010005
ogaibang_songzhanglao.g_eventList = {229009, 229012, 808092}

function ogaibang_songzhanglao:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("丐帮想要发展壮大，还真不能只招收乞丐。我最近收了一个弟子，他以前是个和尚。")
    for i, findId in pairs(self.g_eventList) do
        self:CallScriptFunction(self.g_eventList[i], "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ogaibang_songzhanglao:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg== findId then
            self:CallScriptFunction(
                index,
                "OnDefaultEvent",
                selfId,
                targetId,
                define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG
            )
            return
        end
    end
end

return ogaibang_songzhanglao
