local class = require "class"
local define = require "define"
local script_base = require "script_base"
local dali_sign_menpaichuansong = class("dali_sign_menpaichuansong", script_base)
dali_sign_menpaichuansong.script_id = 500041
dali_sign_menpaichuansong.g_Signpost = {
    { ["type"] = 2, ["name"] = "少林", ["x"] = 187, ["y"] = 122, ["tip"] = "慧易",
        ["desc"] = "少林派接引僧慧易（187，122）就在大理中央五华坛的东北角，按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "天龙", ["x"] = 189, ["y"] = 124, ["tip"] = "破贪",
        ["desc"] = "天龙派接引僧破贪（189，124）就在大理中央五华坛的东北角，按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "逍遥", ["x"] = 188, ["y"] = 133, ["tip"] = "澹台子羽",
        ["desc"] = "逍遥派接引使澹台子羽（188，133）就在大理中央五华坛的东北角，按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "峨嵋", ["x"] = 192, ["y"] = 129, ["tip"] = "路三娘",
        ["desc"] = "峨嵋派接引姑姑路三娘（192，129）就在大理中央五华坛的东北角，按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "天山", ["x"] = 131, ["y"] = 124, ["tip"] = "程青霜",
        ["desc"] = "天山派接引使称青霜（131，124）就在大理中央五华坛的西北角，距离拜师介绍人聂政不远。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "星宿", ["x"] = 134, ["y"] = 120, ["tip"] = "海风子",
        ["desc"] = "星宿派接引弟子海风子（131，124）就在大理中央五华坛的西北角，距离拜师介绍人聂政不远。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "明教", ["x"] = 130, ["y"] = 121, ["tip"] = "石宝",
        ["desc"] = "明教接引使石宝（131，124）就在大理中央五华坛的西北角，距离拜师介绍人聂政不远。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "武当", ["x"] = 127, ["y"] = 131, ["tip"] = "张获",
        ["desc"] = "武当接引道长张获（131，124）就在大理中央五华坛的西北角，距离拜师介绍人聂政不远。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "丐帮", ["x"] = 126, ["y"] = 135, ["tip"] = "简宁",
        ["desc"] = "丐帮接引长老简甯（131，124）就在大理中央五华坛的西北角，距离拜师介绍人聂政不远。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function dali_sign_menpaichuansong:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function dali_sign_menpaichuansong:OnDefaultEvent(selfId, targetId,arg,index)
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

return dali_sign_menpaichuansong
