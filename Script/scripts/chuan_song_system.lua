local gbk = require "gbk"
local define = require "define"
local class = require "class"
local script_base = require "script_base"
local chuan_song_system = class("chuan_song_system", script_base)

local enum_menpai = define.MENPAI_ATTRIBUTE
local  g_mpInfo	= {
	{ "门派 - 恶人谷", 1063, 125, 152, 703, enum_menpai.MATTRIBUTE_ERENGU},
	{ "门派 - 曼陀", 184, 139, 162, 592, enum_menpai.MATTRIBUTE_MANTUOSHANZHUANG},
	{ "门派 - 星宿", 16,  96, 152, 16, enum_menpai.MATTRIBUTE_XINGXIU },
	{ "门派 - 逍遥", 14,  67, 145, 14, enum_menpai.MATTRIBUTE_XIAOYAO },
	{ "门派 - 少林",  9,  96, 127, 9, enum_menpai.MATTRIBUTE_SHAOLIN },
	{ "门派 - 天山", 17,  95, 120, 17, enum_menpai.MATTRIBUTE_TIANSHAN },
	{ "门派 - 天龙", 13,  96, 120, 13, enum_menpai.MATTRIBUTE_DALI },
	{ "门派 - 峨嵋", 15,  89, 139, 15, enum_menpai.MATTRIBUTE_EMEI },
	{ "门派 - 武当", 12, 103, 140, 12, enum_menpai.MATTRIBUTE_WUDANG },
	{ "门派 - 明教", 11,  98, 167, 11, enum_menpai.MATTRIBUTE_MINGJIAO },
	{ "门派 - 丐帮", 10,  91, 116, 10, enum_menpai.MATTRIBUTE_GAIBANG },
}
-- g_mpInfo[0]	= { "少林",  9,  96, 127, 9, enum_menpai.MATTRIBUTE_SHAOLIN }
-- g_mpInfo[1]	= { "明教", 11,  98, 167, 11, enum_menpai.MATTRIBUTE_MINGJIAO } 
-- g_mpInfo[2]	= { "丐帮", 10,  91, 116, 10, enum_menpai.MATTRIBUTE_GAIBANG }
-- g_mpInfo[3]	= { "武当", 12, 103, 140, 12, enum_menpai.MATTRIBUTE_WUDANG } 
-- g_mpInfo[4]	= { "峨嵋", 15,  89, 139, 15, enum_menpai.MATTRIBUTE_EMEI } 
-- g_mpInfo[5]	= { "星宿", 16,  96, 152, 16, enum_menpai.MATTRIBUTE_XINGXIU }
-- g_mpInfo[6]	= { "天龙", 13,  96, 120, 13, enum_menpai.MATTRIBUTE_DALI }
-- g_mpInfo[7]	= { "天山", 17,  95, 120, 17, enum_menpai.MATTRIBUTE_TIANSHAN }
-- g_mpInfo[8]	= { "逍遥", 14,  67, 145, 14, enum_menpai.MATTRIBUTE_XIAOYAO }
-- g_mpInfo[10] = { "曼陀山庄", 184, 139, 162, 592, enum_menpai.MATTRIBUTE_MANTUOSHANZHUANG}
-- g_mpInfo[11] = { "恶人谷", 1063, 125, 152, 703, enum_menpai.MATTRIBUTE_ERENGU}
function chuan_song_system:OnDefaultEvent(selfId, targetId)
    print("selfId, targetId =", selfId, targetId)
    local npcName = self:GetName(targetId)
    print("npcName =", npcName)
    self:BeginEvent(self.script_id)
        self:AddText("#{XIYU_20071228_01}")
        self:AddNumText("返回门派", 9, 1000)
        if self:GetName(targetId) ~= "吴德昌" and self:GetName(targetId) ~= "汪旱" then
            self:AddNumText("城市 - 洛阳", 9, 1001)
            --self:AddNumText("城市 - 洛阳 - 2", 9, 2001)
			--self:AddNumText("城市 - 洛阳 - 3", 9, 2020)
			--self:AddNumText("城市 - 洛阳 - 4", 9, 2021)
        end
        if self:GetName(targetId) ~= "李乘风" and self:GetName(targetId) ~= "邓茂" then
            self:AddNumText("城市 - 苏州", 9, 1002)
            --self:AddNumText("城市 - 苏州 - 2", 9, 2002)
        end
        if self:GetName(targetId) ~= "吴德昌" and self:GetName(targetId) ~= "汪旱" then
            self:AddNumText("城市 - 洛阳 -九州商会", 9, 1006)
        end
        if self:GetName(targetId) ~= "李乘风" and self:GetName(targetId) ~= "邓茂" then
            self:AddNumText("城市 - 苏州 - 铁匠铺", 9, 1007)
        end
        if self:GetName(targetId) ~= "崔逢九" then
            self:AddNumText("城市 - 大理", 9, 1010)
            --self:AddNumText("城市 - 大理 - 2", 9, 3011)
        end
        if self:GetName(targetId) ~= "艾尼瓦尔" then
            self:AddNumText("城市 - 楼兰", 9, 1011)
        end
        if self:GetName(targetId) ~= "徐霞客" then
            self:AddNumText("城市 - 束河古镇", 9, 1014)
        end
		self:AddNumText("城市 - 昆吾", 9, -999)
        self:AddNumText("带我去其它门派", 9, 1012)
		if npcName == "崔逢九" then
			self:CallScriptFunction(210279, "OnEnumerate", self, selfId, targetId)
		end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function chuan_song_system:OnEventRequest(selfId, targetId, arg, index)
	local nExYuanBao = self:GetMissionData(selfId,388) // 3000
	
    -- 返回门派
    if index == 1000 then
        local menpai = self:GetMenPai(selfId)
		local con
		for k,v in ipairs(g_mpInfo) do
			if v[6] == menpai then
				con = v
				break
			end
		end
		if not con then
			self:notify_tips(selfId,"您尚未加入门派。")
			return
		end
        if self:LuaFnGetDestSceneHumanCount(con[2]) < 130 then
            self:CallScriptFunction((400900), "TransferFunc", selfId, con[2], con[3], con[4])
        else
            self:notify_tips(selfId,"目标场景人数已满")
        end
        return
    end
    if index == 1001 then
		--if nExYuanBao >= 10 then
			--self:CallScriptFunction((400900), "TransferFunc", selfId, 1316, 132, 183,10)
			--return
		--end
        if self:LuaFnGetDestSceneHumanCount(0) < 700 then
            self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 132, 183,10)
        else
            self:notify_tips(selfId,"目标场景人数已满")
        end
        return
    end
    if index == 2001 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1311, 132, 183,10)
        return
    end
    if index == 2020 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1315, 132, 183,10)
        return
    end
    if index == 2021 then
        --self:CallScriptFunction((400900), "TransferFunc", selfId, 1316, 132, 183,10)
        --return
    end
    if index == 3001 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1315, 132, 183,10)
        return
    end
    if index == 4001 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1316, 132, 183,10)
        return
    end
    -- 苏州
    if index == 1002 then
		--if nExYuanBao >= 10 then
		--	self:CallScriptFunction((400900), "TransferFunc", selfId, 1312, 114, 162,10)
		--	return
		--end
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 114, 162,10)
        return
    end
    if index == 2002 then
        --self:CallScriptFunction((400900), "TransferFunc", selfId, 1312, 114, 162,10)
        --return
    end
    -- 洛阳-九州商会
    if index == 1006 then
		--if nExYuanBao >= 10 then
		--	self:CallScriptFunction((400900), "TransferFunc", selfId, 1316, 234, 132,10)
		--	return
		--end
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 234, 132,10)
        return
    end
    if index == 2006 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1311, 234, 132,10)
        return
    end
    if index == 3006 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1315, 234, 132,10)
        return
    end
    if index == 4006 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1316, 234, 132,10)
        return
    end
    -- 苏州-铁匠铺
    if index == 1007 then
		--if nExYuanBao >= 10 then
		--	self:CallScriptFunction((400900), "TransferFunc", selfId, 1312, 235, 132,10)
		--	return
		--end
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 235, 132,10)
        return
    end
    if index == 2007 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1312, 235, 132,10)
        return
    end
    -- 大理
    if index == 1010 then
		--if nExYuanBao >= 10 then
        --self:CallScriptFunction((400900), "TransferFunc", selfId, 71, 242, 137)
        --return
		--end
        self:CallScriptFunction((400900), "TransferFunc", selfId, 2, 242, 137)
        return
    end
    -- 大理
    if index == 3011 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 71, 242, 137)
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
			for idx,mpinfo in ipairs(g_mpInfo) do
				self:AddNumText(mpinfo[1], 9, idx)
			end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if index >= 0 and index <= 1000 then
        local info = g_mpInfo[index]
		if info then
			if self:LuaFnGetDestSceneHumanCount(info[2]) < 130 then
				self:CallScriptFunction((400900), "TransferFunc", selfId, info[2], info[3], info[4])
			else
				self:notify_tips(selfId,"目标场景人数已满")
			end
		end
        return
    end
    if index == 2010 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 2, 242, 137)
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
