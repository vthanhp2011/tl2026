--云涵儿

--脚本号
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zhangxianglong = class("oluoyang_zhangxianglong", script_base)

function oluoyang_zhangxianglong:OnDefaultEvent(selfId, targetId)
	self:BeginEvent(self.script_id)
	    self:AddText("#{ZBDW_091105_1}")
	    self:AddNumText("雕纹合成",6,1)
	    self:AddNumText("雕纹蚀刻",6,2)
	    self:AddNumText("雕纹强化",6,4)
	    self:AddNumText("雕纹拆除",6,6)
	    self:AddNumText("关于装备雕纹",11,8)
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function oluoyang_zhangxianglong:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 1000156)
    elseif index == 2 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 2000156)
    elseif index == 4 then
		--local nMaterialNum = self:LuaFnMtl_GetCostNum(selfId,20310166,20310167,20310168)
		self:BeginUICommand()
        self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 20141204)
    elseif index == 6 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 4000156)
    elseif index == 8 then
		self:BeginEvent(self.script_id)
        self:AddText("#{ZBDW_091105_21}")
		self:AddText("    #G小提示：右键点击装备、材料进行操作，只有特定高级装备才可以雕纹。")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
    end
end

return oluoyang_zhangxianglong