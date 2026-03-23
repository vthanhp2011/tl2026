-- 时装点缀镶嵌
-- 普通
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local packet_def = require "game.packet"
local human_item_logic = require "human_item_logic"
local script_base = require "script_base"
local dress_gem_embed = class("dress_gem_embed", script_base)
local MAT_ITEM_INDEX = 30503135
function dress_gem_embed:OnDress_Enchase(selfId, equip_index, gem_index, mat_index)
    print("dress_gem_embed:OnDress_Enchase =", selfId, gem_index, equip_index, mat_index)
    local gem = self:GetBagItem(selfId, gem_index)
    local equip = self:GetBagItem(selfId, equip_index)
    local mat = self:GetBagItem(selfId, mat_index)
    if gem == nil or gem:get_serial_class() ~= define.ITEM_CLASS.ICLASS_GEM then
        self:notify_tips(selfId, "#{SZPR_XML_40}")
        return
    end
    if equip == nil or equip:get_serial_class() ~=
        define.ITEM_CLASS.ICLASS_EQUIP then
        self:notify_tips(selfId, "#{SZPR_XML_39}")
        return
    end
    if mat == nil or mat:get_index() ~= MAT_ITEM_INDEX then
        self:notify_tips(selfId, "#{SZPR_XML_41}")
        return
    end
	local gemid = gem:get_index()
	local gemval1 = gemid % 100000
	local gemtype = math.floor(gemval1 / 1000)
	if gemtype < 31 or gemtype > 33 then
        self:notify_tips(selfId, "请放入点缀石")
        return
    end
	local e_pointx = equip:get_base_config().equip_point
	if e_pointx ~= define.HUMAN_EQUIP.HEQUIP_FASHION then
		obj_me:notify_tips("该装备并非时装哦")
		return
	end
    local location = self:get_gem_location(equip)
    if location == define.INVAILD_ID then
        self:notify_tips(selfId, "没有空的镶嵌位置")
        return
    end
    local slot_count = equip:get_equip_data():get_slot_count()
    if slot_count < location then
        self:notify_tips(selfId, "#{SZPSZY_160314_27}")
        return
    end
    local szTransferItem = self:GetBagItemTransfer(selfId, gem_index)
    local obj = self.scene:get_obj_by_id(selfId)
    local logparam = {}
    local del = human_item_logic:dec_item_lay_count(logparam, obj, gem_index, 1)
	if not del then
        self:notify_tips(selfId, "宝石扣除失败")
        return
    end
    del = human_item_logic:dec_item_lay_count(logparam, obj, mat_index, 1)
	if not del then
        self:notify_tips(selfId, "材料扣除失败")
        return
    end
    equip:get_equip_data():gem_embed(location, gemid)
    self:refix_equip_gem_count(equip)
    local msg = packet_def.GCItemInfo.new()
    msg.bagIndex = equip_index
    msg.item = equip:copy_raw_data()
    self.scene:send2client(selfId, msg)

    local name = self:GetName(selfId)
    local szTransferEquip = self:GetBagItemTransfer(selfId, equip_index)
    local fmt = gbk.fromutf8(
                    "#W#{_INFOUSR%s}#H向#W#{_INFOMSG%s}#H镶嵌了一颗#W#{_INFOMSG%s}#H，大幅的提升了装备的能力。")
    local message = string.format(fmt, gbk.fromutf8(name), szTransferEquip,
                                  szTransferItem)
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    self:BroadMsgByChatPipe(selfId, message, 4)
end

function dress_gem_embed:get_gem_location(equip)
    local gem_list = equip:get_equip_data():get_gem_list()
    for i = 1, 3 do
        if gem_list[i] == 0 then
            return i
        end
    end
    return define.INVAILD_ID
end

function dress_gem_embed:refix_equip_gem_count(equip)
    local gem_count = 0
    local gem_list = equip:get_equip_data():get_gem_list()
    for i = 1, 3 do
        if gem_list[i] > 0 then
            gem_count = gem_count + 1
        end
    end
    equip:get_equip_data():set_gem_count(gem_count)
end

return dress_gem_embed
