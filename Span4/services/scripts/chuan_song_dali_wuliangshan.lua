local class = require "class"
local script_base = require "script_base"
local chuan_song_dali_wuliangshan = class("chuan_song_dali_wuliangshan", script_base)

function chuan_song_dali_wuliangshan:on_enter_area(scene, obj)
     self:CallScriptFunction((400900), "TransferFunc", obj:get_obj_id(), 6, 38, 175,1)
end

return chuan_song_dali_wuliangshan