--逍遥NPC
--康广陵
--普通

local gbk = require "gbk"
local define = require "define"
local class = require "class"
local script_base = require "script_base"
local oxiaoyao_kangguangling = class("oxiaoyao_kangguangling", script_base)

function oxiaoyao_kangguangling:OnDefaultEvent(selfId, targetId)
    local menpai = self:GetMenPai(selfId)
    if menpai == 8 then
        self:BeginEvent(self.script_id)
		    self:AddText("#{TYJZ_081103_02}")
            self:AddNumText("学习技能",12,0)
            self:AddNumText("关于心法的介绍",11,10)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    else
        self:BeginEvent(self.script_id)
		    self:AddText("我是康广陵，你有何事啊？")
            self:AddNumText("关于心法的介绍",11,10)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oxiaoyao_kangguangling:OnEventRequest(selfId, targetId, arg, index)
    if index == 10 then
        self:BeginEvent(self.script_id)
		    self:AddText("#{function_xinfajieshao_001}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    elseif index == 11 then
        self:BeginEvent(self.script_id)
            self:AddText("#{JZBZ_081031_01}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:DispatchXinfaLevelInfo(selfId, targetId, 8)
end

return oxiaoyao_kangguangling