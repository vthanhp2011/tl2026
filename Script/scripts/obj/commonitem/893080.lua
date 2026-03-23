local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local soul_materials = { 38002515, 38002516, 38002517, 38002518, 38002519}
function common_item:OnDefaultEvent(selfId, bagIndex)

end

function common_item:IsSkillLikeScript(selfId)
    return 1
end

function common_item:CancelImpacts(selfId)
    return 0
end

function common_item:OnUIClickCallBack(selfId,nBagPos,nCount)
    local nItemId = self:LuaFnGetItemTableIndexByIndex(selfId,nBagPos)
    if nItemId ~= 38002499 then
        self:notify_tips(selfId,"未开放道具")
        return
    end
    local Count = self:LuaFnGetAvailableItemCount(selfId,nItemId)
    if Count < nCount then
        self:notify_tips(selfId,"请重新打开神魂檀箱进行批量开启。")
        return
    end
    if nCount > 100 then
        nCount = 100
    end
    local BagSpace = self:LuaFnGetPropertyBagSpace(selfId)
    if BagSpace < 6 then
        self:notify_tips(selfId,"道具栏至少需要6个格子以上的空间")
        return
    end
    self:BeginAddItem()
    for i = 1,nCount do
        self:AddItem(38002530, 4, true)
        local n = math.random(#soul_materials)
        self:AddItem(soul_materials[n], 1, true)
    end
    local ret = self:EndAddItem(selfId)
    if ret then
        self:AddItemListToHuman(selfId)
        self:LuaFnDelAvailableItem(selfId,nItemId,nCount)
        self:notify_tips(selfId,"批量开启成功，请查看背包。")
    else
        self:notify_tips(selfId,"背包空间不足，请清理背包后再使用。")
        return
    end
end

function common_item:OnConditionCheck(selfId)
    if not self:LuaFnVerifyUsedItem(selfId) then
        return 0
    end
    local BagSpace = self:LuaFnGetPropertyBagSpace(selfId)
    if BagSpace < 6 then
        self:notify_tips(selfId,"道具栏至少需要6个格子以上的空间")
        return
    end
    local bag_index = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local nItemId = self:LuaFnGetItemTableIndexByIndex(selfId,bag_index)
    local nCount = self:LuaFnGetAvailableItemCount(selfId,nItemId)
    if nCount >= 20 then
        self:BeginUICommand()
		self:UICommand_AddStr(string.format("#cfff263您当前拥有#G%s个#cfff263神魂檀箱，点击确定即可批量开启，最多一次批量开启#G100个#cfff263神魂檀箱，批量开启不会影响几率。",nCount))
        self:UICommand_AddStr("OnUIClickCallBack")
		self:UICommand_AddInt(893080)
		self:UICommand_AddInt(bag_index)
		self:UICommand_AddInt(nCount)
        self:EndUICommand()
	    self:DispatchUICommand(selfId,2023100910)
        return 0
    end
    self:BeginAddItem()
    self:AddItem(38002530, 4, true)
    local n = math.random(#soul_materials)
    self:AddItem(soul_materials[n], 1, true)
    local ret = self:EndAddItem(selfId)
    if not ret then
        return 0
    end
    return self:LuaFnVerifyUsedItem(selfId)
end

function common_item:OnDeplete(selfId)
    return 1
end

function common_item:OnActivateOnce(selfId)
    local BagSpace = self:LuaFnGetPropertyBagSpace(selfId)
    if BagSpace < 6 then
        self:notify_tips(selfId,"道具栏至少需要6个格子以上的空间")
        return
    end
    local bag_index = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local item_index = self:LuaFnGetItemTableIndexByIndex(selfId, bag_index)
    if item_index ~= 38002499 then
        self:notify_tips(selfId, "使用道具异常,请稍候再试")
        return
    end
    local item_count = self:GetBagItemLayCount(selfId, bag_index)
    if item_count <= 0 then
        self:notify_tips(selfId, "使用道具异常,请稍候再试")
        return
    end
    self:BeginAddItem()
    self:AddItem(38002530, 4, true)
    local n = math.random(#soul_materials)
    self:AddItem(soul_materials[n], 1, true)
    local ret = self:EndAddItem(selfId)
    if ret then
        self:AddItemListToHuman(selfId)
        self:LuaFnDecItemLayCount(selfId, bag_index, 1)
    end
    return 1
end

function common_item:OnActivateEachTick(selfId)
    return 1
end

return common_item
