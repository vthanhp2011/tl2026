local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omingjiao_texiaonpc = class("omingjiao_texiaonpc", script_base)
omingjiao_texiaonpc.script_id = 801002
omingjiao_texiaonpc.g_DemoSkills = {}

omingjiao_texiaonpc.g_DemoSkills[768] = "催心裂脾"
omingjiao_texiaonpc.g_DemoSkills[769] = "玄阴至阳"
omingjiao_texiaonpc.g_DemoSkills[770] = "天地同寿"
omingjiao_texiaonpc.g_DemoSkills[771] = "五星连珠"
omingjiao_texiaonpc.g_DemoSkills[772] = "火星冲日"
omingjiao_texiaonpc.g_DemoSkills[773] = "七星落长空"
omingjiao_texiaonpc.g_DemoSkills[774] = "神行百变"
omingjiao_texiaonpc.g_DemoSkills[775] = "指鹿为马"
omingjiao_texiaonpc.g_DemoSkills[776] = "偷梁换柱"
omingjiao_texiaonpc.g_DemoSkills[777] = "迁怒于人"
omingjiao_texiaonpc.g_DemoSkills[778] = "怒发冲冠"
omingjiao_texiaonpc.g_DemoSkills[779] = "雷霆之怒"
omingjiao_texiaonpc.g_DemoSkills[780] = "义愤填膺"
omingjiao_texiaonpc.g_DemoSkills[781] = "厚积薄发"
omingjiao_texiaonpc.g_DemoSkills[782] = "金石俱焚"
omingjiao_texiaonpc.g_eventList = {768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782}

function omingjiao_texiaonpc:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎光临。请选择想要观看的技能。")
    for nIdx, nEvent in pairs(self.g_eventList) do
        self:AddNumText(self.g_DemoSkills[nEvent])
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function omingjiao_texiaonpc:OnEventRequest(selfId, targetId, arg, index)
    self:LuaFnUnitUseSkill(selfId, index, targetId, 1, 0, 0, 0, 0)
end

return omingjiao_texiaonpc
