local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqianzhuang_yuanbao = class("oqianzhuang_yuanbao", script_base)
oqianzhuang_yuanbao.script_id = 181000
oqianzhuang_yuanbao.g_buyrate = 5
oqianzhuang_yuanbao.g_shoptableindex = 120
oqianzhuang_yuanbao.g_zengdianshop = 121
oqianzhuang_yuanbao.g_goodact = 1
oqianzhuang_yuanbao.g_buyact = 2
oqianzhuang_yuanbao.g_ticketact = 3
oqianzhuang_yuanbao.g_zdianact = 4
oqianzhuang_yuanbao.g_gotodali = 5
oqianzhuang_yuanbao.g_normalzdianshop = 6
oqianzhuang_yuanbao.g_lv1zdianshop = 7
oqianzhuang_yuanbao.g_lv2zdianshop = 8
oqianzhuang_yuanbao.g_lv3zdianshop = 9
oqianzhuang_yuanbao.g_lv4zdianshop = 10
oqianzhuang_yuanbao.g_lv5zdianshop = 11
oqianzhuang_yuanbao.g_lv6zdianshop = 12
oqianzhuang_yuanbao.g_lv7zdianshop = 13
oqianzhuang_yuanbao.g_lv8zdianshop = 14
oqianzhuang_yuanbao.g_lv9zdianshop = 15
oqianzhuang_yuanbao.g_lv10zdianshop = 16
oqianzhuang_yuanbao.g_leave = 20
oqianzhuang_yuanbao.g_return = 21
oqianzhuang_yuanbao.g_rate = 5
oqianzhuang_yuanbao.g_shoptableindexs = {121, 122, 123, 124, 125, 126, 127}
function oqianzhuang_yuanbao:OnDefaultEvent(selfId, targetId)
    local nCurPrize = self:GetMissionData(selfId,390)
    local tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
    self:BeginEvent(self.script_id)
    local strText = "    有钱能使鬼推磨，虽然江湖当中以武力为上，但是有了元宝可能会使原来很多比较难办的事情变得简单起来，您想做些什么呢？"
    self:AddText(strText)
    self:AddNumText("#{CZHL_200916_04}", 2, 101)
    self:AddNumText("将点数兑换成元宝", 2, self.g_buyact)
    self:AddNumText("将元宝兑换成元宝票", 2, self.g_ticketact)
    --打开乾鼎商店条件
    local Isopen = 0
    for i = 1,8 do
        if tPirzeFlag[i] == 2 then
        else
            Isopen = i
            break
        end
    end

    if Isopen == 0 then
        self:AddNumText("#{CZHL_200916_63}",7,1000)
        self:AddNumText("#{CZHL_200916_64}",11,2000)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oqianzhuang_yuanbao:OnEventRequest(selfId, targetId, arg, index)
    if index == self.g_buyact then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(self.g_buyrate)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2001)
        self:CallScriptFunction(define.PRIZE_SCRIPT_ID, "AskPoint", selfId)
    elseif index == self.g_return then
        self:OnDefaultEvent(selfId, targetId)
    elseif index == self.g_goodact then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(1)
        self:UICommand_AddInt(1)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 888902)
    elseif index == self.g_ticketact then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2002)
    elseif index == self.g_leave then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    elseif index == 101 then
        self:CallScriptFunction(180001,"OpenTopChongZhi",selfId,targetId)
    elseif index == 1000 then
            local i = os.date("%j") % (#self.g_shoptableindexs) + 1
            self:DispatchShopItem(selfId, targetId, self.g_shoptableindexs[i])
            return
    elseif index == 2000 then
        self:BeginEvent(self.script_id)
        self:AddText("#{CZHL_200916_65}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oqianzhuang_yuanbao:AskOpenDuihuanWindow(selfId,index)
    if index == 1 then
        self:BeginUICommand()
        self:UICommand_AddStr("http://youxi.huiyoupay.com/Pay/?GroupKey=522117bb3bfb8f6d6f6031c36aecb63e")
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2023120201)
        return
    end
    if index == 2 then
        if self:GetMenPai(selfId) == 9 then
            self:notify_tips(selfId,"仅可在加入门派后，方可兑换元宝。")
            return
        end
        local sceneId = self:GetSceneID()
        if sceneId ~= 151 and sceneId ~= 0 and sceneId ~= 1 and sceneId ~= 2 and sceneId ~= 1300 and sceneId ~= 1301 and sceneId ~= 1302 then
            self:notify_tips(selfId,"仅处于洛阳、苏州、大理时，方可兑换元宝。")
            return
        end
        self:BeginUICommand()
        self:UICommand_AddInt(define.INVAILD_ID)
        self:UICommand_AddInt(self.g_buyrate)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2001)
        self:CallScriptFunction(define.PRIZE_SCRIPT_ID, "AskPoint", selfId)
    end
end

function oqianzhuang_yuanbao:BuyYuanbao(selfId, nYuanBao )
	--购买元宝
	if nYuanBao then
		if nYuanBao > 0 and nYuanBao <= 4000000 then
			self:CallScriptFunction(define.PRIZE_SCRIPT_ID, "BuyYuanBao", selfId, nYuanBao, self.g_buyrate)
		end
	end
    self:AskOpenDuihuanWindow(selfId)
end

function oqianzhuang_yuanbao:YBCost_GetPrize(...)
    return self:CallScriptFunction(180001, "YBCost_GetPrize", ...)
end

return oqianzhuang_yuanbao
