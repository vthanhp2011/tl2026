local class = require "class"
local utils = require "utils"
local gbk = require "gbk"
local skynet = require "skynet"
local define = require "define"
local script_base = require "script_base"
local bet = class("bet", script_base)

function bet:OnBet(selfId, main,action,score,append)
    local guid = self:LuaFnGetGUID(selfId)
    local area = utils.get_node_name()
    skynet.send(".mqttor", "lua", "client_request", area, guid, main, action, score, append)
end

return bet