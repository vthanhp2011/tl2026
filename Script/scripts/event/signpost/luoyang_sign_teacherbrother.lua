local class = require "class"
local define = require "define"
local script_base = require "script_base"
local luoyang_sign_teacherbrother = class("luoyang_sign_teacherbrother", script_base)
luoyang_sign_teacherbrother.script_id = 500013
luoyang_sign_teacherbrother.g_Signpost = {
    { ["type"] = 2, ["name"] = "结拜", ["x"] = 144, ["y"] = 68, ["tip"] = "陈夫之",
        ["desc"] = "户部尚书陈夫之（144，68）在西京府内，如果想结拜就去找他。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function luoyang_sign_teacherbrother:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function luoyang_sign_teacherbrother:OnDefaultEvent(selfId, targetId, arg, index)
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

return luoyang_sign_teacherbrother
