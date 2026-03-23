local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oemei_texiaonpc = class("oemei_texiaonpc", script_base)
oemei_texiaonpc.script_id = 801005
oemei_texiaonpc.g_DemoSkills = {}

oemei_texiaonpc.g_DemoSkills[816] = "环佩归魂"
oemei_texiaonpc.g_DemoSkills[818] = "九阴神爪"
oemei_texiaonpc.g_DemoSkills[819] = "太阿倒持"
oemei_texiaonpc.g_DemoSkills[820] = "佛光普照"
oemei_texiaonpc.g_DemoSkills[821] = "金针渡劫"
oemei_texiaonpc.g_DemoSkills[822] = "宁静之雨"
oemei_texiaonpc.g_DemoSkills[823] = "冲虚养气"
oemei_texiaonpc.g_DemoSkills[824] = "妙笔生花"
oemei_texiaonpc.g_DemoSkills[825] = "起死回生"
oemei_texiaonpc.g_DemoSkills[826] = "经脉逆行"
oemei_texiaonpc.g_DemoSkills[827] = "移魂大法"
oemei_texiaonpc.g_DemoSkills[828] = "易筋锻骨"
oemei_texiaonpc.g_DemoSkills[829] = "万岳朝宗"
oemei_texiaonpc.g_DemoSkills[830] = "延年益寿"
oemei_texiaonpc.g_DemoSkills[831] = "生命之泉"
oemei_texiaonpc.g_eventList = {816, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831}

function oemei_texiaonpc:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent])
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oemei_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return oemei_texiaonpc
