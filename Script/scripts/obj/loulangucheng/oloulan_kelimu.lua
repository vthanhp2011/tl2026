local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oloulan_kelimu = class("oloulan_kelimu", script_base)
oloulan_kelimu.script_id = 001119
function oloulan_kelimu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{loulan_baoshigongjiang_20080329}")
    self:AddNumText("宝石相关介绍", 11, 0)
    self:AddNumText("材料合成介绍", 11, 20)
    self:AddNumText("宝石合成", 6, 1)
    self:AddNumText("装备打孔", 6, 2)
    self:AddNumText("宝石摘除", 6, 3)
    self:AddNumText("材料合成", 6, 4)
    self:AddNumText("宝石镶嵌", 6, 5)
    self:AddNumText("宝石雕琢", 6, 6)
    self:AddNumText("宝石熔炼", 6, 7)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oloulan_kelimu:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_104}#r")
        self:AddNumText("装备打孔介绍", 11, 8)
        self:AddNumText("宝石合成介绍", 11, 9)
        self:AddNumText("宝石镶嵌介绍", 11, 10)
        self:AddNumText("宝石摘除介绍", 11, 11)
        self:AddNumText("宝石雕琢介绍", 11, 13)
        self:AddNumText("宝石熔炼介绍", 11, 14)
        self:AddNumText("胜利宝石介绍", 11, 15)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 20 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SJSJ_081021_003}#r")
        self:AddNumText("精铁的操作介绍", 11, 21)
        self:AddNumText("秘银的操作介绍", 11, 22)
        self:AddNumText("棉布的操作介绍", 11, 23)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 21 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SJSJ_081021_004}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 22 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SJSJ_081021_005}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 23 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SJSJ_081021_006}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 8 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_039}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 9 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_040}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_041}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_042}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 13 then
        self:BeginEvent(self.script_id)
        self:AddText("#{INTERFACE_XML_GemCarve_6}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 14 then
        self:BeginEvent(self.script_id)
        self:AddText("#{JKBS_081021_022}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 15 then
        self:BeginEvent(self.script_id)
        self:AddText("#{JKBS_081021_023}#r")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 1 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 23)
        return
    end
    if index == 2 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 25)
        return
    end
    if index == 3 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 27)
        return
    end
    if index == 4 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19810424)
        return
    end
    if index == 5 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19830424)
        return
    end
    if index == 6 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 112236)
        return
    end
    if index == 7 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 112237)
        return
    end
end

return oloulan_kelimu
