local skynet = require "skynet"
require "skynet.manager"
local server_conf = require "server_conf"
local define = require "define"
local class = require "class"
local copyscenemanager_core = class("copyscenemanager_core")

function copyscenemanager_core:getinstance()
    if copyscenemanager_core.instance == nil then
        copyscenemanager_core.instance = copyscenemanager_core.new()
    end
    return copyscenemanager_core.instance
end

function copyscenemanager_core:ctor()
    self.load = {}
    self.selectd = {}
    self.sleeping = {}
    self.delta_time = 10
    self.cursor = 0
    self.sn = 0
end

function copyscenemanager_core:init(conf)
    self.world_id = conf.world_id
    for i = 1, server_conf.MAX_COPY_SCENE do
        local handle = skynet.newservice("copyscene")
        skynet.call(handle, "lua", "register", i + define.COPY_SCENE_BEGIN)
        skynet.call(handle, "lua", "init")
        self.load[i] = handle
        self.sleeping[handle] = i
    end
    skynet.timeout(self.delta_time, function()
        self:safe_message_update()
    end)
end

function copyscenemanager_core:reload_scripts()
    -- print("scriptenginer:reload_scripts")
    for _, scene in ipairs(self.load) do
        -- print("scriptenginer:reload_scripts scene =", scene)
        local r, err = pcall(skynet.call, scene, "lua", "reload_scripts")
        if not r then
            print("reload_scripts error =", err)
        end
    end
end

function copyscenemanager_core:safe_message_update()
    local r, err = xpcall(self.message_update, debug.traceback, self, self.delta_time * 10)
    if not r then
        skynet.logw("copyscenemanager_core:safe_message_update error =", err)
    end
    skynet.timeout(self.delta_time, function() self:safe_message_update() end)
end

function copyscenemanager_core:message_update()
    for i = 1, 10 do
        self.cursor = self.cursor + 1
        if self.cursor > #self.load then
            self.cursor = 1
        end
        local handle = self.load[self.cursor]
        if handle then
            if self.sleeping[handle] == nil and skynet.call(handle, "lua", "get_status") == define.SCENE_STATUS.SCENE_STATUS_SLEEP then
                self.sleeping[handle] = self.cursor
                skynet.logi("mark handle =", string.format(":%08x", handle), "sleeping")
            end
        end
    end
end

function copyscenemanager_core:select(conf)
    assert(type(conf) == "table")
    assert(conf.sn)
    assert(conf.source)
    assert(conf.params[1])
    local handle = next(self.sleeping)
    if handle == nil then
        return define.INVAILD_ID
    end
    local id = self.sleeping[handle]
    self.sleeping[handle] = nil
    -- skynet.logi("mark handle =", string.format(":%08x", handle), "running")
    conf.world_id = self.world_id
    skynet.send(handle, "lua", "load", conf)
    return id + define.COPY_SCENE_BEGIN
end

function copyscenemanager_core:find_copy_scene_id_by_copy_scene_params(copy_scene_type, index, arg)
    for i = 1, server_conf.MAX_COPY_SCENE do
        local handle = self.load[i] or define.INVAILD_ID
        if handle ~= define.INVAILD_ID then
            if skynet.call(handle, "lua", "get_status") == define.SCENE_STATUS.SCENE_STATUS_RUNNING then
                local params = skynet.call(handle, "lua", "get_params")
                if params[0] == copy_scene_type and params[index] == arg then
                    return handle
                end
            end
        end
    end
    return define.INVAILD_ID
end

function copyscenemanager_core:world_timer_update(timer)
    for i = 1, server_conf.MAX_COPY_SCENE do
        local handle = self.load[i]
        if skynet.call(handle, "lua", "get_status") == define.SCENE_STATUS.SCENE_STATUS_RUNNING then
            skynet.send(handle, "lua", "world_timer_update", timer)
        end
    end
end

function copyscenemanager_core:gen_sn()
    self.sn = self.sn + 1
    return self.sn
end


return copyscenemanager_core