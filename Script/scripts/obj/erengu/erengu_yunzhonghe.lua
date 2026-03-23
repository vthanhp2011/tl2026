local class = require "class"
local define = require "define"
local script_base = require "script_base"
local erengu_yunzhonghe = class("erengu_yunzhonghe", script_base)
erengu_yunzhonghe.script_id = 018038
function erengu_yunzhonghe:OnDefaultEvent(selfId, targetId)
    local nMenPai = self:GetMenPai(selfId)
    self:BeginEvent(self.script_id)
    if nMenPai == 11 then
		self:AddText("#{ERMP_240620_04}")
		self:AddNumText("#{ERMP_240620_131}", 12, 0)
	else
		self:AddText("#{ERMP_240620_26}")
    end

    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function erengu_yunzhonghe:OnEventRequest(selfId, targetId, arg, index)
    local nIndex = index
    local nMenPai = self:GetMenPai(selfId)
    if nIndex == 0 then
        if self:HaveSkill(selfId, 111) then
            self:MsgBox(selfId, targetId, "你不是已经学会了吗？")
            return
        end
        if nMenPai ~= 11 then
            self:MsgBox(selfId, targetId, "#{XMPSH_220628_4}")
            return
        end
        if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < 100 then
            self:MsgBox(selfId, targetId, "   少侠，所携带金钱不足，无法学习本门派轻功。")
            return
        end
        self:LuaFnCostMoneyWithPriority(selfId, 100)
        self:AddSkill(selfId, 111)
        self:DelSkill(selfId, 34)
        self:MsgBox(selfId, targetId, "    少侠已成功学会#Y恶人谷轻功#W，恭喜少侠！")
    end
end

function erengu_yunzhonghe:MsgBox(selfId, targetId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return erengu_yunzhonghe
