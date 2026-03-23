--元宝商店
--普通
local gbk = require "gbk"
local class = require "class"
local script_base = require "script_base"
local yuanbaoshop = class("yuanbaoshop", script_base)
local shoplist = {}
shoplist[1]	= {188, 189, 197}				--大卖场
shoplist[2]	= {150, 254, 255, 178, 198, 193}			--宝石商城,添加"大理宝石斋--149",czf,2009.07.21
shoplist[3]	= {194, 135, 152, 195}			--珍兽商城
shoplist[4]	= {136, 137, 248, 144}				--南北杂货
shoplist[5]	= {120, 247, 181, 145, 182, 134}			--形象广场
shoplist[6]	= {190, 191, 192, 133}				--花舞人间
shoplist[7]	= {146}						--武功秘籍
shoplist[8]	= {156, 157, 158, 159, 160, 161, 162, 163}	--打造图
shoplist[9]	= {149}			--我要更强大
shoplist[10]	= {149}			--我要更有魅力
shoplist[11]	= {149}			--我要打造极品装备
shoplist[12]	= {149}				--我要打造极品珍兽
shoplist[13]	= {149}					--我要移动的更快
shoplist[14]	= {149}			--我要向别人表白
shoplist[15]	= {149}				--我要学习新技能
--绑定元宝店
shoplist[101]	= {209}				--我要学习新技能
shoplist[102]	= {212,211,213,215}				--我要学习新技能
shoplist[103]	= {216}				--我要学习新技能
shoplist[104]	= {217,218}		    --我要学习新技能
function yuanbaoshop:OpenYuanbaoShop(selfid, targetid, shopA, shopB)
    if targetid == -1 then
        if self:GetLevel(selfid) < 15 then
            self:notify_tips(selfid,"此功能只有当您的等级大于等于15级的时候方可使用。")
            return
        end
        self:DispatchYuanbaoShopItem(selfid, shoplist[shopA][shopB])
    else
        self:DispatchNpcYuanbaoShopItem(selfid, targetid, shoplist[shopA][shopB])
    end
end

function yuanbaoshop:yuanbao_pay(selfId, ItemIndex, check, uiindex, hint)
    if check == 1 then
        local index, merchadise = self:GetMerchadiseByItemIndex(selfId, ItemIndex)
        if index == nil then
            return
        end
        local item_name = self:GetItemName(merchadise.id)
        self:BeginUICommand()
        self:UICommand_AddInt(check)
        self:UICommand_AddInt(10)
        self:UICommand_AddInt(5)
        self:UICommand_AddInt(merchadise.price)
        self:UICommand_AddInt(index - 1)
        self:UICommand_AddInt(0)
        self:UICommand_AddInt(-1)
        local str = self:ContactArgs(hint, 1, merchadise.price, 1, item_name) .. "}"
        self:UICommand_AddStr(str)
        self:EndUICommand()
        self:DispatchUICommand(selfId, uiindex)
    else
        local index, merchadise = self:BuyMerchadiseByItemIndex(selfId, ItemIndex)
        if index == nil then
            return
        end
        self:BeginUICommand()
        self:UICommand_AddInt(check)
        self:UICommand_AddInt(10)
        self:UICommand_AddInt(5)
        self:UICommand_AddInt(merchadise.price)
        self:UICommand_AddInt(index - 1)
        self:UICommand_AddInt(0)
        self:UICommand_AddInt(-1)
        self:EndUICommand()
        self:DispatchUICommand(selfId, uiindex)
    end
end

return yuanbaoshop