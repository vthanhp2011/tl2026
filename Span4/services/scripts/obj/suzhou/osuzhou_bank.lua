local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_bank = class("osuzhou_bank", script_base)
osuzhou_bank.script_id = 1026
function osuzhou_bank:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddNumText("打开银行", 5, -1)
    self:AddNumText("购买新的租赁箱", 5, -1)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_bank:OnEventRequest(selfId, targetId, arg, index)
    self:BeginEvent(self.script_id)
    if index == 7 then
        self:BankBegin(selfId)
    elseif index == 8 then
        self:EnableBankRentIndex(selfId, 2)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_bank
