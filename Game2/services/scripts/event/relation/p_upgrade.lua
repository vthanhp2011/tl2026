local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_upgrade = class("p_upgrade", script_base)
p_upgrade.script_id = 806015
p_upgrade.g_Update = {}

p_upgrade.g_Update["id"] = 1000
p_upgrade.g_Update["wu"] = 1001
p_upgrade.g_Update["uw"] = 1002
p_upgrade.g_msg = {}

p_upgrade.g_msg["up"] = "我要提升我的师德等级"
p_upgrade.g_msg["un"] = "  你的师德等级已达最高，无法提升。"
p_upgrade.g_msg["nv"] = "  你的善恶值不足，无法提升。"
p_upgrade.g_msg["uc"] = "  提升到A要用B点善恶值。"
p_upgrade.g_msg["wu"] = "我要提升我的师德等级"
p_upgrade.g_msg["uw"] = "我还是不想提升了"
p_upgrade.g_msg["ul"] = "  只有等级大于20级才有资格申请师傅称号。"
p_upgrade.g_Title = {}

p_upgrade.g_Title[1] = "初级师傅"
p_upgrade.g_Title[2] = "中级师傅"
p_upgrade.g_Title[3] = "高级师傅"
p_upgrade.g_Title[4] = "一代名师"
function p_upgrade:OnDefaultEvent(selfId, targetId, index)
    local key = index
    if key == self.g_Update["id"] then
        self:Upgrade(selfId, targetId)
        return 0
    end
    if key == self.g_Update["wu"] then
        if self:DoUpgrade(selfId, targetId) == 0 then
            return 0
        end
        local msg = "您的师德等级提升到" .. tostring(self:LuaFnGetmasterLevel(selfId) .. "级。")
        self:MessageBox(selfId, targetId, "  " .. msg)
        self:Msg2Player(selfId, msg, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        return 0
    end
    if key == self.g_Update["uw"] then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    end
end

function p_upgrade:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, self.g_msg["up"], 6, self.g_Update["id"])
end

function p_upgrade:CheckAccept(selfId, targetId)
end

function p_upgrade:OnAccept(selfId, targetId)
    self:OnConfirm(selfId, targetId)
end

function p_upgrade:OnSubmit(selfId, targetId, tId)
end

function p_upgrade:OnCancel(selfId, targetId)
end

function p_upgrade:MessageBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function p_upgrade:Upgrade(selfId, targetId)
    local HumanLevel = self:LuaFnGetLevel(selfId)
    local level = self:LuaFnGetmasterLevel(selfId)
    if HumanLevel < 20 then
        self:MessageBox(selfId, targetId, self.g_msg["ul"])
        return 0
    end
    if level >= 4 then
        self:MessageBox(selfId, targetId, self.g_msg["un"])
        return 0
    end
    local exp = 0
    if level == 0 and HumanLevel < 60 then
        exp = 500
    elseif level == 1 then
        exp = 5000
    elseif level == 2 then
        exp = 25000
    elseif level == 3 then
        exp = 50000
    end
    local text = "  将师德等级提升到" .. tostring(level + 1) .. "级，会消耗善恶值" .. tostring(exp) .. "点。"
    self:BeginEvent(self.script_id)
    self:AddText(text)
    self:AddNumText(self.g_msg["wu"], 6, self.g_Update["wu"])
    self:AddNumText(self.g_msg["uw"], 8, self.g_Update["uw"])
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
    return 1
end

function p_upgrade:DoUpgrade(selfId, targetId)
    local HumanLevel = self:LuaFnGetLevel(selfId)
    local level = self:LuaFnGetmasterLevel(selfId)
    if level >= 4 then
        return 0
    end
    local exp = 0
    if level == 0 and HumanLevel < 60 then
        exp = 500
    elseif level == 1 then
        exp = 5000
    elseif level == 2 then
        exp = 25000
    elseif level == 3 then
        exp = 50000
    end
    local gbvalue = self:LuaFnGetHumanGoodBadValue(selfId)
    if gbvalue < exp then
        local msg = "  您的善恶值不足，您目前的善恶值为" .. tostring(gbvalue) .. "。"
        self:MessageBox(selfId, targetId, msg)
        return 0
    end
    level = level + 1
    self:LuaFnSetmasterLevel(selfId, level)
    gbvalue = gbvalue - exp
    self:LuaFnSetHumanGoodBadValue(selfId, gbvalue)
    self:AwardMasterTitle(selfId, self.g_Title[level])
    self:DispatchAllTitle(selfId)
    self:SetCurTitle(selfId, 27, 0)
    local nam = self:GetName(selfId)
    local str = string.format("#I恭喜#W#{_INFOUSR%s}#I成功获得#G%s#I的称号，现在可以收其他玩家为徒了。", nam, self.g_Title[level])
    self:AddGlobalCountNews(str)
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
    return level
end

return p_upgrade
