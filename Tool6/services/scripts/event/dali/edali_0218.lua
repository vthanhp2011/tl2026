local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0218 = class("edali_0218", script_base)
edali_0218.script_id = 210218
edali_0218.g_MissionId = 458
edali_0218.g_Name = "云飘飘"
edali_0218.g_MissionKind = 13
edali_0218.g_MissionLevel = 1
edali_0218.g_IfMissionElite = 0
edali_0218.g_IsMissionOkFail = 0
edali_0218.g_PetDataID = 3000
edali_0218.g_MissionName = "我想要只兔子"
edali_0218.g_MissionInfo =
    "好吧，看你是新来的，就给你一只兔子吧，你要好好的爱护它。"
edali_0218.g_MissionTarget = "    叫我一声飘飘姐。"
edali_0218.g_ContinueInfo =
    "这是我养的兔子中最可爱的一只，你要好好照顾它。"
edali_0218.g_MissionComplete = "在大理好好玩。"

function edali_0218:OnDefaultEvent(selfId, targetId)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then return end
    local ret = self:LuaFnCreatePetToHuman(selfId, self.g_PetDataID, -1, 0)
    if ret then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_ContinueInfo)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        self:MissionCom(selfId, self.g_MissionId)
    else
        self:BeginEvent(self.script_id)
        self:AddText("你已经不能携带更多珍兽了。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function edali_0218:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then return end
    if self:IsHaveMission(selfId, self.g_MissionId) then
        caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 2, -1)
    elseif self:CheckAccept(selfId) > 0 then
        caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 1, -1)
    end
end

function edali_0218:CheckAccept(selfId)
    if self:GetLevel(selfId) >= 8 then
        return 1
    else
        return 0
    end
end

function edali_0218:OnAccept(selfId) end

function edali_0218:OnAbandon(selfId) end

function edali_0218:OnContinue(selfId, targetId) end

function edali_0218:CheckSubmit(selfId) end

function edali_0218:OnSubmit(selfId, targetId, selectRadioId) end

function edali_0218:OnKillObject(selfId, objdataId) end

function edali_0218:OnEnterArea(selfId, zoneId) end

function edali_0218:OnItemChanged(selfId, itemdataId) end

return edali_0218
