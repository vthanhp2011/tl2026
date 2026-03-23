local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_zhongzhipai10 = class("odali_zhongzhipai10", script_base)
odali_zhongzhipai10.script_id = 714066
odali_zhongzhipai10.event_xuanzezhiwu = 713550
odali_zhongzhipai10.g_eventList = {
    20104001,
    20104002,
    20104005,
    20104007,
    20104009,
    20104012,
    20105001,
    20105004,
    20105007,
    20105012
}

function odali_zhongzhipai10:OnDefaultEvent(selfId, targetId)
    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, define.ABILITY_ZHONGZHI)
    if AbilityLevel == 0 then
        self:BeginEvent(self.script_id)
        self:AddText("你先去学习种植技能吧")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if AbilityLevel ~= 0 then
        self:BeginEvent(self.script_id)
        self:AddText("每种作物都可以分为晚产和早产两种，早产的成熟期大概为5分钟，晚产的大概为70分钟左右，但是单次收获较多。您要选择种植哪种作物？")
        self:AddNumText("种植早产植物", 6, 254)
        self:AddNumText("种植晚产植物", 6, 255)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function odali_zhongzhipai10:OnEventRequest(selfId, targetId, arg, index)
    local name_Index
    local NumText = index
    if NumText == 254 or NumText == 255 then
        self:BeginEvent(self.script_id)
        self:AddText("请选择你要种的植物")
        for i, eventId in pairs(self.g_eventList) do
            for j, g_ZhiWuId in pairs(define.V_ZHONGZHI_ID) do
                if eventId == g_ZhiWuId then
                    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, define.ABILITY_ZHONGZHI)
                    if AbilityLevel >= define.V_ZHONGZHI_NEEDLEVEL[j] then
                        if NumText == 254 then
                            name_Index = j
                        else
                            name_Index = j + #(define.V_ZHONGZHI_NAME) / 2
                        end
                        self:AddNumText(
                            define.V_ZHONGZHI_NAME[name_Index] .. "(" .. define.V_ZHONGZHI_NEEDLEVEL[j] .. "级)",
                            6,
                            name_Index
                        )
                        break
                    end
                end
            end
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local zhiwuId = NumText
    for i, findId in pairs(self.g_eventList) do
        if zhiwuId <= #(define.V_ZHONGZHI_NAME) then
            self:CallScriptFunction(713550, "OnDefaultEvent", selfId, targetId, zhiwuId)
            return
        end
    end
end

function odali_zhongzhipai10:OnMissionSubmit(selfId, targetId, scriptId)
    for i, findId in pairs(self.g_eventList) do
        if scriptId == findId then
            local ret = self:CallScriptFunction(scriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(scriptId, "OnAccept", selfId, define.ABILITY_ZHONGZHI)
                self:CallScriptFunction(scriptId, "OnDefaultEvent", selfId, targetId, define.ABILITY_ZHONGZHI)
            end
            return
        end
    end
end

function odali_zhongzhipai10:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId, define.ABILITY_ZHONGZHI)
            end
            return
        end
    end
end

return odali_zhongzhipai10
