local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_zhongwanchou = class("odali_zhongwanchou", script_base)
function odali_zhongwanchou:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我夫人骂得好。段正淳这恶徒自逞风流，多造冤孽，到头来自己的亲生儿女相恋成奸，当真是卑鄙无耻之极了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_zhongwanchou
