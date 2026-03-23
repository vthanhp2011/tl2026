local class = require "class"
local script_base = require "script_base"
local chuan_song_yannan_luoyang = class("chuan_song_yannan_luoyang", script_base)

function chuan_song_yannan_luoyang:on_enter_area(scene, obj)
     self:CallScriptFunction((400900), "TransferFunc", obj:get_obj_id(), 0, 282, 132)
end

return chuan_song_yannan_luoyang