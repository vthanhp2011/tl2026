local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local eprize = class("eprize", script_base)
eprize.script_id = 888899
--此处的比例配置废弃  改这里配置 ScriptGlobal.MD_CHANGE_YUANBAO_OLD_RATE  ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
-- eprize.duihuanrate = 2000				--兑换比例  1点数需求多少元宝
eprize.rmb_rate = 1				--游戏记录用 1元 = 多少点数  单位:点数



eprize.menpaititle =
{
    1096,1108,1117,1099,1102,1105,1111,1120,1114,-1,1219,1362,
}
eprize.menpaititletxt =
{
    "少林第一人","明教第一人","丐帮第一人","武当第一人","峨嵋第一人","星宿第一人","天龙第一人","天山第一人","逍遥第一人","","曼陀山庄第一人","恶人谷第一人"
}
function eprize:GetYuanBaoRate(selfId)
	-- local serverId = self:LuaFnGetServerID(selfId)
	-- local point_rate = ScriptGlobal.MD_SERVER_ID[serverId] and ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE or ScriptGlobal.MD_CHANGE_YUANBAO_OLD_RATE
	-- return point_rate
	return ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
end
function eprize:AskPoint(selfId)
    -- local point = self:GetTopUpPoint(selfId) * 10
    -- self:NotifyLeftPoint(selfId, point)
    self:NotifyLeftPoint(selfId, 0)
end

function eprize:NotifyLeftPoint(selfId, nLeftPoint)
    local point = self:GetTopUpPoint(selfId)
	-- local serverId = self:LuaFnGetServerID(selfId)
	-- local point_rate = ScriptGlobal.MD_SERVER_ID[serverId] and ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE or ScriptGlobal.MD_CHANGE_YUANBAO_OLD_RATE
    self:BeginUICommand()
    self:UICommand_AddInt(point)
    self:UICommand_AddInt(ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 2003)
end

function eprize:BuyYuanBao(selfId, point, rate)
    local human = self:get_scene():get_obj_by_id(selfId)
	if not human then
		return
	end
    local result = self:CostTopUpPoint(selfId, point)
    if not result then
        self:notify_tips(selfId, "点数不足")
        return
    end
	local addyuanbao = point * ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
	human:add_yuanbao(addyuanbao,"兑换点数:"..tostring(point))
	self:notify_tips(selfId, "您成功的兑换了" .. addyuanbao .. "点元宝。")
	local acme_havepoint = self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW)
	self:SetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW, acme_havepoint + addyuanbao)
	-- local serverId = self:LuaFnGetServerID(selfId)
	-- if ScriptGlobal.MD_SERVER_ID[serverId] then
		-- local addyuanbao = point * ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
		-- human:add_yuanbao(addyuanbao,"兑换点数:"..tostring(point))
		-- self:notify_tips(selfId, "您成功的兑换了" .. addyuanbao .. "点元宝。")
		-- local acme_havepoint = self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW)
		-- self:SetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW, acme_havepoint + addyuanbao)
	-- else
		-- local addyuanbao = point * ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
		-- human:add_yuanbao(addyuanbao,"兑换点数:"..tostring(point))
		-- self:notify_tips(selfId, "您成功的兑换了" .. addyuanbao .. "点元宝。")
		-- local acme_havepoint = self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_OLD)
		-- self:SetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_OLD, acme_havepoint + addyuanbao)
	-- end
	local RMBPoint = math.ceil(point / self.rmb_rate)
	self:CallScriptFunction(888817,"ResetPayReward",selfId,RMBPoint,666666,888888)		--666666,888888 此两值不要改动
	self:AddPayTitle(selfId)
	self:UpdateMingDongTop(selfId,nil,point)
end
function eprize:UpdateRechargeMenPaiTitle(selfId,oldmp)
    local menpai = self:GetMenPai(selfId)
	if not menpai or menpai < 0 then return end
	menpai = menpai + 1
    local HaveYuanBao = self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_OLD) / ScriptGlobal.MD_CHANGE_YUANBAO_OLD_RATE
    HaveYuanBao = HaveYuanBao + self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW) / ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
	--if HaveYuanBao >= 1000 then
		--self:LuaFnAddNewAgname(selfId, self.menpaititle[menpai])			--不用删除，因为这几些称号都是同互斥的，给予时会先删掉再给新的
		--self:notify_tips(selfId,string.format("获得称号：%s",self.menpaititletxt[menpai]))
    --end
	-- id = -1 , update = nil or false   刷新称号到客户端
	-- self:LuaFnDelNewAgname(selfId,-1)
end
function eprize:AddPayTitle(selfId)
    local HaveYuanBao = self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_OLD) / ScriptGlobal.MD_CHANGE_YUANBAO_OLD_RATE
    HaveYuanBao = HaveYuanBao + self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW) / ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
	
	local menpai = self:GetMenPai(selfId)
	local sex = self:LuaFnGetSex(selfId)
	if not menpai or menpai < 0 then return end
	menpai = menpai + 1
    local sex = self:LuaFnGetSex(selfId)
	--新称号表的  Class 列为互斥ID  同类互斥的用  elseif 从大往小进行即可
	--LuaFnAddNewAgname  给予时会遍历称号 有没有存在同互斥的，有则先删再给   可以不用检测是否拥有
	--LuaFnAddNewAgname  参数3   == true 时则先不刷新到客户端    == false or nil 时则立马刷新到客户端  因为还在继续检测给予 ，最后再给个false  一起刷新客户端即可
	if HaveYuanBao >= 1000 then
        if not self:LuaFnHaveAgname(selfId, 1286) then
            self:LuaFnAddNewAgname(selfId, 1286,true)
        end
    end
	if HaveYuanBao >= 3000 then
        if not self:LuaFnHaveAgname(selfId, 1361) then
            self:LuaFnAddNewAgname(selfId, 1361,true)
        end
    end
    if HaveYuanBao >= 5000 then
        if not self:LuaFnHaveAgname(selfId, 1366) then
            self:LuaFnAddNewAgname(selfId, 1366,true)
        end
    end
	if HaveYuanBao >= 10000 then
        --if not self:LuaFnHaveAgname(selfId, self.menpaititle[menpai]) then
        --    self:LuaFnAddNewAgname(selfId, self.menpaititle[menpai])
		--end
		--if self:GetMissionDataEx(selfId,ScriptGlobal.MD_TUIGUANG) ~= 1 then
			--self:SetHumanGameFlag(selfId,"un_limit_change",1)
			--self:SetHumanGameFlag(selfId,"limit_change",0)
			--self:SetMissionDataEx(selfId,ScriptGlobal.MD_TUIGUANG,1)
		--end
        if not self:LuaFnHaveAgname(selfId, 1392) then
            self:LuaFnAddNewAgname(selfId, 1392,true)
		end
    end
	
	if HaveYuanBao >= 20000 then
        if not self:LuaFnHaveAgname(selfId, 1281) then
            self:LuaFnAddNewAgname(selfId, 1281,true)
		end
    end
	if HaveYuanBao >= 30000 then
        if not self:LuaFnHaveAgname(selfId, 1288) then
            self:LuaFnAddNewAgname(selfId, 1288,true)
		end
		--if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50102) then
			self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50102, 100)
		--end
    end
	if HaveYuanBao >= 50000 then
        if not self:LuaFnHaveAgname(selfId, 1316) then
            self:LuaFnAddNewAgname(selfId, 1316,true)
		end
		--if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50112) then
			self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50112, 100)
		--end
    end
	if HaveYuanBao >= 100000 then
        if not self:LuaFnHaveAgname(selfId, 1387) then
            self:LuaFnAddNewAgname(selfId, 1387,true)
		end
		--if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50106) then
			self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50106, 100)
		--end
    end
	if HaveYuanBao >= 200000 then
        if not self:LuaFnHaveAgname(selfId, 1386) then
            self:LuaFnAddNewAgname(selfId, 1386,true)
		end
		--if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50116) then
			self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50116, 100)
		--end
    end
	if HaveYuanBao >= 250000 then
        if not self:LuaFnHaveAgname(selfId, 1385) then
            self:LuaFnAddNewAgname(selfId, 1385,true)
		end
    end
	if HaveYuanBao >= 300000 then
		if not self:LuaFnHaveAgname(selfId, 1240) then
            self:LuaFnAddNewAgname(selfId, 1240,true)
		end
		--if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50116) then
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50118, 100)
		--end
    end
	if HaveYuanBao >= 350000 then
		--if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50116) then
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50109, 100)
		--end
    end
	if HaveYuanBao >= 400000 then
        if not self:LuaFnHaveAgname(selfId, 1216) then
            self:LuaFnAddNewAgname(selfId, 1216,true)
		end
    end
	if HaveYuanBao >= 500000 then
        if not self:LuaFnHaveAgname(selfId, 1217) then
            self:LuaFnAddNewAgname(selfId, 1217,true)
		end
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50119, 100)
    end
    --[[if HaveYuanBao >= 10000 then
        if sex == 0 then
            if not self:LuaFnHaveAgname(selfId, 1249) then
                self:LuaFnAddNewAgname(selfId, 1249)
            end
        else
            if not self:LuaFnHaveAgname(selfId, 1248) then
                self:LuaFnAddNewAgname(selfId, 1248)
            end
        end
    end
    if HaveYuanBao >= 20000 then
        if not self:LuaFnHaveAgname(selfId, 1218) then
            self:LuaFnAddNewAgname(selfId, 1218,true)
        end
    end
    if HaveYuanBao >= 30000 then
        if not self:LuaFnHaveAgname(selfId, 1217) then
            self:LuaFnAddNewAgname(selfId, 1217,true)
        end
    end
    if HaveYuanBao >= 50000 then
        if not self:LuaFnHaveAgname(selfId, 1216) then
            self:LuaFnAddNewAgname(selfId, 1216,true)
        end
    end--]]
	-- id = -1 , update = nil or false   刷新称号到客户端
	self:LuaFnAddNewAgname(selfId, -1)
end

return eprize