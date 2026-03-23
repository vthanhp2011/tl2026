local class = require "class"
local define = require "define"
local script_base = require "script_base"
local onanhai_yuezhongqiu = class("onanhai_yuezhongqiu", script_base)
onanhai_yuezhongqiu.script_id = 34003
function onanhai_yuezhongqiu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  以前的时候，鳄鱼帮也挺好的，只是行为乖张一些罢了，没做过什麽大的坏事。可是，渐渐的，不知道怎麽回事，那些孩子开始总是惹祸，做错了事情还不认错，唉……真是造孽啊……")
    if self:IsHaveMission(selfId, 568) then
        local itemCount = self:GetItemCount(selfId, 40001039)
        if itemCount < 1 then
            self:AddNumText("得到一块异种树皮", 7, 666)
        end
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function onanhai_yuezhongqiu:OnEventRequest(selfId, targetId, arg, index)
    if index == 666 then
        local itemCount = self:GetItemCount(selfId, 40001039)
        if itemCount < 1 then
            self:BeginAddItem()
            self:AddItem(40001039, 1)
            local ret = self:EndAddItem(selfId)
            if ret <= 0 then
                self:Msg2Player(selfId, "#Y你的任务背包已经满了。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
            else
                self:AddItemListToHuman(selfId)
            end
        end
    end
end

return onanhai_yuezhongqiu
