local skynet = require "skynet"
local packet_def = require "game.packet"
local class = require "class"
local utils = require "utils"
local define = require "define"
local configenginer = require "configenginer":getinstance()
local scriptenginer = class("scriptenginer")
scriptenginer.not_raw_call_function = {
    ["OnDefaultEvent"] = true,
    ["OnEventRequest"] = true,
    ["OnActivateOnce"] = true,
    ["OnActivateEachTick"] = true,
    ["OnDie"] = true,
    ["OnLeaveCombat"] = true
}
function scriptenginer:getinstance()
    if scriptenginer.instance == nil then
        scriptenginer.instance = scriptenginer.new()
    end
    return scriptenginer.instance
end

function scriptenginer:ctor() self.scripts = {} end

function scriptenginer:set_scene(scene) self.scene = scene end

function scriptenginer:get_scene() return self.scene end

function scriptenginer:reload_scripts()
    print("scriptenginer:reload_scripts =")
    for _, path in pairs(self.dat or {}) do
        package.loaded[path] = nil
        print("reload_scripts =", path)
    end
    package.loaded["scripts.scripts"] = nil
    package.loaded["scripts.script_access"] = nil
    package.loaded["scripts.ScriptGlobal"] = nil
    self.scripts = {}
    self.dat = nil
    local r, script_access = pcall(require, "scripts.script_access")
    if r then
        self.script_access = script_access
    end
end

function scriptenginer:item_is_skill_like_script(human, script)
    return self:call(script, "IsSkillLikeScript", human:get_obj_id()) == 1
end

function scriptenginer:item_call_default_event(human, script, bag_index)
    return self:call(script, "OnDefaultEvent", human:get_obj_id(), bag_index)
end

function scriptenginer:script_cancle_impacts(human, script)
    return self:call(script, "CancelImpacts", human:get_obj_id()) == 1
end

function scriptenginer:have_function(id, func)
    local s = self.scripts[id]
    s = s and s or self:try_load(id)
    if s then
        local f = s[func]
        return f ~= nil
    end
end

function scriptenginer:try_load(id)
    local dat = self.dat or require "scripts.scripts" --configenginer:get_config("scripts")
    self.dat = dat
    local path = dat[id]
    if path then
        local f = require(path)
        if type(f) == "table" then
            local script = f.new()
            script:set_scene(self.scene)
            script.script_id = id
            self.scripts[id] = script
            return script
        end
    end
end

function scriptenginer:call(id, func, ...)
    local s = self.scripts[id]
    s = s and s or self:try_load(id)
    if s then
        local f = s[func]
        if f then
            local result = {xpcall(f, debug.traceback, s, ...)}
            local r = result[1]
            if r then
                table.remove(result, 1)
                return table.unpack(result)
            else
                skynet.logw("scriptenginer:call error =" .. result[2])
            end
        else
            -- print("not support func id =", id,  "f =", func)
        end
    else
        -- print("unsupport script id =", id)
    end
end

function scriptenginer:raw_call(id, func, ...)
    local s = self.scripts[id]
    s = s and s or self:try_load(id)
    if s then
        if s.is_super_function(func) or self.not_raw_call_function[func] then
            skynet.loge(string.format("raw_call fail %s is super function", tostring(func)))
        else
            if self:check_function_is_allow(id, func) then
                self:log_raw_call_function(id, func, ...)
                return self:call(id, func, ...)
            else
                skynet.loge(string.format("raw_call fail id = %d and func = %s is not allow function ", id, tostring(func)))
            end
        end
    else
        -- print("unsupport script id =", id)
    end
end

function scriptenginer:check_function_is_allow(id, func)
    if self.script_access == nil then
        return true
    end
    local script = self.script_access[id]
    if script == nil then
        return true
    end
    return script[func] == true
end

function scriptenginer:log_raw_call_function(id, func, ...)
    local collection = "log_raw_call_function"
    local args = { ... }
    local data = table.tostr(args)
    local guid = define.INVAILD_ID
    local name = ""
    local human = self:get_scene():get_obj_by_id(args[1])
    if human then
        guid = human:get_guid()
        name = human:get_name()
    end
    local doc = { id = id, func = func, args = data, date_time = utils.get_day_time(), unix_time = os.time(), guid = guid, name = name}
    skynet.send(".logdb", "lua", "insert", { collection = collection, doc = doc})
end

function scriptenginer:dispatch(who, cmdid, event)
    local ret = packet_def.GCScriptCommand.new()
    ret.m_nCmdID = cmdid
    ret.event = event
    ret.unknow_1 = 0
    if type(event) == "table" then ret.size = #ret.event end
    self.scene:send2client(who, ret)
end

return scriptenginer
