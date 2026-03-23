local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zhongzhipai36 = class("oluoyang_zhongzhipai36", script_base)
oluoyang_zhongzhipai36.script_id = 714030
oluoyang_zhongzhipai36.g_eventList = {
    20104001, 20104003, 20104004, 20104006, 20104010, 20104011, 20105001,
    20105002, 20105005, 20105008, 20105011
}
local V_ZHONGZHI_NEEDLEVEL = 
{
1,2,3,4,5,6,7,8,9,10,
11,12,1,2,3,4,5,6,7,8,
9,10,11,12
}
local V_ZHONGZHI_NAME = {
"早产小麦","早产大米","早产玉米","早产花生","早产红薯","早产高粱","早产芝麻","早产绿豆","早产黄豆","早产蚕豆",
"早产马铃薯","早产芋头","早产苎麻","早产草棉","早产亚麻","早产木棉","早产黄麻","早产云棉","早产槿麻","早产绒棉",
"早产青麻","早产彩棉","早产罗布麻","早产陆地棉",
"晚产小麦","晚产大米","晚产玉米","晚产花生","晚产红薯","晚产高粱","晚产芝麻","晚产绿豆","晚产黄豆","晚产蚕豆",
"晚产马铃薯","晚产芋头","晚产苎麻","晚产草棉","晚产亚麻","晚产木棉","晚产黄麻","晚产云棉","晚产槿麻","晚产绒棉",
"晚产青麻","晚产彩棉","晚产罗布麻","晚产陆地棉"
}
function oluoyang_zhongzhipai36:OnDefaultEvent(selfId, targetId)
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
        self:AddText("请选择你要种的植物")
        for i, scriptId in pairs(self.g_eventList) do
            for j, g_ZhiWuId in pairs(define.V_ZHONGZHI_ID) do
                if scriptId == g_ZhiWuId then
                    if AbilityLevel >= V_ZHONGZHI_NEEDLEVEL[j] then
                        self:AddNumText(V_ZHONGZHI_NAME[j], 6, -1)
                        break
                    end
                end
            end
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oluoyang_zhongzhipai36:OnEventRequest(selfId, targetId, arg, index)
    local zhiwuId = self.script_id
    for i, findId in pairs(self.g_eventList) do
        if zhiwuId == findId then
            self:CallScriptFunction(713550, "OnDefaultEvent", selfId, targetId,
                                    zhiwuId)
            return
        end
    end
end

function oluoyang_zhongzhipai36:OnMissionSubmit(selfId, targetId, scriptId)
    for i, findId in pairs(self.g_eventList) do
        if scriptId == findId then
            local ret = self:CallScriptFunction(scriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(scriptId, "OnAccept", selfId,
                                        define.ABILITY_ZHONGZHI)
                self:CallScriptFunction(scriptId, "OnDefaultEvent", selfId,
                                        targetId, define.ABILITY_ZHONGZHI)
            end
            return
        end
    end
end

function oluoyang_zhongzhipai36:OnMissionAccept(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret =
                self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId,
                                        define.ABILITY_ZHONGZHI)
            end
            return
        end
    end
end

return oluoyang_zhongzhipai36
