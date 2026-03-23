local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odunhuang_songbing = class("odunhuang_songbing", script_base)
function odunhuang_songbing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local nRet = math.random(5)
    if nRet <= 1 then
        self:AddText("  三年前，玉门关一战，我们败给了西夏军，丢掉了玉门关。到如今我们已经打了大大小小十几仗，还是没有能够光复玉门关。")
    elseif nRet <= 2 then
        self:AddText("  前几天，杨司令从西京国子监请来了一个人，据说是玉门关太守曹延惠的弟弟，叫做曹延寿。最近杨司令每天都在和他商量秘密军情。")
    elseif nRet <= 3 then
        self:AddText("  我听中军官说，不久之前，他在#G三危山#W察看地形时，看到了一位好似天上神仙一般的女子。嗯，好象是在#G[220，100]#W附近。")
    elseif nRet <= 4 then
        self:AddText("  我听中军官说，不久之前，他在#G折柳峡#W遇到西夏兵，慌不择路，躲进了一个神秘的山洞才得以脱身。嗯，好象是在#G[149，42]#W附近。")
    else
        self:AddText("  沿着#G折柳峡#W一直走，就能到达#G玉门关#W了，嗯，就在#G[66，91]#W附近。你要小心点，西夏兵是很凶残的，他们杀人都不眨眼啊。")
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odunhuang_songbing
