local class = require "class"
local define = require "define"
local script_base = require "script_base"
local luoyang_sign_pkmanage = class("luoyang_sign_pkmanage", script_base)
luoyang_sign_pkmanage.script_id = 500011
luoyang_sign_pkmanage.g_Signpost = {
    { ["type"] = 2, ["name"] = "洛阳校场", ["x"] = 89, ["y"] = 173, ["tip"] = "洛阳校场",
        ["desc"] = "想切磋武艺就到洛阳校场去吧。右键点击对手，选择挑战。", ["eventId"] = -1 }
}
function luoyang_sign_pkmanage:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function luoyang_sign_pkmanage:OnDefaultEvent(selfId, targetId,arg,index)
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

return luoyang_sign_pkmanage
