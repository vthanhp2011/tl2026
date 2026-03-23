local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ocaoyuan_liaobing = class("ocaoyuan_liaobing", script_base)
ocaoyuan_liaobing.script_id = 020008
function ocaoyuan_liaobing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  离我远一点， 宋人不配和我说话。#r  吾皇万岁！ 大辽必胜！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ocaoyuan_liaobing
