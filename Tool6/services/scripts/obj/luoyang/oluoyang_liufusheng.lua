local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_liufusheng = class("oluoyang_liufusheng", script_base)
function oluoyang_liufusheng:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText("  放心，" .. PlayerName .. PlayerSex ..
                     "，我一定会尽力参加比赛的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_liufusheng
