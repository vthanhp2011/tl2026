local class = require "class"
local define = require "define"
local script_base = require "script_base"
local dali_sign_qianzhuang = class("dali_sign_qianzhuang", script_base)
dali_sign_qianzhuang.script_id = 500044
dali_sign_qianzhuang.g_Signpost = {
    { ["type"] = 2, ["name"] = "钱庄", ["x"] = 211, ["y"] = 172, ["tip"] = "王颖",
        ["desc"] = "王老板的钱庄在距离五华坛不远的东大街路南，按下TAB键，地图上会有闪烁的标识的。钱庄的夥计可以帮你存储物品和金钱。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "当铺", ["x"] = 81, ["y"] = 162, ["tip"] = "韩永安",
        ["desc"] = "当铺老板韩永安在西大街路南。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function dali_sign_qianzhuang:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function dali_sign_qianzhuang:OnDefaultEvent(selfId, targetId,arg,index)
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

return dali_sign_qianzhuang
