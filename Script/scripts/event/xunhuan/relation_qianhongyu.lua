local class = require "class"
local define = require "define"
local script_base = require "script_base"
local relation_qianhongyu = class("relation_qianhongyu", script_base)
relation_qianhongyu.script_id = 050106
relation_qianhongyu.g_TitleList = {
    {
        ["relation"] = 1000,
        ["title"] = "剿匪义士",
        ["failMsg"] = "    要获得一级称号，你我之间的关系值至少要达到1000，还是多完成几次剿匪再来找我吧。",
        ["succMsg"] = "    阁下武功了得，在下十分的敬佩，江湖传闻阁下为#R剿匪义士#W，我看当之无愧！"
    }, {
        ["relation"] = 2000,
        ["title"] = "破匪侠士",
        ["failMsg"] = "    要获得二级称号，你我之间的关系值至少要达到2000，还是多完成几次剿匪再来找我吧。",
        ["succMsg"] = "    阁下武功了得，在下十分的敬佩，江湖传闻阁下为#R破匪侠士#W，我看当之无愧！"
    }, {
        ["relation"] = 4000,
        ["title"] = "镇匪英侠",
        ["failMsg"] = "    要获得三级称号，你我之间的关系值至少要达到4000，还是多完成几次剿匪再来找我吧。",
        ["succMsg"] = "    阁下武功了得，在下十分的敬佩，江湖传闻阁下为#R镇匪英侠#W，我看当之无愧！"
    }, {
        ["relation"] = 6500,
        ["title"] = "天下匪见愁",
        ["failMsg"] = "    要获得四级称号，你我之间的关系值至少要达到6500，还是多完成几次剿匪再来找我吧。",
        ["succMsg"] = "    阁下武功了得，在下十分的敬佩，江湖传闻阁下为#R天下匪见愁#W，我看当之无愧！"
    }
}

function relation_qianhongyu:OnDefaultEvent(selfId, targetId)
    local opt = index
    if opt == 7 then
        self:GetTitleOptions(selfId, targetId)
    elseif opt == 8 then
        self:GetNewTitle(selfId, targetId)
    end
end

function relation_qianhongyu:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "领取称号", 8, 7)
end

function relation_qianhongyu:GetTitleOptions(selfId, targetId)
    local str = string.format("    啊，%s，我对完成缉拿剿匪任务的英雄总是很是佩服，现在你我的关系值为%d，当你我的关系值达到1000，2000，4000，6500皆可以在我这里兑换称号。",
                    self:GetName(selfId),
                    self:GetMissionData(selfId, define.MD_ENUM.MD_RELATION_QIANHONGYU))
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:AddNumText("领取新的称号", 8, 8)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function relation_qianhongyu:GetNewTitle(selfId, targetId)
    self:BeginEvent(self.script_id)
    local str = ""
    local curTitle = self:GetQHYTitle(selfId)
    local relation = self:GetMissionData(selfId, define.MD_ENUM.MD_RELATION_QIANHONGYU)
    local loc = 1
    for i = 1, #(self.g_TitleList) do
        if curTitle == self.g_TitleList[i]["title"] then
            loc = i
            break
        end
    end
    if loc == #(self.g_TitleList) then
        str =
            "    阁下如今已是名冠江湖的天下匪见愁了，江湖上的匪类闻阁下之名人人丧胆，个个惊心啊。已经没有更高的称号可以表达你的能力了。"
    else
        for i = loc, #(self.g_TitleList) do
            if relation < self.g_TitleList[i]["relation"] then
                str = self.g_TitleList[i]["failMsg"]
                break
            elseif self.g_TitleList[i]["title"] ~= self:GetQHYTitle(selfId) then
                self:SetQHYTitle(selfId, self.g_TitleList[i]["title"])
                self:DispatchAllTitle(selfId)
                str = self.g_TitleList[i]["succMsg"]
                break
            end
        end
    end
    self:AddText(str)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return relation_qianhongyu
