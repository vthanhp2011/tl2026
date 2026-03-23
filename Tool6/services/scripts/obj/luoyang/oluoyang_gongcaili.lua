local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_gongcaili = class("oluoyang_gongcaili", script_base)
oluoyang_gongcaili.script_id = 000132
oluoyang_gongcaili.g_Key = {["chg"] = 1, ["in1"] = 2, ["in2"] = 3, ["bak"] = 4}

oluoyang_gongcaili.g_eventList = {808065}

oluoyang_gongcaili.g_ChangeLst = {
    [1] = {
        ["des"] = "兑换携带等级5级的墨镜猫",
        ["id"] = 30505109,
        ["key"] = 101,
        ["NeedItm"] = 30008026,
        ["NeedNum"] = 30
    },
    [2] = {
        ["des"] = "兑换携带等级45级的流行猫",
        ["id"] = 30505110,
        ["key"] = 102,
        ["NeedItm"] = 30008026,
        ["NeedNum"] = 40
    },
    [3] = {
        ["des"] = "兑换携带等级55级的时尚猫",
        ["id"] = 30505111,
        ["key"] = 103,
        ["NeedItm"] = 30008026,
        ["NeedNum"] = 43
    },
    [4] = {
        ["des"] = "兑换携带等级65级的偶像猫",
        ["id"] = 30505112,
        ["key"] = 104,
        ["NeedItm"] = 30008026,
        ["NeedNum"] = 46
    },
    [5] = {
        ["des"] = "兑换携带等级75级的冠军猫",
        ["id"] = 30505113,
        ["key"] = 105,
        ["NeedItm"] = 30008026,
        ["NeedNum"] = 50
    },
    [6] = {
        ["des"] = "兑换携带等级85级的吉祥猫",
        ["id"] = 30505154,
        ["key"] = 106,
        ["NeedItm"] = 30008026,
        ["NeedNum"] = 80
    }
}

function oluoyang_gongcaili:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{ANXIANG_DLG}")
    self:AddNumText("我想兑换墨镜猫", 6, self.g_Key["chg"])
    self:AddNumText("关于兑换", 11, self.g_Key["in1"])
    local i, eventId
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_gongcaili:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
    if key == self.g_Key["chg"] then
        self:BeginEvent(self.script_id)
        self:AddText("    您想兑换什么携带等级的珍兽？")
        for i = 1, #self.g_ChangeLst do
            self:AddNumText(self.g_ChangeLst[i]["des"], 6,
                            self.g_ChangeLst[i]["key"])
        end
        self:AddNumText("返回上一页", -1, self.g_Key["bak"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == self.g_Key["in1"] then
        self:MsgBox(selfId, targetId, "#{ANXIANG_CHG}")
    elseif key == self.g_Key["in2"] then
        self:MsgBox(selfId, targetId, "#{ANXIANG_INF}")
    elseif key == self.g_Key["bak"] then
        self:OnDefaultEvent(selfId, targetId)
    else
        for i = 1, #(self.g_ChangeLst) do
            if key == self.g_ChangeLst[i]["key"] then
                self:OnMyChange(selfId, targetId, self.g_ChangeLst[i])
                break
            end
        end
    end
end

function oluoyang_gongcaili:OnMyChange(selfId, targetId, unt)
    if unt == nil then return end
    if self:LuaFnGetAvailableItemCount(selfId, unt["NeedItm"]) < unt["NeedNum"] then
        self:MsgBox(selfId, targetId,
                    "    " .. unt["des"] ..
                        "，您身上的可用古瓷碎片不足" ..
                        unt["NeedNum"] ..
                        "个。（古瓷碎片可以通过打开暗金宝箱获得）")
        return
    end
    self:BeginAddItem()
    self:AddItem(unt["id"], 1)
    if self:EndAddItem(selfId) then
        if self:LuaFnDelAvailableItem(selfId, unt["NeedItm"], unt["NeedNum"]) then
            self:AddItemListToHuman(selfId)
        else
            self:MsgBox(selfId, targetId, "    扣除物品失败！")
            return
        end
    else
        self:MsgBox(selfId, targetId,
                    "    对不起，您的背包已满，无法兑换。")
        return
    end
    local BagPos = self:GetBagPosByItemSn(selfId, unt["id"])
    local szTran = self:GetBagItemTransfer(selfId, BagPos)
    local szUser = "#{_INFOUSR" .. self:GetName(selfId) .. "}"
    local szItem = "#{_INFOMSG" .. szTran .. "}"
    local szMsg = string.format( "#W%s#cff99cc历尽千辛为#G洛阳（111，163）#Y龚彩丽#cff99cc找齐了#Y古瓷碎片#cff99cc，龚彩丽献上%%s作为感谢。", szUser)
    szMsg = gbk.fromutf8(szMsg)
    szMsg = string.format(szMsg, szItem)
    self:MsgBox(selfId, targetId, "    您成功的兑换了" ..
                    self:GetItemName(unt["id"]) .. "。")
    self:BroadMsgByChatPipe(selfId, szMsg, 4)
end

function oluoyang_gongcaili:MsgBox(selfId, targetId, str)
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_gongcaili
