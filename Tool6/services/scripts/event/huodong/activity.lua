local class = require "class"
local define = require "define"
local script_base = require "script_base"
local activity = class("activity", script_base)
activity.script_id = 808000
function activity:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5)
    self:StartOneActivity(actId, math.floor(60 * 1000), iNoticeType)
end

function activity:OnTimer(actId, uTime)
    if not self:CheckActiviyValidity(actId) then
        self:StopOneActivity(actId)
    end
end

return activity
