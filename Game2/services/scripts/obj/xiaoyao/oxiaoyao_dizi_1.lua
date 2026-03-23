local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxiaoyao_dizi_1 = class("oxiaoyao_dizi_1", script_base)
function oxiaoyao_dizi_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  小心，淩波洞中处处是机关，可不要走到禁地之中。如果你需要帮助，请到洞门附近找知客弟子帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxiaoyao_dizi_1
