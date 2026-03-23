local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_shenmishangren = class("odali_shenmishangren", script_base)
odali_shenmishangren.script_id = 900013
odali_shenmishangren.g_shoptableindexs = {239, 240, 241, 242, 243, 244, 245}

function odali_shenmishangren:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我这里时不时的会有一些好东西，只要你有耐心，一定会找到你最中意的东西的。#r    不过好东西可不会经常有哦，基本上只要一上架，就会被人买走的…… ")
    self:AddNumText("神秘商店", 7, 1)
    self:AddNumText("机缘商店", 7, 3)
    self:AddNumText("关于神秘商店", 11, 2)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_shenmishangren:NotifyTip(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function odali_shenmishangren:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        if self:GetLevel(selfId) < 30 then
            self:NotifyTip(selfId,"只有30级以上的玩家才可查看神秘商店。")
            return
        end
        local i = os.date("%j") % (#self.g_shoptableindexs) + 1
        if i == 6 then
            i = 5
        end
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindexs[i])
        return
    end
    if index == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SMYBSD_091102_03}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 3 then
        self:DispatchJiYuanShopInfo(selfId, targetId)
        return
    end
end

return odali_shenmishangren
