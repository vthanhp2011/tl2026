--洛阳NPC
--颜如玉
--普通

local class = require "class"
local script_base = require "script_base"
local oluoyang_yanruyu = class("oluoyang_yanruyu", script_base)

function oluoyang_yanruyu:OnDefaultEvent(selfId, targetId)
	self:BeginEvent( targetId )
    self:AddText("  俗话说，相由心生，客官对自己的容貌可否满意呢，要不要稍稍做些改变？")
    self:AddNumText("修整容貌介绍", 11, 10 )
    self:AddNumText("修整容貌",6,1)
    self:AddNumText( "修改头像介绍", 11, 14 )
    self:AddNumText("修改头像",6,4)
    self:EndEvent()
    self:DispatchEventList(selfId,targetId)
end

function oluoyang_yanruyu:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:BeginUICommand()
            self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 80502901)
        return
    end
    if index == 4 then
        self:BeginUICommand()
            self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 80503001)
        return
    end
end

return oluoyang_yanruyu