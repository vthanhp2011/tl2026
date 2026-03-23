local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxiaoyao_texiaonpc = class("oxiaoyao_texiaonpc", script_base)
oxiaoyao_texiaonpc.script_id = 801009
oxiaoyao_texiaonpc.g_DemoSkills = {}

oxiaoyao_texiaonpc.g_DemoSkills[881] = "望洋兴叹"
oxiaoyao_texiaonpc.g_DemoSkills[882] = "蝴蝶阵"
oxiaoyao_texiaonpc.g_DemoSkills[883] = "八门金锁"
oxiaoyao_texiaonpc.g_DemoSkills[884] = "一字长蛇"
oxiaoyao_texiaonpc.g_DemoSkills[885] = "太乙三才"
oxiaoyao_texiaonpc.g_DemoSkills[886] = "八阵图"
oxiaoyao_texiaonpc.g_DemoSkills[887] = "火眼金睛"
oxiaoyao_texiaonpc.g_DemoSkills[888] = "众妙之门"
oxiaoyao_texiaonpc.g_DemoSkills[889] = "神光离合"
oxiaoyao_texiaonpc.g_DemoSkills[890] = "淩波微步"
oxiaoyao_texiaonpc.g_DemoSkills[891] = "履霜冰至"
oxiaoyao_texiaonpc.g_DemoSkills[892] = "欲擒故纵"
oxiaoyao_texiaonpc.g_DemoSkills[893] = "退避三舍"
oxiaoyao_texiaonpc.g_DemoSkills[894] = "朝三暮四"
oxiaoyao_texiaonpc.g_DemoSkills[895] = "一呼百应"
oxiaoyao_texiaonpc.g_eventList = {881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895}

function oxiaoyao_texiaonpc:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent])
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxiaoyao_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return oxiaoyao_texiaonpc
