local class = require "class"
local script_base = require "script_base"
local chuan_song = class("chuan_song", script_base)

function chuan_song:on_enter_area(scene, obj)
     local nSceneInfo = {2,1302}
     local IsOpen = 0
     for i = 1,#nSceneInfo do
         if self:LuaFnGetDestSceneHumanCount(nSceneInfo[i]) < 300 then
             IsOpen = i
             break
         end
     end
     if IsOpen ~= 0 then
         self:CallScriptFunction((400900), "TransferFunc",  obj:get_obj_id(), nSceneInfo[IsOpen], 280, 152) --根据人数分配玩家所进入的场景。
         return
     else
         self:notify_tips(obj:get_obj_id(),"当前大理场景人数上限，请暂时前往其他地图。")
         return
     end
     --self:CallScriptFunction((400900), "TransferFunc", obj:get_obj_id(),2,280,152,1)
end

return chuan_song

