--洛阳NPC
--神医
--普通

local class = require "class"
local script_base = require "script_base"
local oluoyang_longbatian = class("oluoyang_longbatian", script_base)
oluoyang_longbatian.eventlist = {701603}
function oluoyang_longbatian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
        self:AddText(" #{OBJ_luoyang_BaTian}")
        self:AddNumText("传送到-天外-长春-不老殿", 9, 5000)
        self:AddNumText("传送到-天外-秦皇地宫", 9, 5002)
        --self:AddNumText("#{SJBW_130823_49}", 6, 10)
        self:AddNumText("满怒治疗", 6, 0)
        self:AddNumText("前往藏经阁校场", 9, 5001)
        self:AddNumText("关于擂台", 11, 999)
        self:AddNumText("#{TFXC_20220921_02}", 11, 5003)
        self:CallScriptFunction( 701603, "OnEnumerate", self,selfId, targetId)
    self:EndEvent()
    self:DispatchEventList(selfId,targetId)
end

function oluoyang_longbatian:OnEventRequest(selfId, targetId, arg, index)
    if index == 5000 then
        if self:GetLevel(selfId) < 85 then
            self:BeginEvent(self.script_id)
            self:AddText("您的等级过低，85级以后才能前往不老殿")
            self:EndEvent()
            self:DispatchEventList(selfId,targetId)
            return
        end
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1297, 40, 174)
        return
    end
    if index == 5001 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1298, 95, 95)
        return
    end
    if index == 5003 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TFXC_20220921_11}")
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
        return
    end
    if index == 5002 then
        self:BeginEvent(self.script_id)
        self:AddNumText("传送到-西北", 9, 6001)
        self:AddNumText("传送到-东北", 9, 6002)
        self:AddNumText("传送到-中部", 9, 6003)
        self:AddNumText("传送到-西南", 9, 6004)
        self:AddNumText("传送到-东南", 9, 6005)
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
        return
    end
    if index == 6001 then
        if self:CallDestSceneFunction(1299, 3000003, "IsClose") then
            self:BeginEvent(self.script_id)
            self:AddText("地宫四层关闭中，周末开放")
            self:EndEvent()
            self:DispatchEventList(selfId,targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 1299, 34, 37)
        end
        return
    end
    if index == 6002 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1299, 214, 87)
        return
    end
    if index == 6003 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1299, 89, 127)
        return
    end
    if index == 6004 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1299, 80, 205)
        return
    end
    if index == 6005 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1299, 209, 166)
        return
    end
    local gld = math.floor(self:CallScriptFunction(64, "CalcMoney_hpmp", selfId, targetId )* 0.01)
    if index == 0 then
		if self:GetHp(selfId ) == self:GetMaxHp(selfId ) and
            self:GetRage(selfId ) == self:GetMaxRage(selfId ) and
            self:GetMp(selfId ) == self:GetMaxMp(selfId ) then
                self:BeginEvent(self.script_id)
                    self:AddText("  你现在很健康，不需要治疗！")
                self:EndEvent()
                self:DispatchEventList(selfId,targetId)
                return
        end
        if gld <= 0 then
            self:CallScriptFunction(64, "Restore_hpmp", selfId, targetId)
        else
            self:BeginEvent( targetId )
                self:AddText("  你可以花费#G#{_EXCHG"..gld.."}#W，来恢复气血和怒气，确定要治疗吗？" )
                self:AddNumText("是", -1, 1001 )
                self:AddNumText("否", -1, 1000 )
            self:EndEvent()
            self:DispatchEventList(selfId, targetId )
        end
    else
        self:CallScriptFunction( 701603, "OnDefaultEvent", selfId, targetId, index)
    end
    if index == 1001 then	--确认要治疗
		-- 调用“江湖游医”脚本中计算金钱的函数
		-- 得到交子和金钱数目
		local nMoneyJZ = self:GetMoneyJZ (selfId )
		local nMoney = self:GetMoney (selfId )

		--检查玩家是否有足够的现金
		if (nMoneyJZ + nMoney >= gld) then
			--扣钱
			self:LuaFnCostMoneyWithPriority (selfId, gld)
			-- 调用“江湖游医”脚本
			self:CallScriptFunction(64, "Restore_hpmp", selfId, targetId )
			return
		else
			self:BeginEvent( targetId )
				self:AddText("  你的金钱不足！" )
			self:EndEvent()
			self:DispatchMissionTips(selfId )
		end
	end
end

return oluoyang_longbatian