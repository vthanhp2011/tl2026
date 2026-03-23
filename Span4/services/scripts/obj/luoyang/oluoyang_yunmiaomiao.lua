--洛阳NPC
--云渺渺
--普通
local class = require "class"
local script_base = require "script_base"
local oluoyang_yunmiaomiao = class("oluoyang_yunmiaomiao", script_base)
oluoyang_yunmiaomiao.shoptableindex = 17
local g_miscEventId = 311111
function oluoyang_yunmiaomiao:OnDefaultEvent(selfId, targetId)
	self:BeginEvent(self.script_id)
    self:AddText("#{OBJ_luoyang_0026}")
    self:AddNumText("珍兽相关介绍", 11, 10 )
    self:AddNumText("购买珍兽用品",7,0)
    self:AddNumText("珍兽技能学习",6,1)
    self:AddNumText("珍兽技能升级",6,34)
    self:AddNumText("还童",6,2)
    self:AddNumText("延长寿命",6,3)
    self:AddNumText("驯养",6,4)
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function oluoyang_yunmiaomiao:OnEventRequest(selfId, targetId, arg, index)
    print("oluoyang_yunmiaomiao:OnEventRequest index =", index)
    if index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_057}#r")
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
        return
    end
    if index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_058}#r")
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
        return
    end
    if index == 34 then
        self:BeginUICommand()
        self:UICommand_AddInt(selfId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19823)
        return
    elseif index<= 6 then
        local sel = index
        self:CallScriptFunction(g_miscEventId, "OnEnumerate", self, selfId, targetId, sel)
        return
    elseif index == 7 then
        self:LuaFnGetPetProcreateInfo(selfId);
        return
    end
    if index == 0 then
        self:DispatchShopItem(selfId,targetId, self.g_shoptableindex )
    end
end

return oluoyang_yunmiaomiao