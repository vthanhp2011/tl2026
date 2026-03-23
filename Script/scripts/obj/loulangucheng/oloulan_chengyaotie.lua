local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oloulan_chengyaotie = class("oloulan_chengyaotie", script_base)
oloulan_chengyaotie.script_id = 001101
function oloulan_chengyaotie:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{LLGC_20080324_13}")
    self:AddNumText("装备资质鉴定", 6, 1)
    self:AddNumText("装备极限打孔", 6, 2)
    self:AddNumText("装备极限镶嵌", 6, 3)
    self:AddNumText("宝石极限摘除", 6, 4)
    self:AddNumText("极限镶嵌相关帮助", 11, 5)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oloulan_chengyaotie:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1001)
    elseif index == 2 then
        self:BeginUICommand()
            self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2013060601)
    elseif index == 3 then
        self:BeginUICommand()
            self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2013060602)
    elseif index == 4 then
        self:BeginUICommand()
            self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2013060603)
    elseif index == 5 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XQC_20080509_34}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oloulan_chengyaotie:NotifyTip(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return oloulan_chengyaotie
