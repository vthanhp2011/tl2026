local skynet = require "skynet"
local class = require "class"
local define = require "define"
local packet_def = require "game.packet"
local eventenginer = class("eventenginer")

function eventenginer:getinstance()
    if eventenginer.instance == nil then
        eventenginer.instance = eventenginer.new()
    end
    return eventenginer.instance
end

function eventenginer:ctor()
    self.events = {}
    self.last = 0
end

function eventenginer:set_scene(scene)
    self.scene = scene
end

function eventenginer:get_scene()
    return self.scene
end

function eventenginer:active()
    self.last = skynet.now()
    self.events = {}
end

function eventenginer:real_register_active_special_obj_event(obj_id, sender, delay_time, skill_id)
    local obj = self:get_scene():get_obj_by_id(obj_id)
    assert(obj, obj_id)
    obj:set_active_flag(true)
    -- obj:set_skill_id(skill_id or define.INVAILD_ID)
end

function eventenginer:register_active_special_obj_event(obj_id, sender, delay_time, skill_id)
    skynet.fork(function()
        local r, err = pcall(self.real_register_active_special_obj_event, self, obj_id, sender, delay_time, skill_id)
        if not r then
            skynet.loge("eventenginer:register_active_special_obj_event =", err)
        end
    end)
end

function eventenginer:real_register_be_skill_event(reciver, sender, skill_id, behaviortype)
    reciver:on_be_skill(sender, skill_id, behaviortype)
end

function eventenginer:register_be_skill_event(reciver, sender, skill_id, behaviortype)
    skynet.fork(function()
        local r, err = pcall(self.real_register_be_skill_event, self, reciver, sender, skill_id, behaviortype)
        if not r then
            skynet.loge("eventenginer:register_be_skill_event =", err)
        end
    end)
end

function eventenginer:real_register_skill_miss_event(sender, reciver, skill_id)
    reciver:on_skill_miss(sender, skill_id)
    sender:on_skill_miss_target(reciver, skill_id)
    local ret = packet_def.GCCharSkill_Missed.new()
    ret.reciver = reciver:get_obj_id()
    ret.sender = sender:get_obj_id()
    ret.skill_id = skill_id
    ret.flag = define.MissFlag_T.FLAG_MISS
    ret.sender_logic_count = sender:get_logic_count()
    local scene = self:get_scene()
    scene:broadcast(reciver, ret, true)
end

function eventenginer:register_skill_miss_event(sender, reciver, skill_id)
    skynet.fork(function()
        local r, err = pcall(self.real_register_skill_miss_event, self, sender, reciver, skill_id)
        if not r then
            skynet.loge("eventenginer:register_skill_miss_event =", err)
        end
    end)
end

function eventenginer:real_register_skill_hit_event(sender, reciver, skill)
    reciver:on_be_hit(sender, skill)
    sender:on_hit_target(reciver, skill)
end

function eventenginer:register_skill_hit_event(sender, reciver, skill)
    skynet.fork(function()
        local r, err = pcall(self.real_register_skill_hit_event, self, sender, reciver, skill)
        if not r then
            skynet.loge("eventenginer:register_skill_hit_event =", err)
        end
    end)
end

function eventenginer:real_register_impact_event(reciver, sender, imp, delaytime, skill_id)
	local impid = imp:get_data_index()
	if not impid or impid < 0 then
		-- skynet.logi("skill_id = ", skill_id, "stack =", debug.traceback())
		return
	end
    local scene = self:get_scene()
    local impactenginer = scene:get_impact_enginer()
    local imp_logic = impactenginer:get_logic(imp)
	if not imp_logic then
		-- skynet.logi("imp = ", imp, "stack =", debug.traceback())
		return
	end
    local caster_obj_id = sender and sender:get_obj_id() or define.INVAILD_ID
    local caster_unique_id = sender and sender:get_guid() or define.INVAILD_ID
    local caster_logic_count = sender and sender:get_logic_count() or define.INVAILD_ID
    imp:set_caster_obj_id(caster_obj_id)
    imp:set_caster_unique_id(caster_unique_id)
	local logic_id = imp:get_logic_id()
    if imp:is_critical_hit() then
        imp_logic:critical_refix(imp,reciver)
    end
    if not imp:get_skill_id() then
        imp:set_skill_id(skill_id or define.INVAILD_ID)
    end
	if logic_id == 14 then
		local continuance_base = imp:get_continuance()
		if continuance_base ~= -1 then
			local add_continuance,sub_continuance
			local effect_value,feature_rate,update_flag
			for i,j in pairs(define.IMPACT_FEATURE_LPC) do
				add_continuance,sub_continuance = 0,0
				if impactenginer:is_impact_in_collection(imp,i) then
					update_flag = false
					if sender then
						effect_value,feature_rate = sender:get_dw_jinjie_effect_details(j[1])
						if effect_value > 0 then
							effect_value = effect_value / feature_rate
							add_continuance = continuance_base * effect_value / 100
							-- sender:features_effect_notify_client(j[1])
							update_flag = true
						end
					end
					effect_value,feature_rate = reciver:get_dw_jinjie_effect_details(j[2])
					if effect_value > 0 then
						effect_value = effect_value / feature_rate
						sub_continuance = continuance_base * effect_value / 100
						-- sender:features_effect_notify_client(j[2])
						update_flag = true
					end
					if update_flag then
						continuance_base = math.ceil(continuance_base + add_continuance - sub_continuance)
						continuance_base = continuance_base < 0 and 0 or continuance_base
						imp:set_continuance(continuance_base)
					end
					break
				end
			end
		end
	elseif logic_id == 35 then
		local shiming = define.IMPACT_FEATURE_LPC[42]
		if shiming then
			local continuance_base = imp:get_continuance()
			if continuance_base ~= -1 then
				if impactenginer:is_impact_in_collection(imp,42) then
					local add_continuance,sub_continuance = 0,0
					local effect_value,feature_rate,update_flag
					if sender then
						effect_value,feature_rate = sender:get_dw_jinjie_effect_details(shiming[1])
						if effect_value > 0 then
							effect_value = effect_value / feature_rate
							add_continuance = continuance_base * effect_value / 100
							-- sender:features_effect_notify_client(shiming[1])
							update_flag = true
						end
					end
					effect_value,feature_rate = reciver:get_dw_jinjie_effect_details(shiming[2])
					if effect_value > 0 then
						effect_value = effect_value / feature_rate
						sub_continuance = continuance_base * effect_value / 100
						-- sender:features_effect_notify_client(shiming[2])
						update_flag = true
					end
					if update_flag then
						continuance_base = math.ceil(continuance_base + add_continuance - sub_continuance)
						continuance_base = continuance_base < 0 and 0 or continuance_base
						imp:set_continuance(continuance_base)
					end
				end
			end
		end
	end
    if sender and sender:get_obj_type() == "human" then
        imp:mark_create_by_player_flag()
    end
    imp:set_caster_logic_count(caster_logic_count)
    if sender then
        local r, err = pcall(sender.refix_impact, sender, imp, reciver)
        if not r then
            skynet.loge("refix_impact err =", err)
        end
    end
	if imp:get_is_out() then
		return
	end
    if (reciver:is_unbreakable() and imp:get_stand_flag() == define.ENUM_BEHAVIOR_TYPE.BEHAVIOR_TYPE_HOSTILITY) then
        local msg = packet_def.GCCharSkill_Missed.new()
        msg.reciver = reciver:get_obj_id()
        msg.sender = imp:get_caster_obj_id()
        msg.flag = define.MissFlag_T.FLAG_IMMU
        msg.skill_id = imp:get_skill_id()
        msg.sender_logic_count = imp:get_caster_logic_count()
        scene:broadcast(reciver, msg, true)
    else
        local ret = reciver:on_filtrate_impact(imp)
        if ret == define.MISS_FLAG.FLAG_NORMAL then
            if skill_id and define.TELE_PORT_SKILLS[skill_id] then
                skynet.timeout(30, function()
                    reciver:register_impact(imp)
                end)
            else
                reciver:register_impact(imp)
            end
        else
            local msg = packet_def.GCCharSkill_Missed.new()
            msg.reciver = reciver:get_obj_id()
            msg.sender = imp:get_caster_obj_id()
            msg.flag = ret
            msg.skill_id = imp:get_skill_id()
            msg.sender_logic_count = imp:get_caster_logic_count()
            scene:broadcast(reciver, msg, true)
        end
    end
end

function eventenginer:register_impact_event(reciver, sender, imp, delaytime, skill_id)
    skynet.fork(function()
        local r, err = pcall(self.real_register_impact_event, self, reciver, sender, imp, delaytime, skill_id)
        if not r then
            skynet.loge("eventenginer:register_impact_event =", err)
        end
    end)
end

return eventenginer
