local class = require "class"
local define = require "define"
local script_base = require "script_base"
local wudaoNPC = class("wudaoNPC", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
wudaoNPC.script_id = 992002
wudaoNPC.NpcInfo = {
    ["玄阅"] = {
        "#{TFYD_210729_543}", 0, "罗汉", "#{TFYD_210729_432}", "#{TalentSL_20210804_01}", 0, 23, 1053
    },
    ["玄篱"] = {
        "#{TFYD_210729_542}", 0, "金刚", "#{TFYD_210729_431}", "#{TalentSL_20210804_01}", 1, 34, 1054
    },
    ["林焱"] = {
        "#{TFYD_210729_546}", 1, "血戾", "#{TFYD_210729_433}","#{TalentMJ_20210804_01}", 1, 56, 1056
    },
    ["莫思归"] = {
        "#{TFYD_210729_547}", 1, "天罗", "#{TFYD_210729_434}", "#{TalentMJ_20210804_01}", 0, 45, 1055
    },
    ["路老大"] = {
        "#{TFYD_210729_544}", 2, "行侠", "#{TFYD_210729_435}", "#{TalentGB_20210804_01}", 1, 12, 1058
    },
    ["杜少康"] = {
        "#{TFYD_210729_545}", 2, "酒狂", "#{TFYD_210729_436}", "#{TalentGB_20210804_01}", 0, 1, 1057
    },
    ["碧落散人"] = {
        "#{TFYD_210729_548}", 3, "凭虚", "#{TFYD_210729_437}", "#{TalentWD_20210804_01}", 0, 67, 1059
    },
    ["逐浪散人"] = {
        "#{TFYD_210729_549}", 3, "摘星", "#{TFYD_210729_438}", "#{TalentWD_20210804_01}", 1, 78, 1060
    },
    ["聚落花"] = {
        "#{TFYD_210729_555}", 4, "沁芳", "#{TFYD_210729_439}", "#{TalentEM_20210804_01}", 0, 89, 1061
    },
    ["苏戈"] = {
        "#{TFYD_210729_554}", 4, "清音", "#{TFYD_210729_441}", "#{TalentEM_20210804_01}", 1, 100, 1062
    },
    ["蒿莱子"] = {
        "#{TFYD_210729_556}", 5, "寒冥", "#{TFYD_210729_442}","#{TalentXX_20210804_01}", 0, 111, 1063
    },
    ["莲舟子"] = {
        "#{TFYD_210729_557}", 5, "九厄", "#{TFYD_210729_443}", "#{TalentXX_20210804_01}", 1, 122, 1064
    },
    ["本喜"] = { 
        "#{TFYD_210729_550}", 6, "龙威", "#{TFYD_210729_444}","#{TalentTL_20210804_01}", 0, 133, 1065
    },
    ["本然"] = {
        "#{TFYD_210729_551}", 6, "菩天", "#{TFYD_210729_445}", "#{TalentTL_20210804_01}", 1, 144, 1066
    },
    ["吴淼淼"] = {
        "#{TFYD_210729_559}", 7, "雪隐", "#{TFYD_210729_446}","#{TalentTS_20210804_01}", 1, 166, 1068
    },
    ["吴森森"] = {
        "#{TFYD_210729_558}", 7, "霜凝", "#{TFYD_210729_447}", "#{TalentTS_20210804_01}", 0, 155, 1067
    },
    ["秦烟萝"] = {
        "#{TFYD_210729_553}", 8, "明鬼", "#{TFYD_210729_448}", "#{TalentXY_20210804_01}", 1, 188, 1070
    },
    ["艾凉河"] = {
        "#{TFYD_210729_552}", 8, "逸仙", "#{TFYD_210729_449}", "#{TalentXY_20210804_01}", 0, 177, 1069
    },
    ["嵇聆风"] = {
        "#{TFYD_210729_553}", 10, "晚籁", "#{TFYD_220523_46}", "#{TalentMT_20220621_04}", 0, 379, 1205
    },
    ["嵇扶光"] = {
        "#{TFYD_210729_552}", 10, "昭明", "#{TFYD_220523_47}", "#{TalentMT_20220621_05}", 1, 390, 1206
    },
    ["山人木"] = {
        "#{ERMP_240620_19}", 11, "溯魂", "#{ERMP_240620_19}", "#{TalentER_20240802_04}", 0, 621, 1370
    },
    ["山姥"] = {
        "#{ERMP_240620_20}", 11, "判命", "#{ERMP_240620_20}", "#{TalentER_20240802_05}", 1, 632, 1371
    },
}

function wudaoNPC:OnDefaultEvent(selfId, targetId)
    local mp = self:GetMenPai(selfId)
    local talent_type = self:GetTalentType(selfId)
    local NPCName = self:GetName(targetId)
    if self.NpcInfo[NPCName] == nil then return end
    if self.NpcInfo[NPCName][2] ~= mp then
        self:BeginEvent(self.script_id)
        self:AddText(self.NpcInfo[NPCName][1])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:BeginEvent(self.script_id)
    self:AddText(self.NpcInfo[NPCName][4])
    if talent_type == define.INVAILD_ID then
        self:AddNumText("选择流派·" .. self.NpcInfo[NPCName][3], 6, 1)
    elseif talent_type ~= self.NpcInfo[NPCName][6] then
        self:AddNumText("改换流派·" .. self.NpcInfo[NPCName][3], 6, 3)
    end
    if talent_type == self.NpcInfo[NPCName][6] then
        self:AddNumText("武道修行", 6, 2)
        self:AddNumText("武道重习", 6, 4)
    end
    self:AddNumText("流派预览", 6, 5)
    self:AddNumText("关于武道", 11, 6)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function wudaoNPC:OnEventRequest(selfId, targetId, arg, index)
    local NPCName = self:GetName(targetId)
    local Talent = self:GetTalentType(selfId)
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("    您确定要选择#G" .. self.NpcInfo[NPCName][3] ..
                         "#l武道流派吗？点击确定按钮，直接选择该武道流派。#r    #G小提示：选择武道流派后，您可以使用武道归元令改换武道流派。")
        self:AddNumText("确定", 6, 11)
        self:AddNumText("返回", 6, 100)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 2 then
        if Talent == define.INVAILD_ID then
            self:Tips(selfId, "还未加入武道无法学习")
            return
        end
        self:NotifyTalent(selfId)
    elseif index == 5 then
        local id = self.NpcInfo[NPCName][6] + 1
        self:BeginUICommand()
        self:UICommand_AddInt(self:GetMenPai(selfId))
        self:UICommand_AddInt(id)
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 20210801)
    elseif index == 6 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TalentMP_20210804_65}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 7 then
        self:BeginEvent(self.script_id)
        self:AddText(self.NpcInfo[NPCName][5])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 11 then
        if self:GetLevel(selfId) < 60 then
            self:Tips(selfId, "#{TalentMP_20210804_36}")
            return
        end
        local talent_type = self:GetTalentType(selfId)
        if talent_type ~= define.INVAILD_ID then
            self:Tips(selfId, "#{TalentMP_20210804_32}")
            return
        end
        self:SelectTalentType(selfId, self.NpcInfo[NPCName][6], self.NpcInfo[NPCName][7])
        self:LuaFnAddNewAgname(selfId, self.NpcInfo[NPCName][8])
        self:Tips(selfId, string.format("成功选择%s流派，激活武道系统。", self.NpcInfo[NPCName][3]))
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    elseif index == 3 then
        self:BeginEvent(self.script_id)
        self:AddText("    您确定要改换武道流派为#G" ..
                         self.NpcInfo[NPCName][3] ..
                         "#l吗？点击确定按钮进行更换后，当前已分配武道领悟点数将全部返还至新的武道流派中。#r    #G小提示：消耗武道归元令可改换武道流派，每隔72小时方可改换一次。")
        self:AddNumText("确定", 6, 31)
        self:AddNumText("返回", 6, 100)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 31 then
        if self:GetLevel(selfId) < 60 then
            self:Tips(selfId, "#{TalentMP_20210804_44}")
            return
        end
        local talent_type = self:GetTalentType(selfId)
        if talent_type < 0 then
            self:Tips(selfId, "#{TalentMP_20210804_45}")
            return
        end
        local current_talent_type = self.NpcInfo[NPCName][6]
        if current_talent_type == talent_type then
            self:Tips(selfId, "#{TalentMP_20210804_38}")
            return
        end
        local nHaveItem = self:LuaFnGetAvailableItemCount(selfId, 38002405)
        if nHaveItem < 1 then
            self:Tips(selfId, "#{TalentMP_20210804_47}")
            return
        end
        self:LuaFnDelAvailableItem(selfId, 38002405, 1)
        self:SelectTalentType(selfId, self.NpcInfo[NPCName][6], self.NpcInfo[NPCName][7])
        self:Tips(selfId, string.format("改换%s武道流派成功", self.NpcInfo[NPCName][3]))
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
        self:LuaFnAddNewAgname(selfId, self.NpcInfo[NPCName][8])
    elseif index == 100 then
        self:OnDefaultEvent(selfId, targetId)
    elseif index == 4 then
        self:BeginEvent(self.script_id)
        local cost_point = self:GetTalentCostPoint(selfId)
        local str = self:ContactArgs("#{TalentMP_20210804_52", self.NpcInfo[NPCName][3], cost_point)
        self:AddText(str .. "}")
        self:AddNumText("确定", 6, 41)
        self:AddNumText("返回", 6, 100)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 41 then
        if self:GetLevel(selfId) < 60 then
            self:Tips(selfId, "等级不足60级，无法重习武道。")
            return
        end
        local nIsStudy = self:GetTalentCostPoint(selfId)
        if nIsStudy == 0 then
            self:Tips(selfId, "您尚未分配武道领悟点，无需重习。")
            return
        end
        local nMoneySelf = self:GetMoney(selfId) + self:GetMoneyJZ(selfId)
        if nMoneySelf < 100000 then
            self:Tips(selfId, "交子不足，无法重习武道。")
            return
        end
        self:LuaFnCostMoneyWithPriority(selfId, 100000)
        self:SelectTalentType(selfId, self.NpcInfo[NPCName][6], self.NpcInfo[NPCName][7])
        self:Tips(selfId, "成功返还" .. nIsStudy .. "点武道领悟点数，请重新分配。")
    end
end

function wudaoNPC:GetTalenLevel(selfId, nIndex)
    local nTalent = self:MathCilCompute_In(selfId)
    nIndex = nIndex + 1
    return nTalent[nIndex]
end

function wudaoNPC:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function wudaoNPC:Tips(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function wudaoNPC:ShowPreview(selfId, targetId, index)
    self:BeginUICommand()
    self:UICommand_AddInt(self:GetMenPai(selfId))
    self:UICommand_AddInt(index)
    self:UICommand_AddInt(targetId)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 20210801)
end

function wudaoNPC:Talen(selfId)
    if self:GetLevel(selfId) < 60 then
        self:Tips(selfId, "等级不足60，无法查看武道。")
        return
    end
    local nTalent = self:GetMissionData(selfId, ScriptGlobal.MD_TALENT)
    if nTalent == 0 then
        self:Tips(selfId, "未选择任何武道，无法查看信息。")
        return
    end
    local HasSect = ""
    local lua_table = self:MathCilCompute_In(selfId)
    for i = 1, #(lua_table) do
        HasSect = HasSect .. lua_table[i] .. "|"
    end
    self:BeginUICommand()
    self:UICommand_AddStr(HasSect)
    self:UICommand_AddInt(nTalent)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 20211030)
end

function wudaoNPC:Lua_HasSect(selfId, ID, int)
    for i = 1, ID do
        if ID <= 11 then break end
        ID = ID - 11
    end
    local nTalentData = self:MathCilCompute_In(selfId)
    if nTalentData[ID] >= 1 then return 1 end
    return 0
end

function wudaoNPC:Lua_GetSectTotalLevel(selfId, Index)
    local nTalentData = self:MathCilCompute_In(selfId)
    local ju_shuju = 0
    for i = 1, 10 do ju_shuju = nTalentData[i] + ju_shuju end
    return ju_shuju
end

function wudaoNPC:MutexSectID(selfId, ndetailID, nTalentData)
	if 0 == 0 then return 0 end
    local nTalent = self:GetMissionData(selfId, ScriptGlobal.MD_TALENT)
    local MenPai = self:GetMenPai(selfId)
    local List = self.g_Talent_Studyup_Info[MenPai][nTalent]
    local nInfoTable = {}

    local nIndex = 0
    for i = 2, 5 do
        for j = 1, #(List[i]) do
            if List[i][j] > 0 then
                if List[i][j] == ndetailID then
                    nIndex = i
                    break
                end
            end
        end
    end
    for i, v in pairs(List[nIndex]) do
        if v > 0 and v ~= ndetailID then
            local l = v
            for j = 1, l do if l > 11 then l = l - 11 end end
            if nTalentData[l] > 0 then return 0 end
        end
    end
    return 1
end

function wudaoNPC:AskSectOper(selfId, nIndex, ID)
	if 0 == 0 then return end
    if ID < 1 or ID > 198 then
        self:Tips(selfId, "请选择需要修行的武道。")
        return
    end
    if nIndex == 0 then
        local infodetail = self:TBSearch_Index_EQU("DBC_SECT_INFO", ID)
        local totallevel = self:Lua_GetSectTotalLevel(selfId, 0)
        local ndetailID = ID
        for i = 1, ID do
            if ID <= 11 then break end
            ID = ID - 11
        end
        local nTalentData = self:MathCilCompute_In(selfId)
        if nTalentData[ID] >= infodetail["maxlevel"] then
            self:Tips(selfId,
                      "该武道等级已达上限，无法继续修行。")
            return
        end
        local Mutex = self:MutexSectID(selfId, ndetailID, nTalentData)
        if Mutex == 0 then
            self:Tips(selfId, "不可同时修行。")
            return
        end
        if infodetail["limittype"] > 0 then
            local bhave, level = self:Lua_HasSect(selfId,
                                                  infodetail["limittype"], 0)
            local ju_info = self:TBSearch_Index_EQU("DBC_SECT_INFO",
                                                    infodetail["limittype"])
            if bhave <= 0 or level < infodetail["lparam1"] then
                self:Tips(selfId, string.format("需将%s修行至%s级",
                                              ju_info["szName"],
                                              infodetail["lparam1"]))
                return
            end
        end
        if infodetail["lparam2"] > 0 then
            if infodetail["lparam2"] > totallevel then
                self:Tips(selfId,
                          string.format(
                              "当前%s流派修行等级需达到%s级",
                              infodetail["sectname"], infodetail["lparam2"]))
                return
            end
        end
        local nPoint = self:GetMissionData(selfId, ScriptGlobal.MD_TALENTPOINT)
        local nSectLevel = nTalentData[ID] + 1
        if nPoint < infodetail["m_levelinfo"][nSectLevel]["m_point"] then
            self:Tips(selfId,
                      "剩余武道领悟点数不足，无法继续修行。")
            return
        end
        nTalentData[ID] = nTalentData[ID] + 1
        self:MathCilCompute_Out(selfId, nTalentData)
        self:SetMissionData(selfId, ScriptGlobal.MD_TALENTPOINT, nPoint -
                                infodetail["m_levelinfo"][nSectLevel]["m_point"])
        self:Tips(selfId, "武道修行成功！")
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
        self:Flush_Sect_LevelUp(selfId, ndetailID)
        return
    end
end

function wudaoNPC:MathCilCompute_In(selfId)
    local nFinalData_1 = self:GetMissionData(selfId, 482)
    local nFinalData_2 = self:GetMissionData(selfId, 483)
    local nTab = {}
    local nValue = {1, 10, 100, 1000, 10000, 100000}
    for i = 1, 6 do
        table.insert(nTab, (math.floor(nFinalData_1 / nValue[i]) % 10))
    end
    for i = 1, 5 do
        table.insert(nTab, (math.floor(nFinalData_2 / nValue[i]) % 10))
    end
    nTab[1] = 1
    return nTab
end

function wudaoNPC:MathCilCompute_Out(selfId, nData)
	if 0 == 0 then return end
    local nValue = {1, 10, 100, 1000, 10000, 100000}

    local nFinalData_1, nFinalData_2 = 0, 0
    for i = 1, 6 do nFinalData_1 = nFinalData_1 + nData[i] * nValue[i] end
    for i = 7, 11 do nFinalData_2 = nFinalData_2 + nData[i] * nValue[i - 6] end
    self:SetMissionData(selfId, 482, nFinalData_1)
    self:SetMissionData(selfId, 483, nFinalData_2)
end

function wudaoNPC:LuaFnGetSectInfo(ID)
    local nData = self:TBSearch_Index_EQU1("DBC_SECT_INFO", ID)
end

return wudaoNPC