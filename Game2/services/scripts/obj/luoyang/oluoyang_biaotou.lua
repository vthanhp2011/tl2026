local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_biaotou = class("oluoyang_biaotou", script_base)
function oluoyang_biaotou:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText(
        "  本镖局诚信第一，义薄云天，得黑白两道朋友赏脸，才能保证连续十年不丢镖。" ..
            PlayerName .. PlayerSex ..
            "，有什么需要的您尽管开口，上刀山，下火海，我盖千鸣眼都不眨一下。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_biaotou
