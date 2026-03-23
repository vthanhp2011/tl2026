local class = require "class"
local script_base = require "script_base"
local chuan_song_dali_jiange = class("chuan_song_dali_jiange", script_base)

function chuan_song_dali_jiange:on_enter_area(scene, obj)
     self:CallScriptFunction((400900), "TransferFunc", obj:get_obj_id(), 7, 40, 278,1)
end

return chuan_song_dali_jiange