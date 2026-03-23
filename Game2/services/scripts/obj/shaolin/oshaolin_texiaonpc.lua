local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshaolin_texiaonpc = class("oshaolin_texiaonpc", script_base)
oshaolin_texiaonpc.script_id = 801001
oshaolin_texiaonpc.g_DemoSkills = {}

oshaolin_texiaonpc.g_DemoSkills[752] = "般若掌"
oshaolin_texiaonpc.g_DemoSkills[753] = "金刚伏魔圈"
oshaolin_texiaonpc.g_DemoSkills[754] = "一拍两散"
oshaolin_texiaonpc.g_DemoSkills[755] = "韦陀杵"
oshaolin_texiaonpc.g_DemoSkills[756] = "铁布衫"
oshaolin_texiaonpc.g_DemoSkills[757] = "无相劫指"
oshaolin_texiaonpc.g_DemoSkills[758] = "罗汉阵"
oshaolin_texiaonpc.g_DemoSkills[759] = "狮子吼"
oshaolin_texiaonpc.g_DemoSkills[760] = "慈航普渡"
oshaolin_texiaonpc.g_DemoSkills[761] = "礼敬如来"
oshaolin_texiaonpc.g_DemoSkills[762] = "一苇渡江"
oshaolin_texiaonpc.g_DemoSkills[763] = "气贯全身"
oshaolin_texiaonpc.g_DemoSkills[764] = "摩诃无量"
oshaolin_texiaonpc.g_DemoSkills[765] = "多罗叶指"
oshaolin_texiaonpc.g_DemoSkills[766] = "金钟罩"
oshaolin_texiaonpc.g_eventList = {752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766}

function oshaolin_texiaonpc:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent])
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshaolin_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return oshaolin_texiaonpc
