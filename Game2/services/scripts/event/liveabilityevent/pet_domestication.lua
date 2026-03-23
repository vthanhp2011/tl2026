local class = require "class"
local define = require "define"
local script_base = require "script_base"
local pet_domestication = class("pet_domestication", script_base)
pet_domestication.script_id = 701603
function pet_domestication:OnDefaultEvent(selfId, targetId,ButtomNum)
    local PetNum = self:LuaFnGetPetCount(selfId) 
    if PetNum <= 0 then
        local NpcName = self:GetName(targetId)
        self:BeginEvent(self.script_id)
        self:AddText("  <" .. NpcName .. "从头到脚仔细打量了你，向左看了看，又向右看了看，然后向你身后看了看，眯起眼对你说>#r  你哪里有带珍兽来？")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local ObjId = self:FightingPet(selfId)
    local MoneyCost = 0
    for i = 1, PetNum,1 do
        MoneyCost = MoneyCost + self:CalcMoney_hp(selfId, i)
    end
    if MoneyCost == 0 then
        self:BeginEvent(self.script_id)
        self:AddText("  你的珍兽很健康，不需要治疗。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        if ObjId then
            self:LuaFnDispelAllHostileImpacts(ObjId)
        end
        return
    end
    local Pet_MaxHP
    local PetID_H, PetID_L
    if ButtomNum == 40 then
        self:BeginEvent(self.script_id)
        self:AddText("  你需要花费#G#{_EXCHG" .. MoneyCost .. "}#W，确定要给珍兽恢复么？")
        self:AddNumText("好的", 6, 41)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif ButtomNum == 41 then
        local nMoneyJZ = self:GetMoneyJZ(selfId)
        local nMoney = self:GetMoney(selfId)
        if (nMoneyJZ + nMoney >= MoneyCost) then
            local ret, moneyJZ, money = self:LuaFnCostMoneyWithPriority(selfId, MoneyCost)
            for i = 1, PetNum,1 do
				Pet_MaxHP = self:LuaFnGetPet_MaxHP( selfId, i )

				--根据珍兽index得到珍兽guid
				PetID_H, PetID_L = self:LuaFnGetPetGUID( selfId, i )
				--提升HP
				self:LuaFnSetPetHP(selfId, PetID_H, PetID_L, Pet_MaxHP )
            end
            if ObjId >= 0 then
                self:LuaFnDispelAllHostileImpacts(ObjId)
            end
            if (moneyJZ == MoneyCost) then
                self:BeginEvent(self.script_id)
                self:AddText("  你花费了#G#{_EXCHG" .. moneyJZ .. "}#W，你的珍兽都恢复好了。")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
            elseif (moneyJZ > 0) and (moneyJZ + money) == MoneyCost then
                self:BeginEvent(self.script_id)
                self:AddText("  你花费了#G#{_EXCHG" .. moneyJZ .. "}#W，")
                self:AddText("  你花费了#G#{_MONEY" .. money .. "}#W。")
                self:AddText("  你的珍兽都恢复好了。")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
            elseif (moneyJZ == 0) and (money == MoneyCost) then
                self:BeginEvent(self.script_id)
                self:AddText("  你花费了#G#{_MONEY" .. money .. "}#W，你的珍兽都恢复好了。")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
            else
                self:BeginEvent(self.script_id)
                self:AddText("  恢复失败。")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
            end
        else
            self:BeginEvent(self.script_id)
            self:AddText("  你的金钱不足！")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
    end
end

function pet_domestication:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "给珍兽恢复气血", 6, 40)
end

function pet_domestication:CheckAccept(selfId)
end

function pet_domestication:OnAccept(selfId, ABILITY_CAIKUANG)
end

function pet_domestication:CalcMoney_hp(selfId, index)
    local lv = self:LuaFnGetPet_Level(selfId, index)
    local hp = self:LuaFnGetPet_HP(selfId, index)
    local hp_max = self:LuaFnGetPet_MaxHP(selfId, index)
    if hp >= hp_max then
        return 0
    end
    local gld = math.floor((0.025 + lv * 0.0005) * (hp_max - hp))
    if gld < 1 then
        gld = 1
    end
    return gld
end

function pet_domestication:FightingPet(selfId)
    local PetNum = self:LuaFnGetPetCount(selfId)
    local PetID_H, PetID_L
    local objId
    if PetNum <= 0 then
        return -1
    end
	for i=1, PetNum, 1 do
		PetID_H, PetID_L = self:LuaFnGetPetGUID( selfId, i )
		objId = self:LuaFnGetPetObjIdByGUID( selfId, PetID_H, PetID_L)
		if objId then
			return objId
		end
	end
    return -1
end

return pet_domestication
