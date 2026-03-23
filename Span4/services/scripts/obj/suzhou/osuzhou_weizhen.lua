local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_weizhen = class("osuzhou_weizhen", script_base)
function osuzhou_weizhen:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:AddText("    " .. PlayerName .. PlayerSex .. "，梅花桩上比试才见功夫。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_weizhen
