local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_zhufugui = class("odali_zhufugui", script_base)
odali_zhufugui.script_id = 002102
odali_zhufugui.g_Type = {"初级", "中级", "高级"}

odali_zhufugui.g_MaxValueByInedx_New = {
    [1] = {2, 2, 40, 40, 4, 2, 3, 2},
    [2] = {2, 2, 2, 40, 4, 3, 40, 3},
    [3] = {1, 1, 1, 1, 1, 40, 1, 3}
}

odali_zhufugui.g_Salary_Num = {[1] = 2000, [2] = 2400, [3] = 3500}

odali_zhufugui.g_Salary_Name = {
    [1] = "珍珑棋局",
    [2] = "一个都不能跑",
    [3] = "师门任务",
    [4] = "勇闯天劫楼",
    [5] = "幸运快活三",
    [6] = "挖藏宝图",
    [7] = "贼兵入侵",
    [8] = "一千零一个愿望",
    [9] = "楼兰寻宝",
    [10] = "黄金之链",
    [11] = "初战缥缈峰",
    [12] = "讨伐燕子坞",
    [13] = "杀星"
}

odali_zhufugui.g_Salary_Type = {
    [1] = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6, [7] = 7, [8] = 8},
    [2] = {[1] = 9, [2] = 10, [3] = 11, [4] = 4, [5] = 12, [6] = 13, [7] = 3, [8] = 7},
    [3] = {[1] = 9, [2] = 10, [3] = 11, [4] = 1, [5] = 12, [6] = 3, [7] = 13, [8] = 7}
}

function odali_zhufugui:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{GZGZ_120514_03}")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_zhufugui:OnEventRequest(selfId, targetId, arg, index)
    local myLevel = self:GetLevel(selfId)
    if myLevel < 35 then
        self:NotifyTip(selfId, "对不起，您的等级不足35级，尚无法领取工资任务！")
        return
    end
    if index == 2 then
        self:OpenSalaryLayout(selfId)
    end
    if index == 3 then
        self:NotifyTip(selfId, "工资任务每晚12点自动结算。")
    end
end

function odali_zhufugui:AddSalary(selfId, nIndex, nType)
end

function odali_zhufugui:PayLastSlay_Auto(selfId)
end

function odali_zhufugui:PayLastSlay_NPC(selfId)
end

function odali_zhufugui:OpenSalaryLayout(selfId)
end

function odali_zhufugui:PayLastSlay(selfId, nSLevel, SalyData, nYuanBao)
end

function odali_zhufugui:GetHongLiData(selfId)
end

function odali_zhufugui:SaveHongLiData(selfId, Time, nSLevel, SalyData, nYuanBao)
end

function odali_zhufugui:CreateDataBase(selfId)
end

function odali_zhufugui:Notify(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchEventList(selfId)
end

function odali_zhufugui:NotifyTip(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return odali_zhufugui
