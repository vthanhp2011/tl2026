local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odunhuang_wangyan = class("odunhuang_wangyan", script_base)
odunhuang_wangyan.script_id = 008112
odunhuang_wangyan.g_Transport = 400900
odunhuang_wangyan.g_Impact_Transport_Mission = 113
function odunhuang_wangyan:OnDefaultEvent(selfId, targetId)
    local nam = self:GetName(selfId)
    self:BeginEvent(self.script_id)
    self:AddText(nam ..  "，一入阳关大漠飞沙，再往西去，就是火焰山了!途经火焰山能够到达高昌古国等地方。这一路凶险异常，只有#G90级以上#W的英雄才有资格前去冒险。")
    self:AddNumText("传送去火焰山", 9, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odunhuang_wangyan:OnEventRequest(selfId, targetId, arg, index)
    if self:GetLevel(selfId) < 90 then
        self:BeginEvent(self.script_id)
        self:AddText("  此去一路凶险异常，而你的等级尚不足90级，为了你的安全着想，锻炼时日再来找我吧。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    else
        local haveImpact = self:LuaFnHaveImpactOfSpecificDataIndex(selfId, self.g_Impact_Transport_Mission)
        if haveImpact then
            self:BeginEvent(self.script_id)
            self:AddText("#{Transfer_090304_1}")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        self:CallScriptFunction((self.g_Transport), "TransferFunc", selfId, 423,   223, 29, 90, 1000)
    end
end

return odunhuang_wangyan
