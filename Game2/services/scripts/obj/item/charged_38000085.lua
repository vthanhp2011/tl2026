local class = require "class"
local define = require "define"
local script_base = require "script_base"
local charged_38000085 = class("charged_38000085", script_base)
charged_38000085.script_id = 892684
function charged_38000085:OnDefaultEvent(selfId)
	local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
    if nBagsPos < 4 then
        self:notify_tips(selfId,"请保证道具栏存在四个空位。")
        return
    end
    self:BeginAddItem()
    self:AddItem(38002397,300,true)
    self:AddItem(38002499,300,true)
    self:AddItem(30310113,1,true)
    local n = math.random(10125382, 10125481)
    self:AddItem(n,1,true)
    if not self:EndAddItem(selfId) then
        self:NotifyTips(selfId,"请保证道具栏存在四个空位。")
        return
    end
    self:AddItemListToHuman(selfId)
    self:notify_tips(selfId,"获得武道玄元丹300个。")
    self:notify_tips(selfId,"获得神魂檀箱300个。")
    self:notify_tips(selfId,"获得典藏珍兽蛋：飓风圣兽1个。")
    self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
    self:SetMissionDataEx(selfId,402,self:GetDayTime())
    self:LuaFnDelAvailableItem(selfId,38000085,1)
end

function charged_38000085:IsSkillLikeScript(selfId)
    return 0
end

return charged_38000085
