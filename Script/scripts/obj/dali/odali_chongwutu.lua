local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_chongwutu = class("odali_chongwutu", script_base)
function odali_chongwutu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local roll = math.random(0, 2)
    if roll <= 0 then
        self:AddText("  云飘飘姐姐是我们所有珍兽的偶像！飘飘飘飘我爱你，就像老鼠爱大米！")
    elseif roll <= 1 then
        self:AddText("  别以为我不会说话，飘飘姐姐早就教过我们说话了。不信，我们比试比试！")
    else
        self:AddText("  你知道吗？听说飘飘姐姐有一个姐姐和一个妹妹，和飘飘姐姐长得一模一样哦。")
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_chongwutu
