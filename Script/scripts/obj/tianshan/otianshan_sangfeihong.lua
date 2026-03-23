local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianshan_sangfeihong = class("otianshan_sangfeihong", script_base)
otianshan_sangfeihong.g_shoptableindex = 48
function otianshan_sangfeihong:OnDefaultEvent(selfId, targetId)
end

return otianshan_sangfeihong
