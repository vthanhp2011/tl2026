local gbk = require "gbk"
local class = require "class"
local define = require "define"
local configenginer = require "configenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local human_item_logic = require "human_item_logic"
local GMCommand = class("GMCommand")
local commands = {
    ["帮助"] = "help",
    ["获取道具"] = "get_item",
    ["获取YB"] = "get_yuanbao",
    ["获取金币"] = "get_money",
    ["获取经验"] = "get_exp",
    ["清空背包"] = "clear_bag",
    ["获取状态"] = "get_impact",
    ["回血"] = "recover",
    ["创建陷阱"] = "create_trap",
    ["创建怪物"] = "create_monster",
}

function GMCommand:process(human, content)
    content = gbk.toutf8(content)
    print("GMCommand:process", content)
    local arg1, arg2, arg3 = string.match(content, "([^%@]+)@")
    print("GMCommand:process", arg1, arg2, arg3)
    local f = commands[arg1]
    if f then
        f = self[f]
        f(self, human, content)
    end
end

function GMCommand:get_item_id(human, tbl, item_name)
    local level = human:get_level()
    local item_ids = {}
    for id, item in pairs(tbl) do
        if item.name == item_name and (item.level or 1) <= level then
            table.insert(item_ids, id)
        end
    end
    return item_ids[#item_ids]
end

function GMCommand:help(human, content)

end

function GMCommand:get_item(human, content)
    local arg1, arg2, arg3 = string.match(content, "([^%@]+)@([^%@]+)@([^%@]+)")
    local item_name = arg2
    local item_id = tonumber(arg2)
    local count = tonumber(arg3)
    local common_item = configenginer:get_config("common_item")
    local equip_base = configenginer:get_config("equip_base")
    local gem_info = configenginer:get_config("gem_info")
    local pet_equip_base = configenginer:get_config("pet_equip_base")
    if item_id == nil then
        item_id = self:get_item_id(human, common_item, item_name)
    end
    if item_id == nil then
        item_id = self:get_item_id(human, equip_base, item_name)
    end
    if item_id == nil then
        item_id = self:get_item_id(human, gem_info, item_name)
    end
    if item_id == nil then
        item_id = self:get_item_id(human, pet_equip_base, item_name)
    end
    if item_id then
        local shoptype = 0
        local quality = 1
        local is_bind = false
        local logparam = { reason = "私聊GM工具发放", user_name = human:get_name(), user_guid = human:get_guid() }
        local _, bag_index = human_item_logic:create_multi_item_to_bag(logparam, human, item_id, count, is_bind, shoptype, quality)
        if bag_index == define.INVAILD_ID then
            human:notify_tips("道具发放失败, 检查背包空间")
        end
    else
        human:notify_tips("道具不存在")
    end
end

function GMCommand:get_yuanbao(human, content)
    local arg1, arg2 = string.match(content, "([^%@]+)@([^%@]+)")
    local yuanbao = human:get_yuanbao()
    yuanbao = yuanbao + tonumber(arg2)
    human:set_yuanbao(yuanbao)
end

function GMCommand:get_money(human, content)
    local arg1, arg2 = string.match(content, "([^%@]+)@([^%@]+)")
    local money = human:get_money()
    money = money + tonumber(arg2)
    human:set_money(money, "GM命令添加金币")
end

function GMCommand:get_exp(human, content)
    local arg1, arg2, arg3 = string.match(content, "([^%@]+)@([^%@]+)@([^%@]+)")
    arg2 = tonumber(arg2) or 0
    arg3 = tonumber(arg3) or 0
    human:add_exp(arg2, arg3)
end

function GMCommand:clear_bag(human)
    local container = human:get_prop_bag_container()
    for i = 0, 200 - 1 do
        local item = container:get_item(i)
        if item then
            local logparam = {}
            human_item_logic:erase_item_by_bag_index(logparam, human, i)
        end
    end
end

function GMCommand:get_impact(human, content)
    local arg1, arg2, arg3 = string.match(content, "([^%@]+)@([^%@]+)@([^%@]+)")
    arg2 = tonumber(arg2) or 0
    local data_index = arg2
    impactenginer:send_impact_to_unit(human, data_index, human, 500, false, 0)
end

function GMCommand:recover(human, content)
    local max_hp = human:get_max_hp()
    human:set_hp(max_hp)
end

function GMCommand:create_trap(human, content)
    local arg1, arg2, arg3 = string.match(content, "([^%@]+)@([^%@]+)@([^%@]+)")
    arg2 = tonumber(arg2) or 0
    local data_index = arg2
    local world_pos = human:get_world_pos()
    local special_obj = human:skill_create_obj_specail(world_pos, data_index)
    special_obj:set_continuance(100000)
end

function GMCommand:create_monster(human, content)
    local arg1, arg2, arg3 = string.match(content, "([^%@]+)@([^%@]+)@([^%@]+)")
    arg2 = tonumber(arg2) or 0
    arg3 = tonumber(arg3) or 1
    local monster_id = arg2
    local count = arg3
    count = count > 100 and 100 or count
    local world_pos = human:get_world_pos()
    for i = 1, count do
        local monsterid = human:get_scene():create_temp_monster(monster_id, world_pos.x, world_pos.y, 4, define.INVAILD_ID, define.INVAILD_ID)
        local monster = human:get_scene():get_obj_by_id(monsterid)
        monster:set_die_time(1 * 60 * 1000)
    end
end

return GMCommand