local gbk = require "gbk"
local class = require "class"
local script_base = require "script_base"
local zhenghe = class("zhenghe", script_base)
function zhenghe:OpenZhengHeUI(selfId)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 99852604)
end

function zhenghe:OpenUI(selfId)
    self:BeginUICommand()
    self:UICommand_AddInt(1)
    self:UICommand_AddInt(-1)
    self:UICommand_AddInt(-1)
    self:UICommand_AddInt(0)
    self:UICommand_AddInt(0)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 99852605)
end

return zhenghe