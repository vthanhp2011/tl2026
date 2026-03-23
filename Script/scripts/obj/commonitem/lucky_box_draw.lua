local class = require "class"
local define = require "define"
local script_base = require "script_base"
local lucky_box_draw = class("lucky_box_draw", script_base)
lucky_box_draw.script_id = 899999
lucky_box_draw.item_id = 38008207

-- （重楼戒[1%]、
-- 重楼玉[1%]、
-- 至尊强化精华[绑]*2[30%]、
-- 武道玄元丹[绑]*5[30%]、
-- 灵级长春玉[绑]*1[4.9%]、
-- 4级棉布[绑]*1[15%]、
-- 4级秘银[绑]*1[15%]、
-- 淬火玉[绑]*1[4.9%]）
-- lucky_box_draw.item = 
-- {
	-- {id = 38008160,num = 2,bind = true,rate = 3000},
	-- {id = 20502004,num = 1,bind = true,rate = 1500},
	-- {id = 20600004,num = 1,bind = true,rate = 490},
	
	-- {id = 10422016,num = 1,bind = true,rate = 1},
	-- {id = 10423024,num = 1,bind = true,rate = 1},
	
	-- {id = 38003055,num = 1,bind = true,rate = 490},
	-- {id = 20501004,num = 1,bind = true,rate = 1500},
	-- {id = 38002397,num = 5,bind = true,rate = 3000},
-- }


-- 幸运盲盒里面几率能开出来（
-- 至尊强化*2绑定几率30%
   -- 武道玄元丹*5绑定30% 
  -- 超级长春玉*1绑定5% 
    -- 4级棉布绑定*1几率15% 
    -- 4级秘银绑定15% 
    -- 淬火玉*1绑定几率5%
  -- 胡萝卜绑定10%
-- 兔子耳朵绑定5%）
lucky_box_draw.item = 
{
	{id = 38008160,num = 2,bind = true,rate = 3000},
	{id = 38002397,num = 5,bind = true,rate = 3000},
	{id = 20600003,num = 1,bind = true,rate = 500},
	{id = 20501004,num = 1,bind = true,rate = 1500},
	{id = 20502004,num = 1,bind = true,rate = 1500},
	{id = 38003055,num = 1,bind = true,rate = 500},
	{id = 20310217,num = 1,bind = true,rate = 1000},
	{id = 10410033,num = 1,bind = true,rate = 500},
}


function lucky_box_draw:OnDefaultEvent(selfId, bagIndex)
end

function lucky_box_draw:IsSkillLikeScript(selfId)
    return 1
end

function lucky_box_draw:CancelImpacts(selfId)
    return 0
end

function lucky_box_draw:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
		self:notify_tips(selfId,"请重试。")
        return 0
    end
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId )
	if useid ~= self.item_id then
		self:notify_tips(selfId,"未开放道具。")
		return 0
	end
    return 1
end

function lucky_box_draw:OnDeplete(selfId)
    -- if (self:LuaFnDepletingUsedItem(selfId)) then
        -- return 1
    -- end
    return 1
end
function lucky_box_draw:OnActivateOnce(selfId)
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId)
	if useid ~= self.item_id then
		self:notify_tips(selfId,"未开放道具。")
		return 0
	end
	local usepos = self:LuaFnGetBagIndexOfUsedItem(selfId)
	if self:LuaFnGetItemTableIndexByIndex(selfId,usepos) ~= useid then
		self:notify_tips(selfId,"道具使用出错。")
		return 0
	elseif self:LuaFnGetPropertyBagSpace(selfId) < 1 then
		self:notify_tips(selfId,"请给道具栏预留1空位。")
		return 0
	elseif self:LuaFnGetMaterialBagSpace(selfId) < 1 then
		self:notify_tips(selfId,"请给材料栏预留1空位。")
		return 0
	end
	local rate_all = 0
	for k,v in ipairs(self.item) do
		rate_all = rate_all + v.rate
		v.rate_cur = rate_all
	end
	local cur_rate = math.random(1,10000)
	local give_id,give_num,give_bind
	for k,v in ipairs(self.item) do
		if cur_rate <= v.rate_cur then
			give_id = v.id
			give_num = v.num
			give_bind = v.bind
			break
		end
	end
	if not give_id or not give_num or not give_bind then
		self:notify_tips(selfId,"未知错误。")
		return 0
	end
	self:LuaFnDecItemLayCount(selfId,usepos,1)
	
	self:BeginAddItem()
	self:AddItem(give_id,give_num,give_bind)
	if not self:EndAddItem(selfId) then
		return
	end
	self:AddItemListToHuman(selfId)
	self:GiveItemTip(selfId,give_id,give_num,18)
	return 1
end

function lucky_box_draw:OnActivateEachTick(selfId)
    return 1
end

return lucky_box_draw
