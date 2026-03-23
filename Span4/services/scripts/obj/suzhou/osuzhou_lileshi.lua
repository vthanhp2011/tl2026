local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_lileshi = class("osuzhou_lileshi", script_base)
osuzhou_lileshi.script_id = 001055
osuzhou_lileshi.g_shoptableindex = 104
function osuzhou_lileshi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  在我这里你可用善恶值换取打造图与鉴定符。")
    self:AddNumText("善恶值换打造图与鉴定符", 7, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_lileshi:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
end

return osuzhou_lileshi
