local class = require "class"
local define = require "define"
local script_base = require "script_base"
local eprize = class("eprize", script_base)
eprize.titleinfo = 
{
    1204,1286,1073,-1,1234,1235,1236
}
eprize.menpaititle = 
{
    1096,1108,1117,1099,1102,1105,1111,1120,1114,-1,1219
}
eprize.payinfo = 
{
    500,1000,3000,5000,10000,30000,50000
}
eprize.titletxt = 
{
    "同心同梦筑江湖","初会便已许平生","竹涧轻觞会知交","","争霸江湖·尚武侠者","争霸江湖·百战精英","技惊一方·倚剑天骄"
}
eprize.menpaititletxt = 
{
    "少林第一人","明教第一人","丐帮第一人","武当第一人","峨嵋第一人","星宿第一人","天龙第一人","天山第一人","逍遥第一人","","曼陀山庄第一人"
}
function eprize:AskPoint(selfId)
    local point = self:GetTopUpPoint(selfId) * 10
    self:NotifyLeftPoint(selfId, point)
end

function eprize:NotifyLeftPoint(selfId, nLeftPoint)
    self:BeginUICommand()
    self:UICommand_AddInt(nLeftPoint)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 2003)
end

function eprize:BuyYuanBao(selfId, count, rate)
    local need_point = count * rate / 10
    local result = self:CostTopUpPoint(selfId, need_point)
    if not result then
        self:notify_tips(selfId, "点数不足")
        return
    end
    self:CSAddYuanbao(selfId, count)
    self:notify_tips(selfId, "您成功的兑换了" .. count .. "点元宝。")
    local acme_havepoint = self:GetMissionData(selfId, 388)
    self:SetMissionData(selfId, 388, acme_havepoint + count)
    self:AddPayTitle(selfId)
end

function eprize:AddPayTitle(selfId)
    local HaveYuanBao = self:GetMissionData(selfId, 388)
    local menpai = self:GetMenPai(selfId)
    local titleidx = 0
    for i = 1,#self.payinfo do
        if self.payinfo[i] * 500 >= HaveYuanBao then
            titleidx = i;
        end
        if titleidx > 0 and titleidx ~= 4 then
            if not self:LuaFnHaveAgname(selfId, self.titleinfo[titleidx]) then
                self:LuaFnAddNewAgname(selfId, self.titleinfo[titleidx])
                self:notify_tips(selfId,string.format("获得称号：%s",self.titletxt[titleidx]))
            end
        end
        if titleidx == 4 then
            --由于门派问题，防止转门派卡称号重复获取其他称号这里要写一个判断
            for k = 1,#self.menpaititle do
                if k ~= 10 then
                    if self:LuaFnHaveAgname(selfId, self.menpaititle[k]) then
                        return
                    end
                end
            end
            if not self:LuaFnHaveAgname(selfId, self.menpaititle[menpai + 1]) then
                self:LuaFnAddNewAgname(selfId, self.menpaititle[menpai + 1])
                self:notify_tips(selfId,string.format("获得称号：%s",self.menpaititletxt[menpai + 1]))
            end
        end
    end
end

return eprize