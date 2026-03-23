local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_chongwumao = class("odali_chongwumao", script_base)
function odali_chongwumao:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local roll = math.random(0, 2)
    if roll <= 0 then
        self:AddText("  云霏霏姐姐是我们所有珍兽的偶像！霏霏霏霏我爱你，就像老鼠爱大米！")
    elseif roll <= 1 then
        self:AddText("  别以为我不会说话，霏霏姐姐早就教过我们说话了。不信，我们比试比试！")
    else
        self:AddText("  你知道吗？听说霏霏姐姐有两个妹妹，和霏霏姐姐长得一模一样哦。")
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_chongwumao
