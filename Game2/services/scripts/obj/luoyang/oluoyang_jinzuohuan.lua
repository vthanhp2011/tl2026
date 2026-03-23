local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_jinzuohuan = class("oluoyang_jinzuohuan", script_base)
function oluoyang_jinzuohuan:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText(
        "  谁说我们高丽国进贡的国礼丢了，胡说，根本没有的事情。" ..
            PlayerName .. PlayerSex ..
            "，要是再听见有人胡言乱语就带他来见我，我倒要好好问问他哪只眼睛看见国礼丢了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_jinzuohuan
