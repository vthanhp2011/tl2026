local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyuxi_luobo = class("oyuxi_luobo", script_base)

function oyuxi_luobo:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  你好。#r  我的名字是萝卜。#r  我阿爸的名字是索姆拉。#r  我阿妈的名字是古鲁拉。#r  我妹妹的名字是阿依娜。#r  ……#r  处理完毕。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyuxi_luobo
