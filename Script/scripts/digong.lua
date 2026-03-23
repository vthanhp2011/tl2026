local class = require "class"
local gbk = require "gbk"
local define = require "define"
local script_base = require "script_base"
local digong = class("digong", script_base)

function digong:OnSceneTimer()
    if self:IsClose() then
        local remove_count = 0
        local count = self:LuaFnGetCopyScene_HumanCount()
        for i = 1, count do
            if remove_count < 50 then
                local selfId = self:LuaFnGetCopyScene_HumanObjId(i)
                if self:LuaFnIsObjValid(selfId) then
                    remove_count = remove_count + 1
                    self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 99, 174,10)
                end
            end
        end
    end
end

function digong:IsClose()
	local curHour = self:GetHour()
	if curHour >= 2 and curHour < 21 then
		return true
	end
	return false
    -- local weekday = self:GetTodayWeek()
    -- return true--not (weekday == 4 or weekday == 5)
end

return digong