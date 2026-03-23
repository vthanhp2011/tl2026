local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_huaxian = class("oluoyang_huaxian", script_base)
function oluoyang_huaxian:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText(
        "  杨柳青青江水平，闻郎江上唱歌声。东边日出西边雨，道是无晴却有晴。" ..
            PlayerName .. PlayerSex ..
            "，可喜欢只羡鸳鸯不羡仙的日子？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_huaxian
