local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_yangshi = class("oluoyang_yangshi", script_base)
function oluoyang_yangshi:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText("  " .. PlayerName .. PlayerSex ..
                     "，你也是来拜见老师的吗？我和师兄专程来看望他老人家，不等到老师我们就一直不走。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_yangshi
