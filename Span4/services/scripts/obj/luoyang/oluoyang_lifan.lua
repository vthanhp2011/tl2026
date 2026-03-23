--NPC
--
--脚本号
local gbk = require "gbk"
local class = require "class"
local script_base = require "script_base"
local oluoyang_lifan = class("oluoyang_lifan", script_base)
local g_Stone = 20310020      --玄昊玉
local g_BindStone = 20310021  --绑定玄昊玉
local g_CountLimit = 50
local g_MeiHuaBiao = 10155003  --梅花镖
local g_MeiHuaBiaoBound = 10155005  --绑定梅花镖[tx45022]
oluoyang_lifan.g_eventList = {1018707,1018708,500604,500607}
function oluoyang_lifan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
        self:AddText("  江湖本就是个是非之地，多有逞凶为恶的武林败类，要想让天下祥和，就得看各位侠士的了。")
		self:AddNumText("#{AQFC_090115_14}", 6, 2)
		self:AddNumText("#{AQFC_090115_13}",11, 3)
		for i, eventId in pairs(self.g_eventList) do
			self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
		end
    self:EndEvent()
    self:DispatchEventList(selfId,targetId)
end

function oluoyang_lifan:DoExchange(selfId, targetId)
	local count = self:LuaFnGetAvailableItemCount(selfId, g_Stone)
	local bindCount = self:LuaFnGetAvailableItemCount(selfId, g_BindStone)
	if count + bindCount < g_CountLimit then
		self:notify_tips(selfId, "#{LLFB_80821_5}")
		self:CloseWindow(selfId,targetId)
		return
	end
    -- 检查背包空间
	if self:LuaFnGetPropertyBagSpace(selfId ) < 1 then
        self:notify_tips(selfId,"#{AQFC_090115_07}")
		return
	end
	local nItemBagIndexStone
	local szTransferStone
	--优先扣除绑定的玄昊玉
	local bDelOk
	if bindCount >= g_CountLimit then
		nItemBagIndexStone = self:GetBagPosByItemSn(selfId, g_BindStone)
		szTransferStone = self:GetBagItemTransfer(selfId, nItemBagIndexStone)
		bDelOk = self:LuaFnDelAvailableItem(selfId, g_BindStone, g_CountLimit)
		if not bDelOk then
            self:notify_tips(selfId, "#{JPZB_0610_12}")
		    return
	    end
	else
		nItemBagIndexStone = self:GetBagPosByItemSn(selfId, g_Stone)
		szTransferStone = self:GetBagItemTransfer(selfId, nItemBagIndexStone)
		if bindCount > 0 then
			bDelOk = self:LuaFnDelAvailableItem(selfId, g_BindStone, bindCount)
			if not bDelOk    then
                self:notify_tips(selfId, "#{JPZB_0610_12}")
		        return
	        end
		end
		bDelOk = self:LuaFnDelAvailableItem(selfId, g_Stone, g_CountLimit - bindCount)
		if not bDelOk then
            self:notify_tips(selfId, "#{JPZB_0610_12}")
	        return
        end
	end
	--获取暗器[tx44913]
	local nBagIndex
	if bindCount > 0 then
		nBagIndex = self:TryRecieveItem(selfId, g_MeiHuaBiaoBound, 1)
	else
		nBagIndex = self:TryRecieveItem(selfId, g_MeiHuaBiao, 1 )
	end
	local szTransferEquip = self:GetBagItemTransfer(selfId, nBagIndex)
	--获取暗器[/tx44913]
	self:notify_tips(selfId, "#{AQFC_090115_08}")
	--特效
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
    --公告
    local name = self:LuaFnGetName(selfId)
    name = gbk.fromutf8(name)
    local message = string.format("#{AQ_04}#{_INFOUSR%s}#{AQ_01}#{_INFOMSG%s}#{AQ_02}#{_INFOMSG%s}#{AQ_03}", name, szTransferStone, szTransferEquip)
	self:BroadMsgByChatPipe(selfId, message, 4)
	self:CloseWindow(selfId,targetId)
end

function oluoyang_lifan:CloseWindow(selfId,targetId)
	self:BeginUICommand()
		self:UICommand_AddInt(targetId )
	self:EndUICommand()
	self:DispatchUICommand(selfId, 1000 )
end

function oluoyang_lifan:OnEventRequest(selfId, targetId, arg, index)
    if index == 2 then
        self:BeginEvent(self.script_id)
            self:AddText("#{AQFC_090115_06}")
            self:AddNumText("#{INTERFACE_XML_557}", 6, 4)
            self:AddNumText("#{Agreement_Info_No}", 8, 5)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 4 then
        self:DoExchange(selfId, targetId)
        return
    end
    if index == 5 then
        return
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,arg,index)
            return
        end
    end
end
function oluoyang_lifan:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept",selfId, targetId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId,targetId, missionScriptId)
            end
            return
        end
    end
end

function oluoyang_lifan:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:OnDefaultEvent(selfId, targetId)
            return
        end
    end
end

function oluoyang_lifan:OnMissionContinue(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,targetId)
            return
        end
    end
end

function oluoyang_lifan:OnMissionSubmit(selfId, targetId, missionScriptId,selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_lifan:OnDie(selfId, killerId) end

return oluoyang_lifan