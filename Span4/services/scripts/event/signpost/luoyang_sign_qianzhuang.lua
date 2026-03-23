local class = require "class"
local define = require "define"
local script_base = require "script_base"
local luoyang_sign_qianzhuang = class("luoyang_sign_qianzhuang", script_base)
luoyang_sign_qianzhuang.script_id = 500003
luoyang_sign_qianzhuang.g_Signpost = {
    { ["type"] = 2, ["name"] = "当铺", ["x"] = 95, ["y"] = 152, ["tip"] = "何生财",
        ["desc"] = "当铺老板何生财（95，152）在西门内的当铺里。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "钱庄", ["x"] = 80, ["y"] = 152, ["tip"] = "杨熙平",
        ["desc"] = "钱庄老板杨熙平（80，152）在西门内的钱庄内，他的夥计可以帮你存储物品和金钱。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "元宝商", ["x"] = 206, ["y"] = 172, ["tip"] = "金六爷",
        ["desc"] = "元宝商人金六爷（206，172）在东市。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function luoyang_sign_qianzhuang:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function luoyang_sign_qianzhuang:OnDefaultEvent(selfId, targetId,arg,index)
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

return luoyang_sign_qianzhuang
