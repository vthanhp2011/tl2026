local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_ouyeyu = class("osuzhou_ouyeyu", script_base)
osuzhou_ouyeyu.script_id = 001085
function osuzhou_ouyeyu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{SQSJ_0708_08}")
    self:AddNumText("神器炼魂", 6, 1)
    self:AddNumText("神器修理", 6, 2)
    self:AddNumText("关于神器炼魂", 11, 22)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_ouyeyu:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(0)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19831114)
    end
    if index == 2 then
        self:BeginUICommand()
        self:UICommand_AddInt(-1)
        self:UICommand_AddInt(-1)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 101526358)
        return
    end
    if index == 22 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SQSJ_0708_01}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 33 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SQSX_120806_46}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 44 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SQSX_120806_47}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

function osuzhou_ouyeyu:NotifysTip(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function osuzhou_ouyeyu:DoSuperDecorateWeapon(selfId, nPos, Select)
    if Select < 0 then
        return
    end
    if nPos < 0 or nPos == nil then
        return
    end
    local nItemId = self:LuaFnGetItemTableIndexByIndex(selfId, nPos)
    local DecorateID = self:GetDecoWeaponMsg(nItemId, Select)
    if DecorateID == -1 then
        self:NotifysTip(selfId, "请选择你要改变的外形幻饰。")
        return
    end
    local nMoneyJB = self:GetMoney(selfId)
    if nMoneyJB < 50000000 then
        self:NotifysTip(selfId, "金钱不足，无法进行幻饰")
        return
    end
    self:AddMoney(selfId, -50000000)
    self:LuaFnSetEquipVisual(selfId, nPos, DecorateID)
    self:NotifysTip(selfId, "外形更换成功")
end

function GetDecoWeaponMsg(ItemID, Select)
    local DecoWeaponMsg = {
        [10300100] = {946, 1398, 713, 936, 668, 646},
        [10300101] = {956, 1399, 713, 936, 667, 646},
        [10300102] = {966, 1400, 713, 936, 669, 646},
        [10300103] = {946, 1398, 713, 936, 668, 646},
        [10300104] = {956, 1399, 713, 936, 667, 646},
        [10300105] = {966, 1400, 713, 936, 669, 646},
        [10300106] = {946, 1398, 713, 936, 668, 646},
        [10300107] = {956, 1399, 713, 936, 667, 646},
        [10300108] = {966, 1400, 713, 936, 669, 646},
        [10300109] = {946, 1398, 713, 936, 668, 646},
        [10300110] = {956, 1399, 713, 936, 667, 646},
        [10300111] = {966, 1400, 713, 936, 669, 646},
        [10301100] = {942, 1401, 709, 932, 665, 646},
        [10301101] = {952, 1402, 709, 932, 664, 646},
        [10301102] = {962, 1403, 709, 932, 666, 646},
        [10301103] = {942, 1401, 709, 932, 665, 646},
        [10301104] = {952, 1402, 709, 932, 664, 646},
        [10301105] = {962, 1403, 709, 932, 666, 646},
        [10301106] = {942, 1401, 709, 932, 665, 646},
        [10301107] = {952, 1402, 709, 932, 664, 646},
        [10301108] = {962, 1403, 709, 932, 666, 646},
        [10301109] = {942, 1401, 709, 932, 665, 646},
        [10301110] = {952, 1402, 709, 932, 664, 646},
        [10301111] = {962, 1403, 709, 932, 666, 646},
        [10301200] = {944, 1395, 711, 934, 689, 646},
        [10301201] = {954, 1396, 711, 934, 688, 646},
        [10301202] = {964, 1397, 711, 934, 690, 646},
        [10301203] = {944, 1395, 711, 934, 689, 646},
        [10301204] = {954, 1396, 711, 934, 688, 646},
        [10301205] = {964, 1397, 711, 934, 690, 646},
        [10301206] = {944, 1395, 711, 934, 689, 646},
        [10301207] = {954, 1396, 711, 934, 688, 646},
        [10301208] = {964, 1397, 711, 934, 690, 646},
        [10301209] = {944, 1395, 711, 934, 689, 646},
        [10301210] = {954, 1396, 711, 934, 688, 646},
        [10301211] = {964, 1397, 711, 934, 690, 646},
        [10302100] = {947, 1404, 714, 937, 673, 647},
        [10302101] = {957, 1405, 714, 937, 674, 647},
        [10302102] = {967, 1406, 714, 937, 675, 647},
        [10302103] = {947, 1404, 714, 937, 673, 647},
        [10302104] = {957, 1405, 714, 937, 674, 647},
        [10302105] = {967, 1406, 714, 937, 675, 647},
        [10302106] = {947, 1404, 714, 937, 673, 647},
        [10302107] = {957, 1405, 714, 937, 674, 647},
        [10302108] = {967, 1406, 714, 937, 675, 647},
        [10302109] = {947, 1404, 714, 937, 673, 647},
        [10302110] = {957, 1405, 714, 937, 674, 647},
        [10302111] = {967, 1406, 714, 937, 675, 647},
        [10303100] = {929, 1407, 717, 940, 670, 647},
        [10303101] = {930, 1408, 717, 940, 671, 647},
        [10303102] = {931, 1409, 717, 940, 672, 647},
        [10303103] = {929, 1407, 717, 940, 670, 647},
        [10303104] = {930, 1408, 717, 940, 671, 647},
        [10303105] = {931, 1409, 717, 940, 672, 647},
        [10303106] = {929, 1407, 717, 940, 670, 647},
        [10303107] = {930, 1408, 717, 940, 671, 647},
        [10303108] = {931, 1409, 717, 940, 672, 647},
        [10303109] = {929, 1407, 717, 940, 670, 647},
        [10303110] = {930, 1408, 717, 940, 671, 647},
        [10303111] = {931, 1409, 717, 940, 672, 647},
        [10303200] = {943, 1410, 710, 933, 676, 647},
        [10303201] = {953, 1411, 710, 933, 677, 647},
        [10303202] = {963, 1412, 710, 933, 678, 647},
        [10303203] = {943, 1410, 710, 933, 676, 647},
        [10303204] = {953, 1411, 710, 933, 677, 647},
        [10303205] = {963, 1412, 710, 933, 678, 647},
        [10303206] = {943, 1410, 710, 933, 676, 647},
        [10303207] = {953, 1411, 710, 933, 677, 647},
        [10303208] = {963, 1412, 710, 933, 678, 647},
        [10303209] = {943, 1410, 710, 933, 676, 647},
        [10303210] = {953, 1411, 710, 933, 677, 647},
        [10303211] = {963, 1412, 710, 933, 678, 647},
        [10304100] = {945, 1419, 712, 935, 686, 649},
        [10304101] = {955, 1420, 712, 935, 685, 649},
        [10304102] = {965, 1421, 712, 935, 687, 649},
        [10304103] = {945, 1419, 712, 935, 686, 649},
        [10304104] = {955, 1420, 712, 935, 685, 649},
        [10304105] = {965, 1421, 712, 935, 687, 649},
        [10304106] = {945, 1419, 712, 935, 686, 649},
        [10304107] = {955, 1420, 712, 935, 685, 649},
        [10304108] = {965, 1421, 712, 935, 687, 649},
        [10304109] = {945, 1419, 712, 935, 686, 649},
        [10304110] = {955, 1420, 712, 935, 685, 649},
        [10304111] = {965, 1421, 712, 935, 687, 649},
        [10305100] = {949, 1413, 716, 939, 679, 648},
        [10305101] = {959, 1414, 716, 939, 680, 648},
        [10305102] = {969, 1415, 716, 939, 681, 648},
        [10305103] = {949, 1413, 716, 939, 679, 648},
        [10305104] = {959, 1414, 716, 939, 680, 648},
        [10305105] = {969, 1415, 716, 939, 681, 648},
        [10305106] = {949, 1413, 716, 939, 679, 648},
        [10305107] = {959, 1414, 716, 939, 680, 648},
        [10305108] = {969, 1415, 716, 939, 681, 648},
        [10305109] = {949, 1413, 716, 939, 679, 648},
        [10305110] = {959, 1414, 716, 939, 680, 648},
        [10305111] = {969, 1415, 716, 939, 681, 648},
        [10302200] = {951, 1422, 718, 941, 721, 647},
        [10302201] = {961, 1423, 718, 941, 720, 647},
        [10302202] = {971, 1424, 718, 941, 719, 647},
        [10302203] = {951, 1422, 718, 941, 721, 647},
        [10302204] = {961, 1423, 718, 941, 720, 647},
        [10302205] = {971, 1424, 718, 941, 719, 647},
        [10302206] = {951, 1422, 718, 941, 721, 647},
        [10302207] = {961, 1423, 718, 941, 720, 647},
        [10302208] = {971, 1424, 718, 941, 719, 647},
        [10302209] = {951, 1422, 718, 941, 721, 647},
        [10302210] = {961, 1423, 718, 941, 720, 647},
        [10302211] = {971, 1424, 718, 941, 719, 647},
        [10305200] = {948, 1416, 715, 938, 683, 648},
        [10305201] = {958, 1417, 715, 938, 682, 648},
        [10305202] = {968, 1418, 715, 938, 684, 648},
        [10305203] = {948, 1416, 715, 938, 683, 648},
        [10305204] = {958, 1417, 715, 938, 682, 648},
        [10305205] = {968, 1418, 715, 938, 684, 648},
        [10305206] = {948, 1416, 715, 938, 683, 648},
        [10305207] = {958, 1417, 715, 938, 682, 648},
        [10305208] = {968, 1418, 715, 938, 684, 648},
        [10305209] = {948, 1416, 715, 938, 683, 648},
        [10305210] = {958, 1417, 715, 938, 682, 648},
        [10305211] = {968, 1418, 715, 938, 684, 648}
    }

    if DecoWeaponMsg[ItemID] ~= nil then
        return DecoWeaponMsg[ItemID][Select]
    end
    return -1
end

function osuzhou_ouyeyu:DoSuperWeapon9Up(selfId, nPos)
    if nPos < 0 or nPos == nil then
        return
    end
    local nItemId = self:LuaFnGetItemTableIndexByIndex(selfId, nPos)
    local nMoneyJB = self:GetMoney(selfId)
    if nMoneyJB < 200000 then
        self:NotifysTip(selfId, "金钱不足，无法进行神器升级。")
        return
    end
    if nMoneyJB < 200000 then
        self:NotifysTip(selfId, "金钱不足，无法进行神器升级。")
        return
    end
    local needNum = 0
    local Qula = self:LuaFnGetItemQual(selfId, nPos)
    if Qula == 6 then
        needNum = 100
    elseif Qula == 7 then
        needNum = 200
    elseif Qula == 8 then
        needNum = 400
    end
    if needNum == 0 then
        self:NotifysTip(selfId, "请先将102神器进行炼魂操作至6星神器。")
        return
    end
    local Have = self:LuaFnGetAvailableItemCount(selfId, 30505821)
    if Have < needNum then
        self:NotifysTip(selfId, string.format("将该神器升星需要%s个%s。", needNum, self:GetItemName(30505821)))
        return
    end
    self:AddMoney(selfId, -200000)
    if self:LuaFnDelAvailableItem(selfId, 30505821, needNum) ~= 1 then
        return
    end
    self:LuaFnSetItemQual(selfId, nPos, Qula + 1)
    local transfer = self:GetBagItemTransfer(selfId, nPos)
    local str =
        string.format("#{_INFOUSR%s}#P总是用着一个神器，于是在#Y欧治于#P处通过神器进阶的功能得到了#{_INFOMSG%s}#P", self:GetName(selfId), transfer)
    self:BroadMsgByChatPipe(selfId, str, 4)
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 148, 0)
end

return osuzhou_ouyeyu
