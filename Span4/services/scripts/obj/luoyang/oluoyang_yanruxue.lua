--洛阳NPC
--颜如雪
--普通

local class = require "class"
local script_base = require "script_base"
local oluoyang_yanruxue = class("oluoyang_yanruxue", script_base)

function oluoyang_yanruxue:OnDefaultEvent(selfId, targetId)
	self:BeginEvent( targetId )
    self:AddText("  花自飘零水自流，淡淡青丝自言愁，春暖秋霜怜人袖，满月半弦月如钩。既然无处言愁，何不换个发型呢？")
    self:AddNumText("修改发型介绍", 11, 10 )
    self:AddNumText("修改发型",6,1)
    self:AddNumText( "修改头像介绍", 11, 14 )
    self:EndEvent()
    self:DispatchEventList(selfId,targetId)
end

function oluoyang_yanruxue:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:BeginUICommand()
            self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 80101001)
        return
    end
end

return oluoyang_yanruxue