local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local ezhongzhi_xuanzezhiwu = class("ezhongzhi_xuanzezhiwu", script_base)
ezhongzhi_xuanzezhiwu.script_id = 713550
function ezhongzhi_xuanzezhiwu:OnDefaultEvent(selfId, targetId, zhiwuId)
    local num = 0
    local PlantFlag_X, PlantFlag_Z = self:GetWorldPos(targetId)
    PlantFlag_X = math.floor(PlantFlag_X)
    PlantFlag_Z = math.floor(PlantFlag_Z)
    local sceneId = self:get_scene():get_id()
    for i, findid in pairs(ScriptGlobal.PLANTNPC_ADDRESS) do
        if ((PlantFlag_X == findid["X"]) and (PlantFlag_Z == findid["Z"]) and (sceneId == findid["Scene"])) then
            num = i
            break
        end
    end
    if num == 0 then
        self:BeginEvent(self.script_id)
        self:AddText("水土流失，请爱护大自然！")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if ScriptGlobal.PLANTFLAG[num] ~= 0 then
        self:BeginEvent(self.script_id)
        self:AddText("土地已被种植，请过一会儿再来吧！")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local energy = self:GetHumanEnergy(selfId)
    local level_Index
    if zhiwuId >= #(define.V_ZHONGZHI_ID) then
        level_Index = zhiwuId - #(define.V_ZHONGZHI_NAME) / 2
    else
        level_Index = zhiwuId
    end
    self.g_ZhiWuLevel = define.V_ZHONGZHI_NEEDLEVEL[level_Index]
    local EnergyCost =
        self:CallScriptFunction(
            define.ABILITYLOGIC_ID,
        "CalcEnergyCostCaiJi",
        selfId,
        define.ABILITY_ZHONGZHI,
        self.g_ZhiWuLevel
    )
    if energy < EnergyCost then
        self:BeginEvent(self.script_id)
        self:AddText("你的精力不足!")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local CurrentTime = self:LuaFnGetCurrentTime()
    local MissionData = self:GetMissionData(selfId, ScriptGlobal.MD_ZHONGZHI_TIME)
    local Zhongzhi_Flag = self:GetMissionData(selfId, ScriptGlobal.MD_ZHONGZHI_FLAG)
    local WaitTime
    if
        (Zhongzhi_Flag == 1 and (CurrentTime - MissionData) <= 300) or
            (Zhongzhi_Flag == 2 and (CurrentTime - MissionData) <= 4200)
     then
        if Zhongzhi_Flag == 1 then
            WaitTime = 300 - (CurrentTime - MissionData)
        else
            WaitTime = 4200 - (CurrentTime - MissionData)
        end
        WaitTime = math.floor(WaitTime / 60)
        self:BeginEvent(self.script_id)
        self:AddText("不能连续种植，大约" .. WaitTime .. "分钟后可以再次种植。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:LuaFnAuditAbility(selfId, define.ABILITY_ZHONGZHI, -1, -1)
    self:CallScriptFunction(define.ABILITYLOGIC_ID, "GainExperience", selfId, define.ABILITY_ZHONGZHI, self.g_ZhiWuLevel)
    self:CallScriptFunction(define.ABILITYLOGIC_ID, "EnergyCostZhongZhi", selfId, define.ABILITY_ZHONGZHI, self.g_ZhiWuLevel)
    local ItemBoxTypeId = define.V_ZHONGZHI_ITEMBOX_ID[zhiwuId]
    local ItemBoxId01 = self:ItemBoxEnterScene(PlantFlag_X + 1.5, PlantFlag_Z - 1, ItemBoxTypeId, define.QUALITY_MUST_BE_CHANGE, 0)
    local ItemBoxId02 = self:ItemBoxEnterScene(PlantFlag_X + 1.5, PlantFlag_Z + 2, ItemBoxTypeId, define.QUALITY_MUST_BE_CHANGE, 0)
    local ItemBoxId03 = self:ItemBoxEnterScene(PlantFlag_X - 0.5, PlantFlag_Z - 1, ItemBoxTypeId, define.QUALITY_MUST_BE_CHANGE, 0)
    local ItemBoxId04 = self:ItemBoxEnterScene(PlantFlag_X - 0.5, PlantFlag_Z + 2, ItemBoxTypeId, define.QUALITY_MUST_BE_CHANGE, 0)
    self:SetItemBoxMaxGrowTime(ItemBoxId01, 45000)
    self:SetItemBoxMaxGrowTime(ItemBoxId02, 45000)
    self:SetItemBoxMaxGrowTime(ItemBoxId03, 45000)
    self:SetItemBoxMaxGrowTime(ItemBoxId04, 45000)
    local guid = self:GetHumanGUID(selfId)
    self:SetItemBoxOwner(ItemBoxId01, guid)
    self:SetItemBoxOwner(ItemBoxId02, guid)
    self:SetItemBoxOwner(ItemBoxId03, guid)
    self:SetItemBoxOwner(ItemBoxId04, guid)
    ScriptGlobal.PLANTFLAG[num] = 8
    self:BeginEvent(self.script_id)
    self:AddText("你已经开始种植")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
    self:SetMissionData(selfId, ScriptGlobal.MD_ZHONGZHI_TIME, CurrentTime)
    if zhiwuId >= #(define.V_ZHONGZHI_ID) then
        self:SetMissionData(selfId, ScriptGlobal.MD_ZHONGZHI_FLAG, 2)
    else
        self:SetMissionData(selfId, ScriptGlobal.MD_ZHONGZHI_FLAG, 1)
    end
    return define.OPERATE_RESULT.OR_OK
end

return ezhongzhi_xuanzezhiwu
