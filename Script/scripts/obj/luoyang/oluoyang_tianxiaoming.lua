local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_tianxiaoming = class("oluoyang_tianxiaoming", script_base)
oluoyang_tianxiaoming.script_id = 000104
oluoyang_tianxiaoming.g_Key = {["stu"] = 100, ["buy"] = 101}

oluoyang_tianxiaoming.g_Skill = {
    {["id"] = 446, ["name"] = "骑术：陆行雕"}
}

function oluoyang_tianxiaoming:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  如果你是九大门派的弟子，就可以找门派里的骑乘技能传授人学习骑术。")
    self:AddNumText("购买骑乘", 7, self.g_Key["buy"])
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_tianxiaoming:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    if key == 0 then
        self:AddSkill(selfId, 21)
        self:MsgBox(selfId, targetId,
                    "  你现在已经学会骑乘技能了。")
    elseif key == self.g_Key["buy"] then
        self:DispatchShopItem(selfId, targetId, 138)
    end
end

function oluoyang_tianxiaoming:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_tianxiaoming
