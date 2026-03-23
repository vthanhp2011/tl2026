local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local QingQiuShop = class("QingQiuShop", script_base)
QingQiuShop.script_id = 893060
QingQiuShop.ShopTableInfo = 
{
	{1,38002520,"锦鳞魂玉",1,0,1,1,1,1},
	{1,38002521,"幻蝶魂玉",1,0,1,1,1,1},
	{1,38002522,"霜鹤魂玉",1,0,1,1,1,1},
	{1,38002523,"金乌魂玉",1,0,1,1,1,1},
	{1,38002524,"鹿蜀魂玉",1,0,1,1,1,1},
	{1,38002515,"青龙魂玉",1,0,1,1,4,1},
	{1,38002516,"玄武魂玉",1,0,1,1,4,1},
	{1,38002517,"白虎魂玉",1,0,1,1,4,1},
	{1,38002518,"朱雀魂玉",1,0,1,1,4,1},
	{1,38002519,"九尾魂玉",1,0,1,1,4,1},
	{2,38002520,"锦鳞魂玉",1,0,1,2,3,1},
	{2,38002521,"幻蝶魂玉",1,0,1,2,3,1},
	{2,38002522,"霜鹤魂玉",1,0,1,2,3,1},
	{2,38002523,"金乌魂玉",1,0,1,2,3,1},
	{2,38002524,"鹿蜀魂玉",1,0,1,2,3,1},
	{2,38002515,"青龙魂玉",1,0,1,2,15,1},
	{2,38002516,"玄武魂玉",1,0,1,2,15,1},
	{2,38002517,"白虎魂玉",1,0,1,2,15,1},
	{2,38002518,"朱雀魂玉",1,0,1,2,15,1},
	{2,38002519,"九尾魂玉",1,0,1,2,15,1},
}
function QingQiuShop:buyitem(selfId,g_QingQiu_TargetID,g_QingQiu_Type,Idx)
	if not g_QingQiu_TargetID or g_QingQiu_TargetID == -1 then
		self:NotifyTip(selfId,"targetid error")
		return
	end
	if g_QingQiu_Type < 1 or g_QingQiu_Type > 2 then
		self:NotifyTip(selfId,"g_QingQiu_Type error")
		return
	end
	if self:GetLevel(selfId) < 85 then
		self:NotifyTip(selfId,"#{QQSD_220801_9}")
		return
	end
	local Text = {"#{QQSD_220801_11}","#{QQSD_220801_31}"}
	local daibi = { ScriptGlobal.MDEX_QINGQIU_SHOPLINGYE, ScriptGlobal.MDEX_QINGQIU_SHOPXINYE }
	if self:GetMissionDataEx(selfId,daibi[g_QingQiu_Type]) < self.ShopTableInfo[Idx][8] then
		self:NotifyTip(selfId,Text[g_QingQiu_Type])
		return
	end
    self:BeginAddItem()
    self:AddItem(self.ShopTableInfo[Idx][2],1,true)
    if not self:EndAddItem(selfId) then
		self:NotifyTip(selfId,"#H您的道具背包不足，请至少空出1个道具栏位。")
        return
    end
	self:SetMissionDataEx(selfId,daibi[g_QingQiu_Type],self:GetMissionDataEx(selfId,daibi[g_QingQiu_Type]) - self.ShopTableInfo[Idx][8])
	self:AddItemListToHuman(selfId)
	self:NotifyTip(selfId,"您成功兑换了1个"..self.ShopTableInfo[Idx][3])
	self:BeginUICommand()
	self:UICommand_AddInt(self:GetMissionDataEx(selfId,daibi[g_QingQiu_Type]))
	self:EndUICommand()
	self:DispatchUICommand(selfId, 89306002)
end

function QingQiuShop:NotifyTip(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end
return QingQiuShop
