local gbk = require "gbk"
local define = require "define"
local class = require "class"
local script_base = require "script_base"
local chuan_song_system = class("chuan_song_system", script_base)

local enum_menpai = define.MENPAI_ATTRIBUTE
local  g_mpInfo		= {}
g_mpInfo[0]	= { "少林",  9,  96, 127, 9, enum_menpai.MATTRIBUTE_SHAOLIN }
g_mpInfo[1]	= { "明教", 11,  98, 167, 11, enum_menpai.MATTRIBUTE_MINGJIAO } 
g_mpInfo[2]	= { "丐帮", 10,  91, 116, 10, enum_menpai.MATTRIBUTE_GAIBANG }
g_mpInfo[3]	= { "武当", 12, 103, 140, 12, enum_menpai.MATTRIBUTE_WUDANG } 
g_mpInfo[4]	= { "峨嵋", 15,  89, 139, 15, enum_menpai.MATTRIBUTE_EMEI } 
g_mpInfo[5]	= { "星宿", 16,  96, 152, 16, enum_menpai.MATTRIBUTE_XINGXIU }
g_mpInfo[6]	= { "天龙", 13,  96, 120, 13, enum_menpai.MATTRIBUTE_DALI }
g_mpInfo[7]	= { "天山", 17,  95, 120, 17, enum_menpai.MATTRIBUTE_TIANSHAN }
g_mpInfo[8]	= { "逍遥", 14,  67, 145, 14, enum_menpai.MATTRIBUTE_XIAOYAO }
g_mpInfo[10] = { "曼陀山庄", 184, 139, 162, 592, enum_menpai.MATTRIBUTE_MANTUOSHANZHUANG}
function chuan_song_system:OnDefaultEvent(selfId, targetId)
    print("selfId, targetId =", selfId, targetId)
    local npcName = self:GetName(targetId)
    print("npcName =", npcName)
    self:BeginEvent(self.script_id)
        self:AddText("#{XIYU_20071228_01}")
        self:AddNumText("返回门派", 9, 1000)
        if self:GetName(targetId) ~= "吴德昌" and self:GetName(targetId) ~= "汪旱" then
            self:AddNumText("城市 - 洛阳", 9, 1001)
        end
        if self:GetName(targetId) ~= "李乘风" and self:GetName(targetId) ~= "邓茂" then
            self:AddNumText("城市 - 苏州", 9, 1002)
        end
        if self:GetName(targetId) ~= "吴德昌" and self:GetName(targetId) ~= "汪旱" then
            self:AddNumText("城市 - 洛阳 - 九州商会", 9, 1006)
        end
        if self:GetName(targetId) ~= "李乘风" and self:GetName(targetId) ~= "邓茂" then
            self:AddNumText("城市 - 苏州 - 铁匠铺", 9, 1007)
        end
        if self:GetName(targetId) ~= "崔逢九" then
            self:AddNumText("城市 - 大理", 9, 1010)
        end
        if self:GetName(targetId) ~= "艾尼瓦尔" then
            self:AddNumText("城市 - 楼兰", 9, 1011)
        end
        if self:GetName(targetId) ~= "徐霞客" then
            self:AddNumText("城市 - 束河古镇", 9, 1014)
        end
        self:AddNumText("带我去其它门派", 9, 1012)
        self:AddNumText("#{YZZY_091225_1}", 11, 1013)
        self:AddNumText("我怎样才能去敦煌和嵩山", 11, 2000)
		if npcName == "崔逢九" then
			self:CallScriptFunction(210279, "OnEnumerate", self, selfId, targetId)
		end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function chuan_song_system:OnEventRequest(selfId, targetId, arg, index)
    -- 返回门派
    if index == 1000 then
        local menpai = self:GetMenPai(selfId)
        local con = g_mpInfo[menpai]
        if self:LuaFnGetDestSceneHumanCount(con[2]) < 200 then
            self:CallScriptFunction((400900), "TransferFunc", selfId, con[2], con[3], con[4])
        else
            self:notify_tips(selfId,"目标场景人数已满")
        end
        return
    end
    -- 洛阳
    if index == 1001 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 132, 183,10)
        return
    end
    -- 苏州
    if index == 1002 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 114, 162,10)
        return
    end
    -- 洛阳-九州商会
    if index == 1006 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 234, 132,10)
        return
    end
    -- 苏州-铁匠铺
    if index == 1007 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 235, 132,10)
        return
    end
    -- 大理
    if index == 1010 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 2, 242, 137)
        return
    end
    -- 楼兰
    if index == 1011 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 186, 288, 136,75)
        return
    end
    -- 束河古镇
    if index == 1014 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 420, 200, 211,10)
        return
    end
    -- 带我去其他门派
    if index == 1012 then
        self:BeginEvent(self.script_id)
            for i = 0, 10 do
                local menpai = g_mpInfo[i]
                if menpai then
                    self:AddNumText("门派 - " .. menpai[1], 9, i)
                end
            end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if index >= 0 and index <= 1000 then
        local menpai = index
        local info = g_mpInfo[menpai]
        if self:LuaFnGetDestSceneHumanCount(info[2]) < 200 then
            self:CallScriptFunction((400900), "TransferFunc", selfId, info[2], info[3], info[4])
        else
            self:notify_tips(selfId,"目标场景人数已满")
        end
        return
    end
	if self:GetName(targetId) == "崔逢九" then
		self:CallScriptFunction(210279, "OnDefaultEvent", selfId, targetId, arg, index)
	end
end
function chuan_song_system:OnMissionAccept(selfId, targetId, missionScriptId)
	if self:GetName(targetId) == "崔逢九" then
		local ret = self:CallScriptFunction(210279, "CheckAccept", selfId)
		if ret > 0 then
			self:CallScriptFunction(210279, "OnAccept", selfId)
		end
	end
end

function chuan_song_system:OnMissionContinue(selfId, targetId, missionScriptId)
	if self:GetName(targetId) == "崔逢九" then
		self:CallScriptFunction(210279, "OnContinue", selfId, targetId)
	end
end

function chuan_song_system:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
	if self:GetName(targetId) == "崔逢九" then
		self:CallScriptFunction(210279, "OnSubmit", selfId, targetId, selectRadioId)
	end
end

return chuan_song_system
