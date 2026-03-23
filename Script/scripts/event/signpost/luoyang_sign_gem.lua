local class = require "class"
local define = require "define"
local script_base = require "script_base"
local luoyang_sign_gem = class("luoyang_sign_gem", script_base)
luoyang_sign_gem.script_id = 500012
luoyang_sign_gem.g_Signpost = {
    { ["type"] = 2, ["name"] = "宝石合成", ["x"] = 177, ["y"] = 184, ["tip"] = "彭怀玉",
        ["desc"] = "宝石合成工匠彭怀玉（177，184）在南大街与东市之间的服饰店内。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function luoyang_sign_gem:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function luoyang_sign_gem:OnDefaultEvent(selfId, targetId,arg,index)
    local signpost = self.g_Signpost[index]
    if signpost["type"] == 1 then
        self:BeginEvent(self.script_id)
        self:AddText(signpost["name"] .. "：")
        self:CallScriptFunction(signpost["eventId"], "OnEnumerate", selfId, targetId)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif signpost["type"] == 2 then
        self:CallScriptFunction(888888, "AskTheWay", selfId, signpost["x"], signpost["y"], signpost["tip"])
        self:BeginEvent(self.script_id)
        self:AddText(signpost["desc"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

return luoyang_sign_gem
