local class = require "class"
local define = require "define"
local script_base = require "script_base"
local event_fenghuangEndNotice = class("event_fenghuangEndNotice", script_base)

event_fenghuangEndNotice.script_id = 403011

function event_fenghuangEndNotice:OnTimer(actId, uTime)
    if self:CheckActiviyValidity(actId) == 0 then
        self:StopOneActivity(actId)
    end
end

function event_fenghuangEndNotice:OnDefaultEvent(actId, param1, param2, param3, param4, param5)
    local nFlag = -1
    for i = 0, 7 do
        if self:LuaFnGetCopySceneData_Param(i) + self:LuaFnGetCopySceneData_Param(i + 22) < 10000 then
            nFlag = 1
        end
    end
    if nFlag ~= -1 then
        self:AddGlobalCountNews("#{FHZD_090708_71}")
    end
    if self:LuaFnGetCopySceneData_Param(21) > 0 then
        self:LuaFnSetCopySceneData_Param(21, 0)
    end
    self:StartOneActivity(actId, 60 * 1000, param1)
end

return event_fenghuangEndNotice
