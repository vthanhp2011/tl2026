local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_chongwugui = class("odali_chongwugui", script_base)
function odali_chongwugui:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local roll = math.random(0, 2)
    if roll <= 0 then
        self:AddText("  云渺渺姐姐是我们所有珍兽的偶像！渺渺渺渺我爱你，就像老鼠爱大米！")
    elseif roll <= 1 then
        self:AddText("  别以为我不会说话，渺渺姐姐早就教过我们说话了。不信，我们比试比试！")
    else
        self:AddText("  你知道吗？听说渺渺姐姐有两个姐姐，和渺渺姐姐长得一模一样哦。")
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_chongwugui
