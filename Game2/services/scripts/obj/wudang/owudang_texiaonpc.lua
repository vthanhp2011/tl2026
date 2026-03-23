local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owudang_texiaonpc = class("owudang_texiaonpc", script_base)
owudang_texiaonpc.script_id = 801004
owudang_texiaonpc.g_DemoSkills = {}

owudang_texiaonpc.g_DemoSkills[800] = "玉女穿梭"
owudang_texiaonpc.g_DemoSkills[801] = "游刃有余"
owudang_texiaonpc.g_DemoSkills[802] = "燕子抄水"
owudang_texiaonpc.g_DemoSkills[803] = "白鹤亮翅"
owudang_texiaonpc.g_DemoSkills[804] = "虎抱头"
owudang_texiaonpc.g_DemoSkills[805] = "双峰贯耳"
owudang_texiaonpc.g_DemoSkills[806] = "三环套月"
owudang_texiaonpc.g_DemoSkills[807] = "揽雀尾"
owudang_texiaonpc.g_DemoSkills[808] = "相濡以沫"
owudang_texiaonpc.g_DemoSkills[809] = "梯云纵"
owudang_texiaonpc.g_DemoSkills[810] = "野马分鬃"
owudang_texiaonpc.g_DemoSkills[811] = "如封似闭"
owudang_texiaonpc.g_DemoSkills[812] = "寒梅映雪"
owudang_texiaonpc.g_DemoSkills[813] = "大魁星"
owudang_texiaonpc.g_DemoSkills[814] = "真武七截阵"
owudang_texiaonpc.g_eventList = {800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814}

function owudang_texiaonpc:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent])
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function owudang_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return owudang_texiaonpc
