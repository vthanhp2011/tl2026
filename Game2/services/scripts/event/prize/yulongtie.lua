--御龙帖
--普通
local gbk = require "gbk"
local ScriptGlobal = require "scripts.ScriptGlobal"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local yulongtie = class("yulongtie", script_base)

function yulongtie:OnClickOpenBtn(selfId, targetId)
    self:BeginUICommand()
        local enddate = self:GetMissionData(selfId, ScriptGlobal.MD_YU_LONG_TIE_END_TIME)
        enddate = tostring(enddate)
        self:UICommand_AddInt(tonumber(string.sub(enddate, 1, 2)) + 2000)
        self:UICommand_AddInt(tonumber(string.sub(enddate, 3, 4)))
        self:UICommand_AddInt(tonumber(string.sub(enddate, 5, 6)))
    self:EndUICommand()
    self:DispatchUICommand(selfId, 89266604)
end

function yulongtie:DoFunc(selfId, index)
    print("yulongtie:DoFunc =", selfId, index)
    if not self:CheckMonthCardVaildate(selfId) then
        self:notify_tips(selfId, "#{HJYK_201223_11}")
        return
    end
    if index == 1 then
        self:on_click_double_exp(selfId)
    elseif index == 2 then
        self:open_chongwu_shop(selfId)
    elseif index == 3 then
        self:open_bank(selfId)
    elseif index == 9 then
        self:open_pet_bank(selfId)
    elseif index == 4 then
        self:open_fix_equip(selfId)
    elseif index == 5 then
        self:open_add_fix_equip_count(selfId)
    elseif index == 6 then
        self:open_fix_wuhun(selfId)
    elseif index == 7 then
        self:open_fix_shenqi(selfId)
    end
end

function yulongtie:UNLockTime(selfId)
    self:DESetLock(selfId, false)
	self:notify_tips(selfId, "你冻结的双倍经验时间已经解冻了。")
    self:SendDoubleExpToClient(selfId)
end

function yulongtie:LockTime(selfId)
    self:DESetLock(selfId, true)
	self:notify_tips(selfId, "你的双倍时间已冻结")
    self:SendDoubleExpToClient(selfId)
end

function yulongtie:on_click_double_exp(selfId)
    local nCurHave = self:DEGetFreeTime(selfId)
    nCurHave = nCurHave + self:DEGetMoneyTime(selfId)
    if nCurHave == 0 then
        self:notify_tips(selfId, "#{HJYK_201223_20}")
    else
        if self:DEIsLock(selfId) then
            self:BeginUICommand()
                self:UICommand_AddInt(892666)
                self:UICommand_AddInt(-1)
                self:UICommand_AddInt(50)
                self:UICommand_AddStr("UNLockTime")
                local str = string.format("你当前有%d分钟可以解冻，你确定要解冻吗？", math.floor(nCurHave / 60))
                self:UICommand_AddStr(str)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 24)
        else
            self:BeginUICommand()
                self:UICommand_AddInt(892666)
                self:UICommand_AddInt(-1)
                self:UICommand_AddInt(50)
                self:UICommand_AddStr("LockTime")
                local str = string.format("你当前有%d分钟的双倍时间，你确定要冻结吗？", math.floor(nCurHave / 60))
                self:UICommand_AddStr(str)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 24)
        end
    end
end

function yulongtie:open_chongwu_shop(selfId)
    local targetId = define.INVAILD_ID
    self:DispatchShopItem(selfId, targetId, 27)
end

function yulongtie:open_bank(selfId)
    local targetId = define.INVAILD_ID
    self:BankBegin(selfId, targetId)
end

function yulongtie:open_pet_bank(selfId)
    local targetId = define.INVAILD_ID
    self:PetBankBegin(selfId, targetId)
end

function yulongtie:open_fix_equip(selfId)
    self:BeginUICommand()
        self:UICommand_AddInt(-1)
        self:UICommand_AddInt(-1)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 19810313)
end

function yulongtie:open_add_fix_equip_count(selfId)
    self:BeginUICommand()
        self:UICommand_AddInt(-1)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1004)
end

function yulongtie:open_fix_wuhun(selfId)
    self:BeginUICommand()
        self:UICommand_AddInt(-1)
        self:UICommand_AddInt(3)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 20090721)
end

function yulongtie:open_fix_shenqi(selfId)
    self:BeginUICommand()
        self:UICommand_AddInt(-1)
        self:UICommand_AddInt(-1)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 101526358)
end

function yulongtie:OnUseMonthCard(selfId)
    local item_count = self:LuaFnGetAvailableItemCount(selfId, 38000205)
    if item_count < 1 then
        self:notify_tips(selfId, "背包里没发现御龙帖道具")
        return
    end
    local BagPos = self:LuaFnGetItemPosByItemDataID(selfId, 38000205)
    local itemTransfer = self:GetBagItemTransfer(selfId, BagPos)
    self:LuaFnDelAvailableItem(selfId, 38000205, 1)
    self:AddBindYuanBao(selfId, 688)
    local end_date = self:GetDiffTime2Day2(30 * 24 * 60 * 60)
    self:SetMissionData(selfId, ScriptGlobal.MD_YU_LONG_TIE_END_TIME, end_date)
    local sMessage = self:ContactArgsNotTransfer("#{HJYK_201223_09", gbk.fromutf8(self:GetName(selfId)), itemTransfer)
    self:AddGlobalCountNews(sMessage .. "}", true)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 89266602)
end

function yulongtie:OnScenePlayerEnter(selfId)
    local UICOMMAND = 0
    if self:CheckMonthCardVaildate(selfId) then
        UICOMMAND = 89266602
    else
        UICOMMAND = 89266603
    end
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, UICOMMAND)
end

function yulongtie:CheckMonthCardVaildate(selfId)
    local enddate = self:GetMissionData(selfId, ScriptGlobal.MD_YU_LONG_TIE_END_TIME)
    local nowdate = self:GetTime2Day2()
    return enddate >= nowdate
end

return yulongtie