local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqianzhuang_remai = class("oqianzhuang_remai", script_base)
oqianzhuang_remai.script_id = 181002
oqianzhuang_remai.g_buyrate = 0.5
oqianzhuang_remai.g_shoptableindex = 151
oqianzhuang_remai.g_goodact = 1
oqianzhuang_remai.g_YuanBaoIntro = 18

function oqianzhuang_remai:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local strText = "    快来看一看啦，全城最畅销的商品，最便宜的价格，客官您赶紧挑几件吧，绝对超值，包您买回去后今夜做梦都会笑呢~"
    self:AddText(strText)
    self:AddNumText("购买热卖商品", 7, self.g_goodact)
    self:AddNumText("元宝介绍", 11, self.g_YuanBaoIntro)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oqianzhuang_remai:OnEventRequest(selfId, targetId, arg, index)
    if index == self.g_goodact then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(1)
        self:UICommand_AddInt(2)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 888902)
    elseif index == self.g_YuanBaoIntro then
        self:BeginEvent(self.script_id)
        self:AddText("#{INTRO_YUANBAO}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oqianzhuang_remai:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
end

function oqianzhuang_remai:NewDispatchShopItem(selfId, targetId, shopId)
    if targetId >= 0 then
        self:DispatchShopItem(selfId, targetId, shopId)
    else
        self:DispatchNoNpcShopItem(selfId, shopId)
    end
end

function oqianzhuang_remai:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function oqianzhuang_remai:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oqianzhuang_remai:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

return oqianzhuang_remai
