local class = require "class"
local define = require "define"
local script_base = require "script_base"
local echuansong_muxue = class("echuansong_muxue", script_base)

function echuansong_muxue:OnEnterArea(selfId) self:NewWorld(selfId, 2, nil, 160, 150) end

function echuansong_muxue:OnTimer(selfId)
    local StandingTime = self:QueryAreaStandingTime(selfId)
    if StandingTime >= 5000 then
        self:OnEnterArea(selfId)
        self:ResetAreaStandingTime(selfId, 0)
    end
end

function echuansong_muxue:OnLeaveArea(selfId) end

return echuansong_muxue
