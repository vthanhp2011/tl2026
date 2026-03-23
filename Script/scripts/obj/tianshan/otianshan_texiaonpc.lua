local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianshan_texiaonpc = class("otianshan_texiaonpc", script_base)
otianshan_texiaonpc.script_id = 801008
otianshan_texiaonpc.g_DemoSkills = {}

otianshan_texiaonpc.g_DemoSkills[865] = "落木萧萧"
otianshan_texiaonpc.g_DemoSkills[866] = "望梅止渴"
otianshan_texiaonpc.g_DemoSkills[867] = "阳关三叠"
otianshan_texiaonpc.g_DemoSkills[868] = "阳奉阴违"
otianshan_texiaonpc.g_DemoSkills[869] = "阳歌天钧"
otianshan_texiaonpc.g_DemoSkills[870] = "阳春白雪"
otianshan_texiaonpc.g_DemoSkills[871] = "踏雪无痕"
otianshan_texiaonpc.g_DemoSkills[872] = "龟息功"
otianshan_texiaonpc.g_DemoSkills[873] = "唇亡齿寒"
otianshan_texiaonpc.g_DemoSkills[874] = "十面埋伏"
otianshan_texiaonpc.g_DemoSkills[875] = "越俎代庖"
otianshan_texiaonpc.g_DemoSkills[876] = "归去来兮"
otianshan_texiaonpc.g_DemoSkills[877] = "凭虚御风"
otianshan_texiaonpc.g_DemoSkills[878] = "静影沉璧"
otianshan_texiaonpc.g_DemoSkills[879] = "大象无形"
otianshan_texiaonpc.g_eventList = {865, 866, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879}

function otianshan_texiaonpc:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent])
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function otianshan_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return otianshan_texiaonpc
