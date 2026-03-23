local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osongjiang = class("osongjiang", script_base)
osongjiang.script_id = 760708
osongjiang.g_FuBenScriptId = 892009
function osongjiang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("胆敢挑战我们十二煞星，真是活的不耐烦了！")
    self:AddNumText("决战宋姜", 6, 1)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osongjiang:OnEventRequest(selfId, targetId, arg, index)
    if 1 == self:CallScriptFunction(self.g_FuBenScriptId, "IsSJZTimerRunning") then
        return
    end
    if self:GetTeamLeader(selfId) ~= selfId then
        self:BeginEvent(self.script_id)
        self:AddText("#{PMF_20080521_07}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local ret, msg = self:CallScriptFunction(self.g_FuBenScriptId, "CheckHaveBOSS")
    if 1 == ret then
        self:BeginEvent(self.script_id)
        self:AddText(msg)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    self:CallScriptFunction(self.g_FuBenScriptId, "OpenSJZTimer", 7, self.script_id, -1, -1)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
end

function osongjiang:OnSJZTimer(step, data1, data2)
    if 7 == step then
        self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "倒计时5秒")
        return
    end
    if 6 == step then
        self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "倒计时4秒")
        return
    end
    if 5 == step then
        self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "倒计时3秒")
        return
    end
    if 4 == step then
        self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "倒计时2秒")
        return
    end
    if 3 == step then
        self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "倒计时1秒")
        return
    end
    if 2 == step then
        self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "宋姜已经加入战斗，请大侠准备迎战！")
        self:CallScriptFunction(self.g_FuBenScriptId, "DeleteBOSS", "songjiang_NPC")
        return
    end
    if 1 == step then
        self:CallScriptFunction(self.g_FuBenScriptId, "CreateBOSS", "songjiang_BOSS", -1, -1)
        return
    end
end

return osongjiang
