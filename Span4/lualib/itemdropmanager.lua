local define = require "define"
local class = require "class"
local itemdropmanager = class("itemdropmanager")

function itemdropmanager:getinstance()
    if itemdropmanager.instance == nil then
        itemdropmanager.instance = itemdropmanager.new()
    end
    return itemdropmanager.instance
end

function itemdropmanager:set_scene(scene) self.scene = scene end

function itemdropmanager:get_scene()
    return self.scene
end

function itemdropmanager:ctor() end

function itemdropmanager:caculate_drop_item_box(monster_id)
    local monster_drop_boxs = self:get_scene():get_config_enginer():get_config("monster_drop_boxs")
    local drop_box_content = self:get_scene():get_config_enginer():get_config("drop_box_content")
    print("caculate_drop_item_box monster_id =", monster_id)
    local monster_drops = monster_drop_boxs[monster_id]
    local items = {}
    if monster_drops then
        local monster_value = monster_drops.value
        local monster_boxs = {}
        for _, id in ipairs(monster_drops.drops) do
            if id ~= define.INVAILD_ID then
                table.insert(monster_boxs, drop_box_content[id])
            end
        end
        for _, b in ipairs(monster_boxs) do
            local bvalue = b.value
            local force_bind = b.force_bind == 1
            local current_rate = math.random()
            print("bvalue =", bvalue, ";monster_value =", monster_value)
            local base_drop_rate = monster_value / bvalue
            print("base_drop_rate =", base_drop_rate, ";current_rate =", current_rate)
            if current_rate <= base_drop_rate then
                local broad_type = b.broad_type
                local bitems = {}
                for _, bi in ipairs(b.items) do
                    if bi.id ~= define.INVAILD_ID then
                        table.insert(bitems, bi)
                    end
                end
                if #bitems > 0 then
                    local i = math.random(#bitems)
                    local item = bitems[i]
                    if item then
                        table.insert(items, { id = item.id, drop_class = broad_type, count = 1, force_bind = force_bind})
                    else
                        print("item not find ", bitems[i])
                    end
                end
            end
        end
    end
    return items
end

return itemdropmanager