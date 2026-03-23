local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_chuwanli = class("odali_chuwanli", script_base)
function odali_chuwanli:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText(
        "  想练就一身好的武功，和我们一样成为皇家护卫吗？" .. PlayerName .. PlayerSex .. "，你可以拜入九大门派，玉华坛就有九大门派的指引人，你去各大门派去看看，没准会有意外的收获呢。"
    )
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_chuwanli
