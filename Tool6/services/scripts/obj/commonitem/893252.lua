local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)

local default_transports = {
    ["0"] = { sceneid = 401, x = 223, y = 225},
    ["1"] = { sceneid = 402, x = 131, y = 128},
    ["2"] = { sceneid = 161, x = 13, y = 25},
    ["3"] = { sceneid = 165, x = 25, y = 108},
}
--传送场景等级限制
local LimitTransScene =
{
    {186,75},
    {424,90},
    {520,90},
    {423,90},
    {519,90},
    {425,90},
    {427,90},
    {433,90},
    {434,90},
    {431,90},
    {432,90},
    {201,90},
    {202,90},
    {400,30},
    {401,30},
    {402,30},
    {1299,90},
    {159,21},
    {160,21},
    {161,21},
    {162,21},
    {163,21},
    {164,21},
    {165,21},
    {166,21},
    {167,21},
    {158,20},
}
function common_item:IsSkillLikeScript()
    return 1
end

function common_item:CancelImpacts()
    return 0
end

function common_item:OnConditionCheck(selfId)
	if not self:LuaFnVerifyUsedItem(selfId) then
		return 0
	end
    local BagPos = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local use_times = self:GetCheDiFuLuUseTimes(selfId, BagPos)
    if use_times <= 0 then
        self:notify_tips(selfId, "剩余符咒数量不足1点")
        return 0
    end
    local index = self:GetCheDiFuLuDataSelectIndex(selfId)
    local data = self:GetCheDiFuLuData(selfId, index)
    if data == nil then
        data = default_transports[index]
    end
    for _,tmp in ipairs(LimitTransScene) do
        if data.sceneid == tmp[1] and self:GetLevel(selfId) < tmp[2] then
            self:notify_tips(selfId,"此场景需要"..tmp[2].."级以上方可入内")
            return 0
        end
    end
    if self:GetLevel(selfId) < 10 then
        self:notify_tips(selfId,"此场景需要10级以上方可入内")
        return 0
    end
    return 1
end

function common_item:OnDeplete(selfId)
    return self:LuaFnDepletingUsedItem(selfId)
end

function common_item:OnActivateOnce(selfId)
    local BagPos = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local use_times = self:GetCheDiFuLuUseTimes(selfId, BagPos)
    if use_times <= 0 then
        self:notify_tips(selfId, "剩余符咒数量不足1点")
        return
    end
    local index = self:GetCheDiFuLuDataSelectIndex(selfId)
    print("index =", index)
    local data = self:GetCheDiFuLuData(selfId, index)
    print("data =", data)
    if data == nil then
        data = default_transports[index]
    end
    if data.sceneid == self:GetSceneID() then
        self:TelePort(selfId, data.x, data.y)
    else
        self:CallScriptFunction((400900), "TransferFunc", selfId, data.sceneid, data.x, data.y)
    end
    self:UpdateCheDiFuLuUseTimes(selfId, BagPos,-1) 
    return 1
end

function common_item:SetUISelIdx(selfId, arg1, arg2)
    print("common_item:SetUISelIdx =", selfId, arg1, arg2)
    self:SetCheDiFuLuDataSelectIndex(selfId, arg2)
end

function common_item:SetPosition(selfId, bag_index, arg2)
    local position = self:GetPosition(selfId)
    local scenid = self:GetSceneID()
    if scenid > define.COPY_SCENE_BEGIN then
        self:notify_tips(selfId, "副本不能定位!")
        return
    end
    self:SetCheDiFuLuData(selfId, arg2, scenid, position)
end

local fuzhous = { 30008123, 30008124 }
function common_item:AddFuZhou(selfId, BagPos)
    local count = self:LuaFnMtl_GetCostNum(selfId, fuzhous)
    local use_times = self:GetCheDiFuLuUseTimes(selfId, BagPos)
    if use_times >= 50 then
        self:notify_tips(selfId, "#{WPKC_141107_04}")
        return
    end
    if count < 1 then
        self:notify_tips(selfId, "#{DJTS_110509_28}")
        local CostNum = 0
        local nIndex = 0
        if self:GetBindYuanBao(selfId) >= 110 then
            nIndex = 1
        elseif self:GetBindYuanBao(selfId) >= 0 and self:GetBindYuanBao(selfId) < 110 then
            nIndex = 2
        end
            self:BeginUICommand()
            if nIndex == 1 then
                self:UICommand_AddInt(1)
                self:UICommand_AddInt(BagPos)
            elseif nIndex == 2 then
                CostNum = 110 - self:GetBindYuanBao(selfId)
                self:UICommand_AddInt(2)
                self:UICommand_AddInt(BagPos)
                self:UICommand_AddInt(self:GetBindYuanBao(selfId))
                self:UICommand_AddInt(CostNum)
            end
            self:EndUICommand()
            self:DispatchUICommand(selfId, 20141106)
        return
    end
    self:UpdateCheDiFuLuUseTimes(selfId, BagPos, 10)
    self:LuaFnMtl_CostMaterial(selfId, 1, fuzhous)
end
function common_item:YuanbaoBind_AddFuZhou(selfId, BagPos)
    if not BagPos or BagPos < 0 then
        return
    end
    local use_times = self:GetCheDiFuLuUseTimes(selfId, BagPos)
    if use_times >= 50 then
        self:notify_tips(selfId, "#{WPKC_141107_04}")
        return
    end
    if self:GetBindYuanBao(selfId) <= 0 then
        self:notify_tips(selfId,"#{WPKC_141107_07}")
        return
    end
    self:LuaFnCostBindYuanBao(selfId,410)
    self:UpdateCheDiFuLuUseTimes(selfId,BagPos,10)
    self:notify_tips(selfId,"#{WPKC_141107_05}")
end

function common_item:Yuanbao_AddFuZhou(selfId, BagPos)
    if not BagPos or BagPos < 0 then
        return
    end
    local use_times = self:GetCheDiFuLuUseTimes(selfId, BagPos)
    if use_times >= 50 then
        self:notify_tips(selfId, "#{WPKC_141107_04}")
        return
    end
    if self:GetBindYuanBao(selfId) + self:GetYuanBao(selfId) < 410 then
        self:notify_tips(selfId,"#{WPKC_141107_07}")
        return
    end
    local nCostNum = 0
    if self:GetBindYuanBao(selfId) > 0 then
        nCostNum = 410 - self:GetBindYuanBao(selfId)
        self:LuaFnCostBindYuanBao(selfId,self:GetBindYuanBao(selfId))
        self:LuaFnCostYuanBao(selfId,nCostNum)
        self:UpdateCheDiFuLuUseTimes(selfId,BagPos,10)
        self:notify_tips(selfId,"#{WPKC_141107_05}")
    else
        self:LuaFnCostYuanBao(selfId,410)
        self:UpdateCheDiFuLuUseTimes(selfId,BagPos,10)
        self:notify_tips(selfId,"#{WPKC_141107_05}")
    end
end

return common_item