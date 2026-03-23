local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zhaoqiansun = class("oluoyang_zhaoqiansun", script_base)
function oluoyang_zhaoqiansun:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  你也是来白马寺拜佛的吗？这里的佛祖可灵了，小娟前些日子给我来信了，一定是我的诚心感动了佛祖……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_zhaoqiansun
