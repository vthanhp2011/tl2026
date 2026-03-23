local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odigong_chuandisi = class("odigong_chuandisi", script_base)
odigong_chuandisi.script_id = 044605
function odigong_chuandisi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "    在下受此地县丞之托，来此探查情况。虽有发现，然在下力有不逮，需少侠出手相助。#r    昨日在下进入地宫四层一探，发现多处古老祭台，执念深重，似是某种灵阵的阵眼。若放入唤灵之物唤灵符箓，必能引出异象之源。届时你寻机将其祓除，此阵自破！")
    self:AddNumText("前往本服地宫四", 9, 1)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odigong_chuandisi:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        if self:GetLevel(selfId) < 50 then
            self:NotifyTips(selfId,targetId,"   少侠，等级不足50级，我劝您还是不要轻易涉险的好。")
            return
        end
        --self:NotifyTips(selfId,targetId, "地宫四层暂不开放")
        --return
		--本服
		if not self:CallDestSceneFunction(1303, 3000003, "IsClose") then
			self:CallScriptFunction((400900), "TransferFunc", selfId, 1303, 34, 37,50)
        --self:CallScriptFunction((400900), "TransferFunc", selfId, 1299, 34, 37,50)
		else
			self:NotifyTips(selfId,targetId, "地宫四层关闭中")
		end
    end
end

function odigong_chuandisi:NotifyTips(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odigong_chuandisi:NotifyFailBox(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return odigong_chuandisi
