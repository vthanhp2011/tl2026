local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_texiaonpc = class("odali_texiaonpc", script_base)
odali_texiaonpc.script_id = 801007
odali_texiaonpc.g_DemoSkills = {}

odali_texiaonpc.g_DemoSkills[850] = "快活三"
odali_texiaonpc.g_DemoSkills[851] = "回风拂柳"
odali_texiaonpc.g_DemoSkills[852] = "有常无常"
odali_texiaonpc.g_DemoSkills[853] = "无众生相"
odali_texiaonpc.g_DemoSkills[854] = "非枯非荣"
odali_texiaonpc.g_DemoSkills[855] = "金玉满堂"
odali_texiaonpc.g_DemoSkills[856] = "立地成佛"
odali_texiaonpc.g_DemoSkills[857] = "丹凤朝阳"
odali_texiaonpc.g_DemoSkills[858] = "白驹过隙"
odali_texiaonpc.g_DemoSkills[859] = "少泽剑"
odali_texiaonpc.g_DemoSkills[860] = "商阳剑"
odali_texiaonpc.g_DemoSkills[861] = "少商剑"
odali_texiaonpc.g_DemoSkills[862] = "白虹贯日"
odali_texiaonpc.g_DemoSkills[863] = "微服私访"
odali_texiaonpc.g_DemoSkills[864] = "万国来朝"
odali_texiaonpc.g_eventList = {850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864}

function odali_texiaonpc:OnDefaultEvent(selfId, targetId)
    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, define.ABILITY_ZHONGZHI)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent], 11, -1)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return odali_texiaonpc
