local class = require "class"
local define = require "define"
local script_base = require "script_base"
local shaxing_title = class("shaxing_title", script_base)
shaxing_title.script_id = 760558
shaxing_title.g_gotoact = 2
shaxing_title.g_leave = 20
function shaxing_title:OnDefaultEvent(selfId, targetId)
    local nam = self:LuaFnGetName(selfId)
    if self:LuaFnGetAvailableItemCount(selfId, 59910051) < 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SXRW_090119_043}")
        self:AddNumText("领取煞星称号", 6, 100)
        self:AddNumText("领取称号帮助", 11, 200)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    else
        self:BeginEvent(self.script_id)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function shaxing_title:OnEventRequest(selfId, targetId, arg, index)
    if index == 100 then
        self:BeginEvent(self.script_id)
        self:AddNumText("广目天王", 1, 1000)
        self:AddNumText("多闻天王", 1, 1001)
        self:AddNumText("增长天王", 1, 1002)
        self:AddNumText("持国天王", 1, 1003)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 200 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SXRW_090119_109}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 1000 then
        local c0 = self:LuaFnGetAvailableItemCount(selfId, 59910051)
        if c0 < 1 then
            self:BeginEvent(self.script_id)
            self:LuaFnAwardSpouseTitle(selfId, "广目天王")
            self:LuaFnDelAvailableItem(selfId, 59910051, 1)
            self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, -1, 0)
            self:DispatchAllTitle(selfId)
            self:BeginEvent(self.script_id)
            self:AddText("#G恭喜，您成功领取了广目天王称号。")
            local nam = self:LuaFnGetName(selfId)
            self:BroadMsgByChatPipe(selfId, "#gff00f0恭喜玩家#gffff00" .. nam .. "#gff00f0成功领取称号广目天王", 4)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            local strNotice = "#G请检查您包裹的属性称号证明！！"
            self:ShowNotice(selfId, targetId, strNotice)
        end
    elseif index == 1001 then
        local c0 = self:LuaFnGetAvailableItemCount(selfId, 59910051)
        if c0 < 1 then
            self:BeginEvent(self.script_id)
            self:LuaFnAwardSpouseTitle(selfId, "多闻天王")
            self:LuaFnDelAvailableItem(selfId, 59910051, 1)
            self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, -1, 0)
            self:DispatchAllTitle(selfId)
            self:BeginEvent(self.script_id)
            self:AddText("#G恭喜，您成功领取了多闻天王称号。")
            local nam = self:LuaFnGetName(selfId)
            self:BroadMsgByChatPipe(selfId, "#gff00f0恭喜玩家#gffff00" .. nam .. "#gff00f0成功领取称号多闻天王", 4)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            local strNotice = "#G请检查您包裹的属性称号证明！！"
            self:ShowNotice(selfId, targetId, strNotice)
        end
    elseif index == 1002 then
        local c0 = self:LuaFnGetAvailableItemCount(selfId, 59910051)
        if c0 < 1 then
            self:BeginEvent(self.script_id)
            self:LuaFnAwardSpouseTitle(selfId, "增长天王")
            self:LuaFnDelAvailableItem(selfId, 59910051, 1)
            self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, -1, 0)
            self:DispatchAllTitle(selfId)
            self:BeginEvent(self.script_id)
            self:AddText("#G恭喜，您成功领取了增长天王称号。")
            local nam = self:LuaFnGetName(selfId)
            self:BroadMsgByChatPipe(selfId, "#gff00f0恭喜玩家#gffff00" .. nam .. "#gff00f0成功领取称号增长天王", 4)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            local strNotice = "#G请检查您包裹的属性称号证明！！"
            self:ShowNotice(selfId, targetId, strNotice)
        end
    elseif index == 1003 then
        local c0 = self:LuaFnGetAvailableItemCount(selfId, 59910051)
        if c0 < 1 then
            self:BeginEvent(self.script_id)
            self:LuaFnAwardSpouseTitle(selfId, "持国天王")
            self:LuaFnDelAvailableItem(selfId, 59910051, 1)
            self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, -1, 0)
            self:DispatchAllTitle(selfId)
            self:BeginEvent(self.script_id)
            self:AddText("#G恭喜，您成功领取了持国天王称号。")
            local nam = self:LuaFnGetName(selfId)
            self:BroadMsgByChatPipe(selfId, "#gff00f0恭喜玩家#gffff00" .. nam .. "#gff00f0成功领取称号持国天王", 4)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            local strNotice = "#G请检查您包裹的属性称号证明！！"
            self:ShowNotice(selfId, targetId, strNotice)
        end
    end
end

function shaxing_title:TalkMsg(selfId, targetId, str)
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function shaxing_title:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function shaxing_title:Restore_hpmp(selfId, targetId)
    self:RestoreHp(selfId)
    self:RestoreMp(selfId)
    self:RestoreRage(selfId)
end

return shaxing_title
