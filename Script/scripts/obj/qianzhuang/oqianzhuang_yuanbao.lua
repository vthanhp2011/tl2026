local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqianzhuang_yuanbao = class("oqianzhuang_yuanbao", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
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
	local nYuanBao =self:GetMissionData(selfId,388)
    local tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
    self:BeginEvent(self.script_id)
    local strText = "    有钱能使鬼推磨，虽然江湖当中以武力为上，但是有了元宝可能会使原来很多比较难办的事情变得简单起来，您想做些什么呢？"
    self:AddText(strText)
	self:AddNumText("#G十元千金豪情礼", 2, 102)
    self:AddNumText("#{CZHL_200916_04}", 2, 101)
    --self:AddNumText("#G畅玩武圣卡激活", 2, 301)
    --self:AddNumText("#G畅玩武圣卡购买", 2, 302)
    self:AddNumText("我想购买商品", 2, 200)
    self:AddNumText("将点数兑换成元宝", 2, self.g_buyact)
	if nYuanBao >= 1500000 then 
    self:AddNumText("将元宝兑换成元宝票", 2, self.g_ticketact)
	end
    self:AddNumText("关于一掷千金豪情礼", 2, 201)
    self:AddNumText("关于神秘商人", 2, 202)
    self:AddNumText("元宝介绍", 2, 203)
    self:AddNumText("首充享豪礼", 2, 204)
    self:AddNumText("关于绑定元宝", 2, 205)
    self:AddNumText("关于点数兑换元宝", 2, 206)
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
	local nYuanBao =self:GetMissionData(selfId,388)
    if index == self.g_buyact then
        if self:GetMenPai(selfId) == 9 then
            self:notify_tips(selfId,"仅可在加入门派后，方可兑换元宝。")
            return
        end
        local rate = self:CallScriptFunction(define.PRIZE_SCRIPT_ID, "GetYuanBaoRate", selfId)
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(rate)
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
		if nYuanBao < 1500000 then 
			return
		end
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
        self:CallScriptFunction(180001,"OpenTopChongZhi",selfId,targetId,101)
    elseif index == 102 then
        self:CallScriptFunction(180001,"OpenTopChongZhi",selfId,targetId,102)
    elseif index == 301 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:UICommand_AddInt(1)
		self:EndUICommand()
		self:DispatchUICommand(selfId,20100118)
		return
    elseif index == 302 then
		local cururl = "https://vip.ku918.com/details/F687BAA3"
        self:BeginUICommand()
        self:UICommand_AddStr(cururl)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2023120201)
        return
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
	--self:notify_tips(selfId,"充值临时维护预计13:00恢复")
		local ServerID = self:LuaFnGetServerID(selfId)
		local chongzhi_url = {
		[10] = {"http://vip.sanqnet.com:80/ch/a.html?sid=29951"},
		[11] = {"http://vip.sanqnet.com:80/ch/a.html?sid=82574"},
		[12] = {"http://www.l9377.com//liebiao/E5CE3B77B3F76A4C"},
		[13] = {"http://www.l9377.com//liebiao/E5CE3B77B3F76A4C"},
		[14] = {"http://www.l9377.com//liebiao/E5CE3B77B3F76A4C"},
		[15] = {"http://www.l9377.com//liebiao/E5CE3B77B3F76A4C"},
		[16] = {"http://www.l9377.com//liebiao/E5CE3B77B3F76A4C"},
		[17] = {"http://www.l9377.com//liebiao/E5CE3B77B3F76A4C"},
		}
		if #chongzhi_url[ServerID] < 1 then
            self:notify_tips(selfId,"尚未开放充值。")
            return
        end
		local selectidx = math.random(1,#chongzhi_url[ServerID])
		local cururl = chongzhi_url[ServerID][selectidx]
		if ScriptGlobal.is_internal_test then
			--self:notify_tips(selfId,"尚未开放充值。")
            return
		end
        self:BeginUICommand()
        self:UICommand_AddStr(cururl)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2023120201)
        return
    end
    if index == 3 then
	--攻略

		--[[local ServerID = self:LuaFnGetServerID(selfId)
		local chongzhi_url = {
		
		}
		if #chongzhi_url[ServerID] < 1 then--]]
		local cururl = "http://183.131.196.159:18520/cqgonglue.html"
        self:BeginUICommand()
        self:UICommand_AddStr(cururl)
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
        if sceneId ~= 151 and sceneId ~= 0 and sceneId ~= 1 and sceneId ~= 71 and sceneId ~= 2 and sceneId ~= 1300 and sceneId ~= 1301 and sceneId ~= 1302 and sceneId ~= 1311 and sceneId ~= 1312 and sceneId ~= 1316 then
            self:notify_tips(selfId,"仅处于洛阳、苏州、大理时，方可兑换元宝。")
            return
        end
        local rate = self:CallScriptFunction(define.PRIZE_SCRIPT_ID, "GetYuanBaoRate", selfId)
        self:BeginUICommand()
        self:UICommand_AddInt(define.INVAILD_ID)
        self:UICommand_AddInt(rate)
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
