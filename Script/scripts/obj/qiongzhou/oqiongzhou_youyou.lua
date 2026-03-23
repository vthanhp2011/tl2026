local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqiongzhou_youyou = class("oqiongzhou_youyou", script_base)
function oqiongzhou_youyou:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  呜呜……这里有好多的鳄鱼啊，难道子衿哥哥天天就是生活在这样的环境里吗？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oqiongzhou_youyou:OnDie(selfId, killerId) end

return oqiongzhou_youyou
