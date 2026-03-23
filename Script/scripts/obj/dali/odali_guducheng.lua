local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_guducheng = class("odali_guducheng", script_base)
function odali_guducheng:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText("  " .. PlayerName .. PlayerSex .. "，多日不见了，皇上正在等你呢。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_guducheng
