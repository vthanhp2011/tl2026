local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ojingji_Npc_4 = class("ojingji_Npc_4", script_base)
ojingji_Npc_4.script_id = 125014
ojingji_Npc_4.g_eventList = {}

function ojingji_Npc_4:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我可以修理所有的40级以上的装备、不管是武器、防具还是饰品。不过也正是因为我当年学艺的时候对什麽都感兴趣，所以造成我对哪一方面都不算精通。所以我修理的时候成功率不是100％哦。如果你没有什麽异议的话，就找我帮你修理吧。")
    self:AddNumText("我要修理装备", 6, 1)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ojingji_Npc_4:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(-1)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19810313)
    end
end

return ojingji_Npc_4
