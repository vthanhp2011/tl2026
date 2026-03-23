local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0284 = class("edali_0284", script_base)
edali_0284.script_id = 210284
edali_0284.g_busGuilList = {1000003, 1000004}
function edali_0284:OnDefaultEvent(selfId, targetId)
    local bSucceeded = 0
    local strText = "无可用坐骑，请稍候"
    for _, busGuid in pairs(self.g_busGuilList) do
        local busId = self:LuaFnBusGetObjIDByGUID(busGuid)
        if busId then
            if busId ~= define.INVAILD_ID then
                local ret = self:LuaFnBusAddPassenger_Shuttle(busId, selfId, targetId, 0)
                if ret == define.OPERATE_RESULT.OR_OK then
                    strText = "请稍候，马上起飞"
                    bSucceeded = 1
                    break
                elseif ret == define.OPERATE_RESULT.OR_BUS_PASSENGERFULL then
                    strText = "坐骑已满，请乘坐下一班。"
                    break
                elseif ret == define.OPERATE_RESULT.OR_BUS_HASMOUNT then
                    strText = "您不能在坐骑上执行此操作。"
                    break
                elseif ret == define.OPERATE_RESULT.OR_BUS_HASPET then
                    strText = "您不能在携带有珍兽的时候执行此操作。"
                    break
                elseif ret == define.OPERATE_RESULT.OR_BUS_CANNOT_TEAM_FOLLOW then
                    strText = "您不能在组队跟随时执行此操作。"
                    break
                elseif ret == define.OPERATE_RESULT.OR_BUS_CANNOT_DRIDE then
                    strText = "您不能在双人骑乘时执行此操作。"
                    break
                elseif ret == define.OPERATE_RESULT.OR_BUS_CANNOT_CHANGE_MODEL then
                    strText = "您不能在变身时执行此操作。"
                    break
                end
            end
        end
    end
    self:BeginEvent(self.script_id)
    self:AddText(strText)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
    if bSucceeded == 1 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    end
end

function edali_0284:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, "飞往东门", 9, -1)
end

return edali_0284
