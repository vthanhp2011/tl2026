local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ogaibang_texiaonpc = class("ogaibang_texiaonpc", script_base)
ogaibang_texiaonpc.script_id = 801003
ogaibang_texiaonpc.g_DemoSkills = {}

ogaibang_texiaonpc.g_DemoSkills[784] = "沛然有雨"
ogaibang_texiaonpc.g_DemoSkills[785] = "遨游东海"
ogaibang_texiaonpc.g_DemoSkills[786] = "见龙在田"
ogaibang_texiaonpc.g_DemoSkills[787] = "神龙摆尾"
ogaibang_texiaonpc.g_DemoSkills[788] = "飞龙在天"
ogaibang_texiaonpc.g_DemoSkills[789] = "亢龙有悔"
ogaibang_texiaonpc.g_DemoSkills[790] = "隔岸观火"
ogaibang_texiaonpc.g_DemoSkills[791] = "李代桃僵"
ogaibang_texiaonpc.g_DemoSkills[792] = "瞒天过海"
ogaibang_texiaonpc.g_DemoSkills[793] = "天下无狗"
ogaibang_texiaonpc.g_DemoSkills[794] = "拨狗朝天"
ogaibang_texiaonpc.g_DemoSkills[795] = "压扁狗背"
ogaibang_texiaonpc.g_DemoSkills[796] = "先下手为强"
ogaibang_texiaonpc.g_DemoSkills[797] = "金蝉脱壳"
ogaibang_texiaonpc.g_DemoSkills[798] = "抱残守缺"
ogaibang_texiaonpc.g_eventList = {784, 785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798}

function ogaibang_texiaonpc:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent])
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ogaibang_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return ogaibang_texiaonpc
