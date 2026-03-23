local class = require "class"
local script_base = require "script_base"
local chuan_song = class("chuan_song", script_base)

function chuan_song:on_enter_area(scene, obj)
    --遍历三个场景然后塞人
    self:CallScriptFunction((400900), "TransferFunc", obj:get_obj_id(), 0,37,134)
end

return chuan_song