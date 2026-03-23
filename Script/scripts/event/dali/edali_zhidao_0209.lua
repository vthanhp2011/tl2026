local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_zhidao_0209 = class("edali_zhidao_0209", script_base)
edali_zhidao_0209.script_id = 210209
edali_zhidao_0209.g_XinShouJiNeng = 
{
    {["name"] = "慧易", ["skill"] = "学习外功护体",["menpainame"] = "少林派",["strdesc"] = "少林古刹"},
    {["name"] = "石宝", ["skill"] = "学习奋力打击",["menpainame"] = "明教",["strdesc"] = "大光明殿"},
    {["name"] = "简宁", ["skill"] = "学习要害攻击",["menpainame"] = "丐帮",["strdesc"] = "丐帮总舵"},
    {["name"] = "张获", ["skill"] = "学习内劲攻击",["menpainame"] = "武当派",["strdesc"] = "武当仙风"},
    {["name"] = "路三娘", ["skill"] = "学习初级治疗",["menpainame"] = "峨眉派",["strdesc"] = "峨嵋天下秀"},
    {["name"] = "海风子", ["skill"] = "学习内功护体",["menpainame"] = "星宿派",["strdesc"] = "星宿春秋"},
    {["name"] = "破贪", ["skill"] = "学习破绽攻击",["menpainame"] = "天龙派",["strdesc"] = "天龙风情"},
    {["name"] = "程青霜", ["skill"] = "学习初级隐遁",["menpainame"] = "天山派",["strdesc"] = "缥缈天山"},
    {["name"] = "澹台子羽", ["skill"] = "学习燃烧陷阱",["menpainame"] = "逍遥派",["strdesc"] = "凌波逍遥"},
    {["name"] = "王溪云", ["skill"] = "学习命魂护体",["menpainame"] = "曼陀山庄",["strdesc"] = "曼陀山庄"},
    {["name"] = "山风", ["skill"] = "学习锻骨强体",["menpainame"] = "恶人谷",["strdesc"] = "幽川恶人谷"},
}
edali_zhidao_0209.g_XinShouSkillData = {241,242,243,244,245,246,247,248,249,277,140}
function edali_zhidao_0209:OnDefaultEvent(selfId, targetId)
    self:OnContinue(selfId, targetId)
end

function edali_zhidao_0209:OnEnumerate(caller, selfId, targetId, arg, index)
    local nIndex = 0
    for i,Skill in pairs(self.g_XinShouJiNeng) do
        if self:GetName(targetId) == Skill["name"] then
            nIndex = i
        end
    end
    if nIndex > 0 then
        if self:GetLevel(selfId) >= 10 and self:GetMenPai(selfId) == 9 then
            caller:AddNumTextWithTarget(self.script_id,"#G我想加入"..self.g_XinShouJiNeng[nIndex]["menpainame"], 6, 14)
        end
        if not self:HaveSkill(selfId,self.g_XinShouSkillData[nIndex]) then
            caller:AddNumTextWithTarget(self.script_id,self.g_XinShouJiNeng[nIndex]["skill"], 6, -1)
        end
        caller:AddNumTextWithTarget(self.script_id,self.g_XinShouJiNeng[nIndex]["menpainame"].."来由", 11, 10)
        caller:AddNumTextWithTarget(self.script_id,self.g_XinShouJiNeng[nIndex]["menpainame"].."战斗特色", 11, 11)
        caller:AddNumTextWithTarget(self.script_id,self.g_XinShouJiNeng[nIndex]["menpainame"].."生活特色", 11, 12)
        caller:AddNumTextWithTarget(self.script_id,self.g_XinShouJiNeng[nIndex]["strdesc"], 11, 13)
    end
end

function edali_zhidao_0209:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{XSRW_100111_106}")
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id,-1)
end

function edali_zhidao_0209:OnSubmit(selfId, targetId)
    local nIndex = 0
    for i,Skill in pairs(self.g_XinShouJiNeng) do
        if self:GetName(targetId) == Skill["name"] then
            nIndex = i
        end
    end
    if nIndex > 0 then
        if self:HaveSkill(selfId,self.g_XinShouSkillData[nIndex]) then 
            return 
        end
        if nIndex == 4 then
			if self:IsHaveMission(selfId,1405) then
				local misIndex = self:GetMissionIndexByID(selfId,1405)
				if self:GetMissionParam(selfId,misIndex,1) < 1 then
					self:SetMissionByIndex(selfId,misIndex,1,1)
                    self:notify_tips(selfId,"在武当派接引道长处学习内劲攻击：1/1")
                    if self:GetMissionParam(selfId,misIndex,1) == 1 and self:GetMissionParam(selfId,misIndex,2) == 1 then
                        self:SetMissionByIndex(selfId,misIndex,0,1) --设置完成任务
                        self:notify_tips(selfId,"")
                    end
				end
			end
        elseif nIndex == 8 then
			if self:IsHaveMission(selfId,1405) then
				local misIndex = self:GetMissionIndexByID(selfId,1405)
				if self:GetMissionParam(selfId,misIndex,2) < 1 then
					self:SetMissionByIndex(selfId,misIndex,2,1)
                    self:notify_tips(selfId,"在天山派接引使处学习初级隐遁：1/1")
                    if self:GetMissionParam(selfId,misIndex,1) == 1 and self:GetMissionParam(selfId,misIndex,2) == 1 then
                        self:SetMissionByIndex(selfId,misIndex,0,1) --设置完成任务
                    end
				end
			end
        end
        self:AddSkill(selfId,self.g_XinShouSkillData[nIndex])
        self:notify_tips(selfId,"你学习到新的技能："..self.g_XinShouJiNeng[nIndex]["menpainame"].."新手技能："..string.sub(self.g_XinShouJiNeng[nIndex]["skill"],7,18))
        self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
    end
end

function edali_zhidao_0209:OnKillObject(selfId, objdataId) end

function edali_zhidao_0209:OnEnterZone(selfId, zoneId) end

function edali_zhidao_0209:OnItemChanged(selfId, itemdataId) end

return edali_zhidao_0209
