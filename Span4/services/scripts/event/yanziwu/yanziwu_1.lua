local class = require "class"
local ScriptGlobal = require "scripts.ScriptGlobal"
local define = require "define"
local script_base = require "script_base"
local yanziwu_1 = class("yanziwu_1", script_base)
yanziwu_1.script_id = 401040
yanziwu_1.g_Name = "李纲"
yanziwu_1.TIME_2000_01_03_ = 946828868
yanziwu_1.g_SceneData_1 = 8
yanziwu_1.g_SceneData_3 = 9
yanziwu_1.g_SceneData_4 = 10
yanziwu_1.g_SceneData_5 = 11
yanziwu_1.g_SceneData_6 = 12
yanziwu_1.g_SceneData_7 = 13
yanziwu_1.g_SD_Monster_1 = 14
yanziwu_1.g_SD_Monster_1_T = 15
yanziwu_1.g_SD_Monster_2 = 16
yanziwu_1.g_SD_Monster_2_T = 17
yanziwu_1.g_SD_Monster_3 = 18
yanziwu_1.g_SD_Monster_3_T = 19
yanziwu_1.g_KillMonsCount_Qincheng = 20
yanziwu_1.g_KillMonsCount_Qinjia = 21
yanziwu_1.g_KillMonsCount_Lama = 22
yanziwu_1.g_SkillSign = 23
yanziwu_1.g_bWangyuyanSpeak = 24
yanziwu_1.g_bWangyuyanSpeak_T = 27
yanziwu_1.g_CloseTime = 25
yanziwu_1.g_MissionLost = 26
yanziwu_1.g_SystemTipsTime = 28
yanziwu_1.g_DuanAndWangFlag = 29
yanziwu_1.g_CopySceneName = "燕子坞"
yanziwu_1.g_CopySceneType = ScriptGlobal.FUBEN_DAZHAN_YZW
yanziwu_1.g_CopySceneMap = "yanziwu.nav"
yanziwu_1.g_client_res = 236
yanziwu_1.g_LimitMembers = 3
yanziwu_1.g_TickTime = 1
yanziwu_1.g_LimitTotalHoldTime = 360
yanziwu_1.g_LimitTimeSuccess = 500
yanziwu_1.g_CloseTick = 3
yanziwu_1.g_NoUserTime = 300
yanziwu_1.g_DeadTrans = 0
yanziwu_1.g_Fuben_X = 177
yanziwu_1.g_Fuben_Z = 234
yanziwu_1.g_Back_X = 70
yanziwu_1.g_Back_Z = 120
yanziwu_1.g_Back_SceneId = 4
yanziwu_1.g_Npc_1 = {
    {["id"] = 9210, ["x"] = 175, ["y"] = 202, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 181, ["y"] = 202, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 172, ["y"] = 152, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 173, ["y"] = 158, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 146, ["y"] = 151, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 151, ["y"] = 154, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 137, ["y"] = 177, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 133, ["y"] = 175, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 109, ["y"] = 162, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 104, ["y"] = 164, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 82, ["y"] = 176, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 77, ["y"] = 176, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 53, ["y"] = 157, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 58, ["y"] = 156, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 76, ["y"] = 210, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 80, ["y"] = 210, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 86, ["y"] = 210, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 91, ["y"] = 210, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 211, ["y"] = 146, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 214, ["y"] = 146, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 217, ["y"] = 146, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 220, ["y"] = 146, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9210, ["x"] = 223, ["y"] = 146, ["camp"] = 109, ["ai"] = 21, ["af"] = 222},
    {["id"] = 9240, ["x"] = 175, ["y"] = 152, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 149, ["y"] = 150, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 147, ["y"] = 146, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 135, ["y"] = 174, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 133, ["y"] = 171, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 135, ["y"] = 177, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 105, ["y"] = 161, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 108, ["y"] = 159, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 80, ["y"] = 173, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 81, ["y"] = 177, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 55, ["y"] = 155, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 52, ["y"] = 154, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 58, ["y"] = 155, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9280, ["x"] = 209, ["y"] = 80, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 222, ["y"] = 79, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 218, ["y"] = 69, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 228, ["y"] = 64, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 228, ["y"] = 52, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 217, ["y"] = 39, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 186, ["y"] = 31, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 181, ["y"] = 36, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 176, ["y"] = 42, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 176, ["y"] = 52, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 136, ["y"] = 93, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 140, ["y"] = 88, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 137, ["y"] = 82, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 144, ["y"] = 86, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 143, ["y"] = 101, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 141, ["y"] = 111, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 148, ["y"] = 112, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 146, ["y"] = 103, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9280, ["x"] = 154, ["y"] = 110, ["camp"] = 110, ["ai"] = 21, ["af"] = 239},
    {["id"] = 9290, ["x"] = 234, ["y"] = 30, ["camp"] = 109, ["ai"] = 21, ["af"] = 223},
    {["id"] = 9290, ["x"] = 225, ["y"] = 25, ["camp"] = 109, ["ai"] = 21, ["af"] = 223},
    {["id"] = 9290, ["x"] = 175, ["y"] = 41, ["camp"] = 109, ["ai"] = 21, ["af"] = 223},
    {["id"] = 9290, ["x"] = 179, ["y"] = 45, ["camp"] = 109, ["ai"] = 21, ["af"] = 223},
    {["id"] = 9290, ["x"] = 172, ["y"] = 48, ["camp"] = 109, ["ai"] = 21, ["af"] = 223},
    {["id"] = 9290, ["x"] = 171, ["y"] = 52, ["camp"] = 109, ["ai"] = 21, ["af"] = 223},
    {["id"] = 9290, ["x"] = 170, ["y"] = 57, ["camp"] = 109, ["ai"] = 21, ["af"] = 223},
    {["id"] = 9290, ["x"] = 167, ["y"] = 61, ["camp"] = 109, ["ai"] = 21, ["af"] = 223}
}

yanziwu_1.g_Npc_2 = {
    {["id"] = 9200, ["x"] = 177, ["y"] = 232, ["script"] = 402240, ["camp"] = 109, ["ai"] = 3, ["af"] = -1},
    {["id"] = 9220, ["x"] = 79, ["y"] = 202, ["script"] = 402241, ["camp"] = 109, ["ai"] = 21, ["af"] = 220}
}

yanziwu_1.g_Npc_2_1 = {
    {["id"] = 9210, ["x"] = 171, ["y"] = 236, ["camp"] = 109, ["ai"] = 21, ["af"] = 222, ["script"] = 402262},
    {["id"] = 9210, ["x"] = 175, ["y"] = 236, ["camp"] = 109, ["ai"] = 21, ["af"] = 222, ["script"] = 402262},
    {["id"] = 9210, ["x"] = 179, ["y"] = 236, ["camp"] = 109, ["ai"] = 21, ["af"] = 222, ["script"] = 402262},
    {["id"] = 9210, ["x"] = 183, ["y"] = 236, ["camp"] = 109, ["ai"] = 21, ["af"] = 222, ["script"] = 402262}
}

yanziwu_1.g_Npc_3 = {
    {["id"] = 9340, ["x"] = 81, ["y"] = 197, ["script"] = 402242, ["camp"] = 110, ["ai"] = 21, ["af"] = 227}
}

yanziwu_1.g_Npc_3_1 = {
    {["id"] = 9240, ["x"] = 79, ["y"] = 195, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 77, ["y"] = 207, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 82, ["y"] = 195, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 86, ["y"] = 206, ["camp"] = 110, ["ai"] = 21, ["af"] = 226}
}

yanziwu_1.g_Npc_4 = {
    {["id"] = 9330, ["x"] = 77, ["y"] = 195, ["script"] = 402244, ["camp"] = 110, ["ai"] = 21, ["af"] = 228},
    {["id"] = 9350, ["x"] = 83, ["y"] = 198, ["script"] = 402243, ["camp"] = 110, ["ai"] = 21, ["af"] = 229}
}

yanziwu_1.g_Npc_5 = {
    {["id"] = 9320, ["x"] = 81, ["y"] = 195, ["script"] = 402245, ["camp"] = 110, ["ai"] = 21, ["af"] = 230}
}

yanziwu_1.g_Npc_6 = {
    {["id"] = 9230, ["x"] = 217, ["y"] = 150, ["script"] = 402246, ["camp"] = 109, ["ai"] = 21, ["af"] = 221},
    {["id"] = 9480, ["x"] = 179, ["y"] = 91, ["script"] = 402249, ["camp"] = 109, ["ai"] = 3, ["af"] = -1}
}

yanziwu_1.g_Npc_7 = {
    {
        ["id"] = 9290,
        ["x"] = 210,
        ["y"] = 155,
        ["script"] = 402247,
        ["name"] = "前",
        ["camp"] = 109,
        ["ai"] = 3,
        ["af"] = -1
    },
    {
        ["id"] = 9290,
        ["x"] = 225,
        ["y"] = 138,
        ["script"] = 402247,
        ["name"] = "后",
        ["camp"] = 109,
        ["ai"] = 3,
        ["af"] = -1
    },
    {["id"] = 9300, ["x"] = 225, ["y"] = 155, ["script"] = 402247, ["name"] = "", ["camp"] = 109, ["ai"] = 3, ["af"] = -1},
    {["id"] = 9310, ["x"] = 209, ["y"] = 138, ["script"] = 402247, ["name"] = "", ["camp"] = 109, ["ai"] = 3, ["af"] = -1}
}

yanziwu_1.g_Npc_8 = {
    {["id"] = 9240, ["x"] = 79, ["y"] = 195, ["script"] = -1, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 77, ["y"] = 207, ["script"] = -1, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 82, ["y"] = 195, ["script"] = -1, ["camp"] = 110, ["ai"] = 21, ["af"] = 226},
    {["id"] = 9240, ["x"] = 86, ["y"] = 206, ["script"] = -1, ["camp"] = 110, ["ai"] = 21, ["af"] = 226}
}

yanziwu_1.g_Npc_9 = {
    {
        ["id"] = 9250,
        ["x"] = 233,
        ["y"] = 214,
        ["script"] = 402258,
        ["pp"] = 1,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 231
    },
    {
        ["id"] = 9250,
        ["x"] = 236,
        ["y"] = 214,
        ["script"] = 402258,
        ["pp"] = 2,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 231
    },
    {
        ["id"] = 9250,
        ["x"] = 235,
        ["y"] = 217,
        ["script"] = 402258,
        ["pp"] = 3,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 231
    },
    {
        ["id"] = 9250,
        ["x"] = 238,
        ["y"] = 216,
        ["script"] = 402258,
        ["pp"] = 4,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 231
    },
    {
        ["id"] = 9250,
        ["x"] = 237,
        ["y"] = 219,
        ["script"] = 402258,
        ["pp"] = 5,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 231
    }
}

yanziwu_1.g_Npc_9_1 = {
    {
        ["id"] = 9530,
        ["x"] = 237,
        ["y"] = 219,
        ["script"] = 402259,
        ["pp"] = 5,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 233
    }
}

yanziwu_1.g_Npc_9_2 = {
    {
        ["id"] = 9260,
        ["x"] = 233,
        ["y"] = 214,
        ["script"] = 402257,
        ["pp"] = 1,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 232
    },
    {
        ["id"] = 9260,
        ["x"] = 236,
        ["y"] = 214,
        ["script"] = 402257,
        ["pp"] = 2,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 232
    },
    {
        ["id"] = 9260,
        ["x"] = 235,
        ["y"] = 217,
        ["script"] = 402257,
        ["pp"] = 3,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 232
    },
    {
        ["id"] = 9260,
        ["x"] = 238,
        ["y"] = 216,
        ["script"] = 402257,
        ["pp"] = 4,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 232
    },
    {
        ["id"] = 9260,
        ["x"] = 237,
        ["y"] = 219,
        ["script"] = 402257,
        ["pp"] = 5,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 232
    }
}

yanziwu_1.g_Npc_10 = {
    {
        ["id"] = 9270,
        ["x"] = 233,
        ["y"] = 214,
        ["script"] = 402260,
        ["pp"] = 1,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 234
    },
    {
        ["id"] = 9270,
        ["x"] = 236,
        ["y"] = 214,
        ["script"] = 402260,
        ["pp"] = 2,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 234
    },
    {
        ["id"] = 9270,
        ["x"] = 235,
        ["y"] = 217,
        ["script"] = 402260,
        ["pp"] = 3,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 234
    },
    {
        ["id"] = 9270,
        ["x"] = 238,
        ["y"] = 216,
        ["script"] = 402260,
        ["pp"] = 3,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 234
    },
    {
        ["id"] = 9270,
        ["x"] = 237,
        ["y"] = 219,
        ["script"] = 402260,
        ["pp"] = 3,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 234
    }
}

yanziwu_1.g_Npc_11 = {
    {
        ["id"] = 9360,
        ["x"] = 233,
        ["y"] = 214,
        ["script"] = 402248,
        ["pp"] = 1,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 235
    },
    {
        ["id"] = 9370,
        ["x"] = 233,
        ["y"] = 214,
        ["script"] = 402248,
        ["pp"] = 1,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 236
    },
    {
        ["id"] = 9380,
        ["x"] = 233,
        ["y"] = 214,
        ["script"] = 402248,
        ["pp"] = 1,
        ["camp"] = 110,
        ["ai"] = 21,
        ["af"] = 237
    }
}

yanziwu_1.g_Npc_12 = {
    {["id"] = 9390, ["x"] = 130, ["y"] = 112, ["script"] = 402250, ["camp"] = 0, ["ai"] = 21, ["af"] = 241},
    {["id"] = 9400, ["x"] = 126, ["y"] = 109, ["script"] = 402251, ["camp"] = 0, ["ai"] = 21, ["af"] = 241},
    {["id"] = 9410, ["x"] = 126, ["y"] = 112, ["script"] = 402252, ["camp"] = 0, ["ai"] = 21, ["af"] = 241},
    {["id"] = 9420, ["x"] = 126, ["y"] = 115, ["script"] = 402253, ["camp"] = 0, ["ai"] = 21, ["af"] = 241}
}

yanziwu_1.g_Npc_13 = {
    {["id"] = 9430, ["x"] = 63, ["y"] = 67, ["script"] = 402254, ["camp"] = 110, ["ai"] = 25, ["af"] = 244}
}

yanziwu_1.g_Npc_14 = {
    {["id"] = 9450, ["x"] = 76, ["y"] = 67, ["script"] = 402255, ["camp"] = 0, ["ai"] = 26, ["af"] = -1},
    {["id"] = 9440, ["x"] = 76, ["y"] = 64, ["script"] = 402256, ["camp"] = 0, ["ai"] = 27, ["af"] = 245},
    {["id"] = 9460, ["x"] = 79, ["y"] = 70, ["script"] = 402249, ["camp"] = 0, ["ai"] = 27, ["af"] = 247},
    {["id"] = 9470, ["x"] = 79, ["y"] = 69, ["script"] = 402249, ["camp"] = 0, ["ai"] = 27, ["af"] = 248},
    {["id"] = 9490, ["x"] = 79, ["y"] = 68, ["script"] = 402249, ["camp"] = 0, ["ai"] = 27, ["af"] = 249},
    {["id"] = 9500, ["x"] = 79, ["y"] = 67, ["script"] = 402249, ["camp"] = 0, ["ai"] = 27, ["af"] = 250},
    {["id"] = 9510, ["x"] = 79, ["y"] = 66, ["script"] = 402249, ["camp"] = 0, ["ai"] = 27, ["af"] = 251},
    {["id"] = 9520, ["x"] = 79, ["y"] = 65, ["script"] = 402249, ["camp"] = 0, ["ai"] = 27, ["af"] = 252}
}

yanziwu_1.g_Npc_15 = {}

yanziwu_1.g_Npc_16 = {}

function yanziwu_1:OnDefaultEvent(selfId, targetId, arg, index)
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#{yanziwu_info}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetName(targetId) ~= self.g_Name then
        return
    end
    if self:GetTeamSize(selfId) < 3 then
        self:BeginEvent(self.script_id)
        self:AddText("#B讨伐燕子坞")
        self:AddText("  此战凶险异常，不足3人我可不敢让你们进入。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetTeamLeader(selfId) ~= selfId then
        self:BeginEvent(self.script_id)
        self:AddText("#B讨伐燕子坞")
        self:AddText("  你必须是队长才行。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetTeamSize(selfId) ~= self:GetNearTeamCount(selfId) then
        self:BeginEvent(self.script_id)
        self:AddText("#B讨伐燕子坞")
        self:AddText("  还有队员不在附近。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local nPlayerNum = self:GetNearTeamCount(selfId)
    for i = 1, nPlayerNum do
        local nPlayerId = self:GetNearTeamMember(selfId, i)
        if self:GetLevel(nPlayerId) < 60 then
            self:BeginEvent(self.script_id)
            self:AddText("#B讨伐燕子坞")
            self:AddText("  此战凶险异常，不足60级我可不敢让你们进入。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
    end
    local strName = {}
    strName[1] = ""
    strName[2] = ""
    strName[3] = ""
    strName[4] = ""
    strName[5] = ""
    strName[6] = ""
    local bOk = true
    for i = 1, nPlayerNum do
        local nPlayerId = self:GetNearTeamMember(selfId, i)
        local nTimes = self:GetMissionData(nPlayerId, define.MD_ENUM.MD_YANZIWU_TIMES)
        local nPreTime = self:GetMissionData(nPlayerId, define.MD_ENUM.MD_PRE_YANZIWU_TIME)
        local nCurTime = self:LuaFnGetCurrentTime()
        if(nCurTime - nPreTime >= 3600 * 24) or (math.floor((nCurTime - self.TIME_2000_01_03_) / (3600 * 24)) ~= math.floor((nPreTime - self.TIME_2000_01_03_) / (3600 * 24))) then
            nTimes = 0
            nPreTime = nCurTime
            self:SetMissionData(nPlayerId, define.MD_ENUM.MD_YANZIWU_TIMES, nTimes)
            self:SetMissionData(nPlayerId, define.MD_ENUM.MD_PRE_YANZIWU_TIME, nPreTime)
        end
        if nTimes >= 3 then
            bOk = false
            strName[i] = self:GetName(nPlayerId)
        end
    end
    local nCount = 0
    if not bOk then
        local szAllName = ""
        for i = 1, 6 do
            if strName[i] ~= "" then
                if nCount == 0 then
                    szAllName = strName[i]
                else
                    szAllName = szAllName .. "、" .. strName[i]
                end
                nCount = nCount + 1
            end
        end
        self:BeginEvent(self.script_id)
        self:AddText("#B讨伐燕子坞")
        self:AddText("  你的队伍中" .. szAllName .. "今天已经参加过3次讨伐燕子坞战役。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:MakeCopyScene(selfId)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
end

function yanziwu_1:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:GetName(targetId) == self.g_Name then
        caller:AddNumTextWithTarget(self.script_id, "讨伐燕子坞", 10, -1)
        caller:AddNumTextWithTarget(self.script_id, "关于讨伐燕子坞", 8, 1)
    end
end

function yanziwu_1:CheckAccept(selfId)
end

function yanziwu_1:AskEnterCopyScene(selfId)
end

function yanziwu_1:OnAccept(selfId, targetId)
end

function yanziwu_1:AcceptEnterCopyScene(selfId)
end

function yanziwu_1:MakeCopyScene(selfId)
    local param0 = 4
    local param1 = 3
    local mylevel
    local memId
    local level0 = 0
    local level1 = 0
    local nearmembercount = self:GetNearTeamCount(selfId)
    for i = 1, nearmembercount do
        memId = self:GetNearTeamMember(selfId, i)
        local tempMemlevel = self:GetLevel(memId)
        level0 = level0 + (tempMemlevel ^ param0)
        level1 = level1 + (tempMemlevel ^ param1)
    end
    if level1 == 0 then
        mylevel = 0
    else
        mylevel = level0 / level1
    end
    if nearmembercount == -1 then
        mylevel = self:GetLevel(selfId)
    end
    local leaderguid = self:LuaFnObjId2Guid(selfId)
    local config = {}
    config.navmapname = self.g_CopySceneMap
    config.client_res = self.g_client_res
    config.teamleader = leaderguid
    config.NoUserCloseTime = 0
	config.Timer = self.g_TickTime * 1000
    config.params = {}
	config.params[0] = self.g_CopySceneType
    config.params[1] = self.script_id
	config.params[2] = 0
    config.params[3] = -1
    config.params[4] = 0
    config.params[5] = 0
	config.params[6] = self:GetTeamId(selfId)
	config.params[7] = 0
    for i = 8, 31 do
        config.params[i] = 0
    end
    config.params[self.g_SceneData_7] = mylevel
    config.eventfile = "yanziwu_area.ini"
	config.monsterfile = "yanziwu_monster.ini"
    config.patrolpoint = "yanziwu_patrolpoint.ini"
    config.sn = self:LuaFnGenCopySceneSN()

	local bRetSceneID = self:LuaFnCreateCopyScene(config)
	local text
	if bRetSceneID > 0 then
		text = "副本创建成功！"
	else
		text = "副本数量已达上限，请稍候再试！"
	end
	self:notify_tips(selfId, text)
end

function yanziwu_1:OnCopySceneReady(destsceneId)
	local sceneId = self:get_scene_id()
	self:LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId)
    local leaderguid = self:LuaFnGetCopySceneData_TeamLeader(destsceneId)
    local leaderObjId = self:LuaFnGuid2ObjId(leaderguid)
	if not self:LuaFnIsCanDoScriptLogic(leaderObjId) then
		return
	end
    if not self:LuaFnHasTeam(leaderObjId) then
        self:GotoScene(leaderObjId, destsceneId)
    else
        if not self:IsCaptain(leaderObjId) then
            self:GotoScene(leaderObjId, destsceneId)
        else
            local nearteammembercount = self:GetNearTeamCount(leaderObjId)
            local mems = {}
            for i = 1, nearteammembercount do
                mems[i] = self:GetNearTeamMember(leaderObjId, i)
                self:GotoScene(mems[i], destsceneId)
            end
        end
    end
end

function yanziwu_1:GotoScene(ObjId, destsceneId)
    local sn = self:LuaFnGetCopySceneData_Sn(destsceneId)
    self:NewWorld(ObjId, destsceneId, sn, self.g_Fuben_X, self.g_Fuben_Z, self.g_client_res)
end

function yanziwu_1:OnPlayerEnter(selfId)
    self:SetUnitCampID(selfId, 109)
    self:SetPlayerDefaultReliveInfo(selfId, 1, 1, 0, self.g_Fuben_X, self.g_Fuben_Z)
    local nTimes = self:GetMissionData(selfId, define.MD_ENUM.MD_YANZIWU_TIMES)
    local nCurTime = self:LuaFnGetCurrentTime()
    self:SetMissionData(selfId, define.MD_ENUM.MD_YANZIWU_TIMES, nTimes + 1)
    self:SetMissionData(selfId, define.MD_ENUM.MD_PRE_YANZIWU_TIME, nCurTime)
    self:DungeonDone(selfId, 7)
end

function yanziwu_1:OnHumanDie(selfId, killerId)
end

function yanziwu_1:OnAbandon(selfId)
end

function yanziwu_1:OnContinue(selfId, targetId)
end

function yanziwu_1:CheckSubmit(selfId, selectRadioId)
end

function yanziwu_1:OnSubmit(selfId, targetId, selectRadioId)
end

function yanziwu_1:OnDie(objId, killerId)
end

function yanziwu_1:TipAllHuman(Str)
    local nHumanNum = self:LuaFnGetCopyScene_HumanCount()
    if nHumanNum < 1 then
        return
    end
    for i = 1, nHumanNum do
        local PlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
        self:BeginEvent(self.script_id)
        self:AddText(Str)
        self:EndEvent()
        self:DispatchMissionTips(PlayerId)
    end
end

function yanziwu_1:OnKillObject(selfId, objdataId, objId)
    local name = self:GetMonsterNamebyDataId(objdataId)
    if name == "慕容复" then
        local num = self:LuaFnGetCopyScene_HumanCount()
        local mems = {}
        for i = 1, num do
            mems[i] = self:LuaFnGetCopyScene_HumanObjId(i)
            self:LuaFnAddSweepPointByID(mems[i], 7, 8)
        end
    end
end

function yanziwu_1:OnEnterZone(selfId, zoneId)
end

function yanziwu_1:OnItemChanged(selfId, itemdataId)
end

function yanziwu_1:SystemTips(nStep)
    if nStep == 1 then
        self:TipAllHuman("有高手要刺杀呼延豹将军")
        self:TipAllHuman("请使用轻功从荷叶飞跃到水军旗舰上去保护他")
    elseif nStep == 2 then
        self:TipAllHuman("有大批武林高手要赶来增援慕容反贼")
        self:TipAllHuman("请迅速赶至阻截点协助钱宏宇将军阻击反贼援军")
    elseif nStep == 3 then
        self:TipAllHuman("有大批武林高手要赶来增援慕容反贼")
        self:TipAllHuman("请迅速赶至阻截点协助钱宏宇将军阻击反贼援军")
    end
end

function yanziwu_1:OnCopySceneTimer(nowTime)
    local nStep = self:LuaFnGetCopySceneData_Param(self.g_SceneData_1)
    if nStep == 13 then
        return
    end
    local nTime = self:LuaFnGetCurrentTime()
    if nStep == 0 then
        self:CreateMonster_1()
    end
    local nPreSystemTime = self:LuaFnGetCopySceneData_Param(self.g_SystemTipsTime)
    if nStep == 1 then
        if nTime - nPreSystemTime >= 15 then
            self:SystemTips(1)
            self:LuaFnSetCopySceneData_Param(self.g_SystemTipsTime, nTime)
        end
    end
    if nStep == 2 then
        self:CreateMonster_2()
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_1, 3)
    end
    if nStep == 4 then
        self:CreateMonster_3()
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_1, 5)
    end
    if nStep == 6 then
        self:CreateMonster_5()
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_1, 7)
    end
    if nStep == 9 then
        self:ClearMonsterByName("一品堂武士")
        self:TipAllHuman("段延庆战败，手下及一品堂武士纷纷逃走。")
        self:ClearMonsterByName("叶二娘")
        self:ClearMonsterByName("云中鹤")
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_1, 10)
    end
    nPreSystemTime = self:LuaFnGetCopySceneData_Param(self.g_SystemTipsTime)
    if nStep == 10 then
        if nTime - nPreSystemTime >= 5 then
            self:SystemTips(2)
            self:LuaFnSetCopySceneData_Param(self.g_SystemTipsTime, nTime)
        end
    end
    if nStep == 11 then
        local nStep1 = self:LuaFnGetCopySceneData_Param(self.g_SD_Monster_2)
        local nPreTime = self:LuaFnGetCopySceneData_Param(self.g_SD_Monster_2_T)
        if nStep1 == 0 then
            local nNpcNum = self:GetMonsterCount()
            for i = 1, nNpcNum do
                local nNpcId = self:GetMonsterObjID(i)
                if self:GetName(nNpcId) == "钱宏宇" then
                    self:SetMonsterFightWithNpcFlag(nNpcId, 1)
                end
            end
        end
        if nStep1 < 10 then
            if nTime - nPreTime >= 10 then
                self:LuaFnSetCopySceneData_Param(self.g_SD_Monster_2, nStep1 + 1)
                self:LuaFnSetCopySceneData_Param(self.g_SD_Monster_2_T, nTime)
                self:CreateMonster_7_1()
                self:CreateMonster_7_3()
                self:TipAllHuman("警惕！第" .. nStep1 + 1 .. "波燕子坞援军已经赶至，还有" .. 25 - (nStep1 + 1) .. "波燕子坞援军即将赶来。")
                if nStep1 == 9 then
                    self:CreateMonster_8(1)
                end
            end
        end
        if nStep1 == 10 then
            if nTime - nPreTime >= 30 then
                self:LuaFnSetCopySceneData_Param(self.g_SD_Monster_2, nStep1 + 1)
            end
        end
        if nStep1 >= 11 and nStep1 < 21 then
            if nTime - nPreTime >= 20 then
                self:LuaFnSetCopySceneData_Param(self.g_SD_Monster_2, nStep1 + 1)
                self:LuaFnSetCopySceneData_Param(self.g_SD_Monster_2_T, nTime)
                self:CreateMonster_7_4()
                self:CreateMonster_7_3()
                self:TipAllHuman("警惕！第" .. nStep1 .. "波燕子坞援军已经赶至，还有" .. 25 - (nStep1) .. "波燕子坞援军即将赶来。")
                if nStep1 == 20 then
                    self:CreateMonster_8(2)
                end
            end
        end
        if nStep1 == 21 then
            if nTime - nPreTime >= 30 then
                self:LuaFnSetCopySceneData_Param(self.g_SD_Monster_2, nStep1 + 1)
            end
        end
        if nStep1 >= 22 and nStep1 < 27 then
            if nTime - nPreTime >= 30 then
                self:LuaFnSetCopySceneData_Param(self.g_SD_Monster_2, nStep1 + 1)
                self:LuaFnSetCopySceneData_Param(self.g_SD_Monster_2_T, nTime)
                self:CreateMonster_7_2()
                self:TipAllHuman("警惕！第" .. nStep1 - 1 .. "波燕子坞援军已经赶至，还有" .. 25 - (nStep1 - 1) .. "波燕子坞援军即将赶来。")
                if nStep1 == 26 then
                    self:CreateMonster_8(3)
                    self:LuaFnSetCopySceneData_Param(self.g_SceneData_1, 12)
                end
            end
        end
    end
    if nStep == 12 then
        local nNpcNum = self:GetMonsterCount()
        local bOK = false
        for i = 1, nNpcNum do
            local nNpcId = self:GetMonsterObjID(i)
            if self:GetName(nNpcId) == "钱宏宇" then
                bOK = true
            end
        end
        if bOK then
            self:LuaFnSetCopySceneData_Param(self.g_SceneData_1, 15)
            self:CreateMonster_9()
            self:CreateMonster_10()
            self:CreateMonster_11()
            self:CreateMonster_13()
        else
            self:LuaFnSetCopySceneData_Param(self.g_SceneData_1, 501)
        end
    end
    local nLost = self:LuaFnGetCopySceneData_Param(self.g_MissionLost)
    if nLost == 500 then
        self:CallScriptFunction((200060), "Paopao", "呼延庆", "燕子坞", "由于呼延豹将军战败，该次讨伐行动失利，我们退回去，待重整旗鼓再来。")
        self:LuaFnSetCopySceneData_Param(self.g_MissionLost, 1000)
    end
    if nLost == 501 then
        self:CallScriptFunction((200060), "Paopao", "呼延庆", "燕子坞", "由于钱宏宇将军战败，该次讨伐行动失利，我们退回去，待重整旗鼓再来。")
        self:LuaFnSetCopySceneData_Param(self.g_MissionLost, 1000)
    end
    local nCloaeTime = self:LuaFnGetCopySceneData_Param(self.g_CloseTime)
    if nLost == 1000 then
        self:TipAllHuman("副本将在30秒后关闭。")
        self:LuaFnSetCopySceneData_Param(self.g_CloseTime, nTime)
        self:LuaFnSetCopySceneData_Param(self.g_MissionLost, nLost + 1)
    end
    if nLost == 1001 and nTime - nCloaeTime >= 15 then
        self:TipAllHuman("副本将在15秒后关闭。")
        self:LuaFnSetCopySceneData_Param(self.g_CloseTime, nTime)
        self:LuaFnSetCopySceneData_Param(self.g_MissionLost, nLost + 1)
    end
    if nLost == 1002 and nTime - nCloaeTime >= 10 then
        self:TipAllHuman("副本将在5秒后关闭。")
        self:LuaFnSetCopySceneData_Param(self.g_CloseTime, nTime)
        self:LuaFnSetCopySceneData_Param(self.g_MissionLost, nLost + 1)
    end
    if nLost == 1003 and nTime - nCloaeTime >= 5 then
        local nHumanNum = self:LuaFnGetCopyScene_HumanCount()
        for i = 1, nHumanNum do
            local nPlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
            self:NewWorld(nPlayerId, self.g_Back_SceneId, nil, self.g_Back_X, self.g_Back_Z)
        end
        self:LuaFnSetCopySceneData_Param(self.g_CloseTime, nTime)
        self:LuaFnSetCopySceneData_Param(self.g_MissionLost, nLost + 1)
    end
    local jianta1 = self:LuaFnGetCopySceneData_Param(self.g_SceneData_3)
    if jianta1 >= 5 and jianta1 < 1000 then
        self:ChangeNpc("前连弩塔")
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_3, jianta1 + 1000)
    end
    local jianta2 = self:LuaFnGetCopySceneData_Param(self.g_SceneData_4)
    if jianta2 >= 5 and jianta2 < 1000 then
        self:ChangeNpc("后连弩塔")
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_4, jianta2 + 1000)
    end
    local jianta3 = self:LuaFnGetCopySceneData_Param(self.g_SceneData_5)
    if jianta3 >= 10 and jianta3 < 1000 then
        self:ChangeNpc("治疗塔")
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_5, jianta3 + 1000)
    end
    local jianta4 = self:LuaFnGetCopySceneData_Param(self.g_SceneData_6)
    if jianta4 >= 5 and jianta4 < 1000 then
        self:ChangeNpc("守御塔")
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_6, jianta4 + 1000)
    end
    if nStep >= 11 then
        if nTime - nPreSystemTime >= 5 then
            self:LuaFnSetCopySceneData_Param(self.g_SystemTipsTime, nTime)
            if jianta1 > 1000 then
                local nNpcId = self:NameToId("前连弩塔")
                if nNpcId >= 0 then
                    if self:GetHp(nNpcId) > 0 then
                        local x
                        local z
                        x = self:GetWorldPos(nNpcId)
                        self:LuaFnUnitUseSkill(nNpcId, 1008, nNpcId, x, z, 10, 0)
                    end
                end
            end
            if jianta2 > 1000 then
                local nNpcId = self:NameToId("后连弩塔")
                if nNpcId >= 0 then
                    if self:GetHp(nNpcId) > 0 then
                        local x
                        local z
                        x = self:GetWorldPos(nNpcId)
                        self:LuaFnUnitUseSkill(nNpcId, 1008, nNpcId, x, z, 10, 0)
                    end
                end
            end
            if jianta3 > 1000 then
                local nNpcId = self:NameToId("治疗塔")
                if nNpcId >= 0 then
                    if self:GetHp(nNpcId) > 0 then
                        local x
                        local z
                        x = self:GetWorldPos(nNpcId)
                        self:LuaFnUnitUseSkill(nNpcId, 1010, nNpcId, x, z, 10, 0)
                    end
                end
            end
            if jianta4 > 1000 then
                local nNpcId = self:NameToId("守御塔")
                if nNpcId >= 0 then
                    if self:GetHp(nNpcId) > 0 then
                        local x
                        local z
                        x = self:GetWorldPos(nNpcId)
                        self:LuaFnUnitUseSkill(nNpcId, 1009, nNpcId, x, z, 10, 0)
                    end
                end
            end
        end
    end
    local bSpeak = self:LuaFnGetCopySceneData_Param(self.g_bWangyuyanSpeak)
    local nSpeakTime = self:LuaFnGetCopySceneData_Param(self.g_bWangyuyanSpeak_T)
    if bSpeak == 1 then
        self:CallScriptFunction((200060), "Paopao", "王语嫣", "燕子坞", "段公子，你能去帮帮我表哥吗？")
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak, 2)
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak_T, nTime)
    elseif bSpeak == 2 and nTime - nSpeakTime >= 1 then
        self:CallScriptFunction((200060), "Paopao", "段誉", "燕子坞", "王姑娘有命，在下自是万死莫辞了。#70")
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak, 3)
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak_T, nTime)
        local nNpcNum = self:GetMonsterCount()
        for i = 1, nNpcNum do
            local nNpcId = self:GetMonsterObjID(i)
            if self:GetName(nNpcId) == "段誉" then
                self:SetMonsterFightWithNpcFlag(nNpcId, 1)
                self:SetUnitCampID(nNpcId, 110)
                self:SetNPCAIType(nNpcId, 27)
                self:SetAIScriptID(nNpcId, 245)
            end
            if self:GetName(nNpcId) == "王语嫣" then
                self:SetMonsterFightWithNpcFlag(nNpcId, 0)
                self:SetUnitCampID(nNpcId, 110)
            end
        end
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak, 3)
    elseif bSpeak == 3 and nTime - nSpeakTime >= 20 then
        self:CallScriptFunction((200060), "Paopao", "段誉", "燕子坞", "#18#18#18王姑娘，真是不好意思，你看我这六脉神剑时灵时不灵的，现在怎么也伤不了人……")
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak, 4)
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak_T, nTime)
    elseif bSpeak == 4 and nTime - nSpeakTime >= 1 then
        self:CallScriptFunction((200060), "Paopao", "王语嫣", "燕子坞", "#20#20#20又来这套……还是我自己来帮表哥。")
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak, 5)
        self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak_T, nTime)
    elseif bSpeak == 5 then
        if nTime - nSpeakTime >= 10 then
            self:GiveDirections()
            self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak_T, nTime)
        end
    end
    bSpeak = self:LuaFnGetCopySceneData_Param(self.g_DuanAndWangFlag)
    if bSpeak == 1 then
        self:CallScriptFunction((200060), "Paopao", "王语嫣", "燕子坞", "表哥，救我！")
        self:CallScriptFunction((200060), "Paopao", "段誉", "燕子坞", "王姑娘，我来救你！")
        local nNpcNum = self:GetMonsterCount()
        for i = 1, nNpcNum do
            local nNpcId = self:GetMonsterObjID(i)
            if self:GetName(nNpcId) == "段誉" then
                self:SetMonsterFightWithNpcFlag(nNpcId, 1)
                self:SetUnitCampID(nNpcId, 110)
                self:SetAIScriptID(nNpcId, 246)
            end
        end
        self:LuaFnSetCopySceneData_Param(self.g_DuanAndWangFlag, 2)
    end
end

function yanziwu_1:NameToId(szName)
    local nNpcId = -1
    local nMonsterNum = self:GetMonsterCount()
    for i = 1, nMonsterNum do
        local nMonsterId = self:GetMonsterObjID(i)
        if self:GetName(nMonsterId) == szName then
            nNpcId = nMonsterId
        end
    end
    return nNpcId
end

function yanziwu_1:CreateMonster_1()
    if self:LuaFnGetCopySceneData_Param(self.g_SceneData_1) == 0 then
        for i, Npc in pairs(self.g_Npc_1) do
            local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], -1)
            local szName = self:GetName(nNpcId)
            self:SetUnitCampID(nNpcId, Npc["camp"])
            if szName == "宋军士兵" then
                self:SetMonsterFightWithNpcFlag(nNpcId, 1)
            elseif szName == "一品堂武士" then
                self:SetMonsterFightWithNpcFlag(nNpcId, 1)
            elseif szName == "燕子坞家丁" then
                self:SetMonsterFightWithNpcFlag(nNpcId, 1)
            end
        end
        for i, Npc in pairs(self.g_Npc_2) do
            local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
            self:SetUnitCampID(nNpcId, Npc["camp"])
            self:SetMonsterFightWithNpcFlag(nNpcId, 0)
        end
        for i, Npc in pairs(self.g_Npc_2_1) do
            local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
            self:SetUnitCampID(nNpcId, Npc["camp"])
            self:SetMonsterFightWithNpcFlag(nNpcId, 0)
        end
        for i, Npc in pairs(self.g_Npc_6) do
            local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
            self:SetUnitCampID(nNpcId, Npc["camp"])
            self:SetMonsterFightWithNpcFlag(nNpcId, 0)
        end
        for i, Npc in pairs(self.g_Npc_7) do
            local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
            self:SetUnitCampID(nNpcId, Npc["camp"])
            self:SetMonsterFightWithNpcFlag(nNpcId, 0)
            local szName = self:GetName(nNpcId)
            self:SetCharacterName(nNpcId, Npc["name"] .. szName)
        end
        self:LuaFnSetCopySceneData_Param(self.g_SceneData_1, 1)
    end
end

function yanziwu_1:CreateMonster_2()
    for i, Npc in pairs(self.g_Npc_3) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
        if self:GetName(nNpcId) == "岳老三" then
            self:LuaFnNpcChat(nNpcId, 0, "狗官，我岳老二来杀你啦，赶紧把脑袋伸过来，让我哢嚓一声拧断你的脖子。")
        end
    end
    self:CreateMonster_6()
    local nNpcNum = self:GetMonsterCount()
    for i = 1, nNpcNum do
        local nNpcId = self:GetMonsterObjID(i)
        if self:GetName(nNpcId) == "呼延豹" then
            self:SetMonsterFightWithNpcFlag(nNpcId, 1)
            return
        end
    end
end

function yanziwu_1:CreateMonster_3()
    for i, Npc in pairs(self.g_Npc_4) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
    end
    self:CreateMonster_6()
end

function yanziwu_1:CreateMonster_5()
    for i, Npc in pairs(self.g_Npc_5) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
    end
    self:CreateMonster_6()
end

function yanziwu_1:ChangeNpc(szName)
    local nNpcNum = self:GetMonsterCount()
    for i = 1, nNpcNum do
        local nNpcId = self:GetMonsterObjID(i)
        if self:GetName(nNpcId) == szName then
            self:SetUnitCampID(nNpcId, 109)
            self:SetMonsterFightWithNpcFlag(nNpcId, 1)
            self:LuaFnNpcChat(nNpcId, 0, szName .. "我被修理好了。")
        end
    end
end

function yanziwu_1:CreateMonster_6()
    for i, Npc in pairs(self.g_Npc_8) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
    end
end

function yanziwu_1:CreateMonster_7_1()
    for i, Npc in pairs(self.g_Npc_9) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
        self:SetPatrolId(nNpcId, Npc["pp"])
    end
end

function yanziwu_1:CreateMonster_7_3()
    for i, Npc in pairs(self.g_Npc_9_1) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
        self:SetPatrolId(nNpcId, Npc["pp"])
    end
end

function yanziwu_1:CreateMonster_7_4()
    for i, Npc in pairs(self.g_Npc_9_2) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
        self:SetPatrolId(nNpcId, Npc["pp"])
    end
end

function yanziwu_1:CreateMonster_7_2()
    for i, Npc in pairs(self.g_Npc_10) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
        self:SetPatrolId(nNpcId, Npc["pp"])
    end
end

function yanziwu_1:CreateMonster_8(nIndex)
    local Npc = self.g_Npc_11[nIndex]
    local nNpcId
    if nIndex == 3 then
        nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
    else
        nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
    end
    self:SetUnitCampID(nNpcId, Npc["camp"])
    self:SetMonsterFightWithNpcFlag(nNpcId, 1)
    self:SetPatrolId(nNpcId, Npc["pp"])
end

function yanziwu_1:CreateMonster_9()
    for i, Npc in pairs(self.g_Npc_12) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterGroupID(nNpcId, 99)
    end
end

function yanziwu_1:CreateMonster_10()
    for i, Npc in pairs(self.g_Npc_13) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
    end
    local SceneNum = self:LuaFnGetCopyScene_HumanCount()
    for i = 1, SceneNum do
        local humanObjId = self:LuaFnGetCopyScene_HumanObjId(i)
        self:LuaFnAddMissionHuoYueZhi(humanObjId, 12)
        self:LuaFnAddSweepPointByID(humanObjId, 7, 1)
    end
end

function yanziwu_1:CreateMonster_11()
    for i, Npc in pairs(self.g_Npc_14) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        --self:SetMonsterFightWithNpcFlag(nNpcId, 1)
    end
end

function yanziwu_1:CreateMonster_12()
    for i, Npc in pairs(self.g_Npc_15) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
    end
end

function yanziwu_1:CreateMonster_13()
    for i, Npc in pairs(self.g_Npc_16) do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["y"], Npc["ai"], Npc["af"], Npc["script"])
        self:SetUnitCampID(nNpcId, Npc["camp"])
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
    end
end

function yanziwu_1:ClearMonsterByName(szName)
    local nMonsterNum = self:GetMonsterCount()
    for i = 1, nMonsterNum do
        local nMonsterId = self:GetMonsterObjID(i)
        if self:GetName(nMonsterId) == szName then
            self:LuaFnDeleteMonster(nMonsterId)
        end
    end
end

function yanziwu_1:GiveDirections()
    local nWangId = -1
    local nMonsterNum = self:GetMonsterCount()
    for i = 1, nMonsterNum do
        local nMonsterId = self:GetMonsterObjID(i)
        if self:GetName(nMonsterId) == "王语嫣" then
            nWangId = nMonsterId
        end
    end
    if nWangId == -1 then
        return
    end
    local nHumanCount = self:LuaFnGetCopyScene_HumanCount()
    local nRand = math.random(1, nHumanCount)
    local nHumanId = self:LuaFnGetCopyScene_HumanObjId(nRand)
    self:LuaFnSendSpecificImpactToUnit(nWangId, nWangId, nHumanId, 10188, 2000)
    local szHumanName = self:GetName(nHumanId)
    local str1 = "王语嫣把目光投向了#H【" .. szHumanName .. "】"
    local str = self:GetDirectionsDesc(self:GetMenPai(nHumanId))
    self:CallScriptFunction((200060), "Paopao", "王语嫣", "燕子坞", str)
    self:TipAllHuman(str1)
end

function yanziwu_1:CreateNpc(NpcId, x, y, Ai, AiFile, Script)
    local PlayerLevel = self:LuaFnGetCopySceneData_Param(self.g_SceneData_7)
    local ModifyLevel = 0
    if PlayerLevel >= 10 then
        ModifyLevel = 1
    end
    if PlayerLevel >= 20 then
        ModifyLevel = 2
    end
    if PlayerLevel >= 30 then
        ModifyLevel = 3
    end
    if PlayerLevel >= 40 then
        ModifyLevel = 4
    end
    if PlayerLevel >= 50 then
        ModifyLevel = 5
    end
    if PlayerLevel >= 60 then
        ModifyLevel = 6
    end
    if PlayerLevel >= 70 then
        ModifyLevel = 7
    end
    if PlayerLevel >= 80 then
        ModifyLevel = 8
    end
    if PlayerLevel >= 90 then
        ModifyLevel = 9
    end
    if PlayerLevel >= 100 then
        ModifyLevel = 30001
    end
    if PlayerLevel >= 110 then
        ModifyLevel = 30002
    end
    if PlayerLevel >= 120 then
        ModifyLevel = 30003
    end
    if PlayerLevel >= 130 then
        ModifyLevel = 30004
    end
    if PlayerLevel >= 140 then
        ModifyLevel = 30005
    end
    local nNpcId = NpcId + ModifyLevel - 1
    local nMonsterId = self:LuaFnCreateMonster(nNpcId, x, y, Ai, AiFile, Script)
    self:SetLevel(nMonsterId, PlayerLevel)
    self:SetNpcTitle(nMonsterId)
    return nMonsterId
end

function yanziwu_1:GetDirectionsDesc(MenpaiId)
    local str = ""
    if MenpaiId == 0 then
        str = "表哥，少林弟子的弱点在大椎穴！"
    elseif MenpaiId == 1 then
        str = "表哥，明教弟子的弱点在灵台穴！"
    elseif MenpaiId == 2 then
        str = "表哥，丐帮弟子的弱点在悬枢穴！"
    elseif MenpaiId == 3 then
        str = "表哥，武当弟子的弱点在百会穴！"
    elseif MenpaiId == 4 then
        str = "表哥，峨嵋弟子的弱点在神庭穴！"
    elseif MenpaiId == 5 then
        str = "表哥，星宿弟子的弱点在太阳穴！"
    elseif MenpaiId == 6 then
        str = "表哥，天龙弟子的弱点在膻中穴！"
    elseif MenpaiId == 7 then
        str = "表哥，天山弟子的弱点在鸠尾穴！"
    elseif MenpaiId == 8 then
        str = "表哥，逍遥弟子的弱点在商曲穴！"
    end
    return str
end

function yanziwu_1:SetNpcTitle(nNpcId)
    local szName = self:GetName(nNpcId)
    if szName == "呼延庆" then
        self:SetCharacterTitle(nNpcId, "太湖水军大都督")
    elseif szName == "呼延豹" then
        self:SetCharacterTitle(nNpcId, "水军先锋")
    elseif szName == "钱宏宇" then
        self:SetCharacterTitle(nNpcId, "苏州校尉")
    elseif szName == "岳老三" then
        self:SetCharacterTitle(nNpcId, "“凶神恶煞”")
    elseif szName == "叶二娘" then
        self:SetCharacterTitle(nNpcId, "“无恶不作”")
    elseif szName == "云中鹤" then
        self:SetCharacterTitle(nNpcId, "“穷凶极恶”")
    elseif szName == "段延庆" then
        self:SetCharacterTitle(nNpcId, "“恶贯满盈”")
    elseif szName == "姚伯当" then
        self:SetCharacterTitle(nNpcId, "秦家寨寨主")
    elseif szName == "司马林" then
        self:SetCharacterTitle(nNpcId, "青城派掌门")
    elseif szName == "鸠摩智" then
        self:SetCharacterTitle(nNpcId, "大轮明王")
    elseif szName == "慕容复" then
        self:SetCharacterTitle(nNpcId, "“斗转星移”")
    end
end

function yanziwu_1:CalSweepData(selfId)
    local nTimes = self:GetMissionData(selfId, define.MD_ENUM.MD_YANZIWU_TIMES)
    local nCurTime = self:LuaFnGetCurrentTime()
    self:SetMissionData(selfId, define.MD_ENUM.MD_YANZIWU_TIMES, nTimes + 1)
    self:SetMissionData(selfId, define.MD_ENUM.MD_PRE_YANZIWU_TIME, nCurTime)
end

return yanziwu_1