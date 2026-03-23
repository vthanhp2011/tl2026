local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshaolin_xuanzheng = class("oshaolin_xuanzheng", script_base)
oshaolin_xuanzheng.script_id = 009035
function oshaolin_xuanzheng:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("不知道是什么原因，木人巷中的木人一时无法控制，现在跑的寺中都是，看施主慈眉善目，给你个锻炼的机会，你可愿往？")
    self:AddNumText("打木人锻炼", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshaolin_xuanzheng:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 41 then
            self:BeginEvent(self.script_id)
            local strText = "本寺的木人虽然好打，但施主等级不到41，恐怕力所不逮，依老僧看还是过段再来吧。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 139, 95, 141)
        end
    end
end

return oshaolin_xuanzheng
