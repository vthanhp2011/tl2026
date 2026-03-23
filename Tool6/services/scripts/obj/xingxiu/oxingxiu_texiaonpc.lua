local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxingxiu_texiaonpc = class("oxingxiu_texiaonpc", script_base)
oxingxiu_texiaonpc.script_id = 801006
oxingxiu_texiaonpc.g_DemoSkills = {}

oxingxiu_texiaonpc.g_DemoSkills[834] = "连珠腐屍毒"
oxingxiu_texiaonpc.g_DemoSkills[835] = "七星透骨"
oxingxiu_texiaonpc.g_DemoSkills[836] = "饮鸩止渴"
oxingxiu_texiaonpc.g_DemoSkills[837] = "拖泥带水"
oxingxiu_texiaonpc.g_DemoSkills[838] = "焦头烂额"
oxingxiu_texiaonpc.g_DemoSkills[839] = "移花接木"
oxingxiu_texiaonpc.g_DemoSkills[840] = "笑里藏刀"
oxingxiu_texiaonpc.g_DemoSkills[841] = "笑口常开"
oxingxiu_texiaonpc.g_DemoSkills[842] = "笑语解颐"
oxingxiu_texiaonpc.g_DemoSkills[843] = "含沙射影"
oxingxiu_texiaonpc.g_DemoSkills[844] = "四面楚歌"
oxingxiu_texiaonpc.g_DemoSkills[845] = "呆若木鸡"
oxingxiu_texiaonpc.g_DemoSkills[846] = "水淹七军"
oxingxiu_texiaonpc.g_DemoSkills[847] = "行屍走肉"
oxingxiu_texiaonpc.g_DemoSkills[848] = "恶贯满盈"
oxingxiu_texiaonpc.g_eventList = {834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848}

function oxingxiu_texiaonpc:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent])
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxingxiu_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return oxingxiu_texiaonpc
