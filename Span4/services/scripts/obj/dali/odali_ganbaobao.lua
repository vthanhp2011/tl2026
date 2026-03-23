local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_ganbaobao = class("odali_ganbaobao", script_base)
function odali_ganbaobao:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  哼，谁干卑鄙无耻之事，谁就卑鄙无耻，用不着我来骂！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_ganbaobao
