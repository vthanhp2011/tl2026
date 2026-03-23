local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_zhengtianshou = class("osuzhou_zhengtianshou", script_base)
function osuzhou_zhengtianshou:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:AddText("  " .. PlayerName .. PlayerSex .. "，是否是想切磋武艺？那就擂台上请吧！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_zhengtianshou
