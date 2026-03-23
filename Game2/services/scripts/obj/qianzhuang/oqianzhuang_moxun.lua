local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqianzhuang_moxun = class("oqianzhuang_moxun", script_base)
oqianzhuang_moxun.script_id = 181004
function oqianzhuang_moxun:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    珍奇材料，各种打造图，客官请随便挑选！")
    self:AddNumText("打造图", 2, 1)
    self:AddNumText("元宝介绍", 11, 2)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oqianzhuang_moxun:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    if key == 1 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(8)
        self:UICommand_AddInt(1)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 888902)
    elseif key == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{INTRO_YUANBAO}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oqianzhuang_moxun:OnOpenShop(selfId, targetId, lstShop) end

return oqianzhuang_moxun
