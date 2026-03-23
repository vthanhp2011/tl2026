local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owudang_zhangjunmu = class("owudang_zhangjunmu", script_base)
owudang_zhangjunmu.g_shoptableindex = 44
function owudang_zhangjunmu:OnDefaultEvent(selfId, targetId)
end

return owudang_zhangjunmu
