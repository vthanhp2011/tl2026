--local crypt     = require "skynet.crypt"
local gbk       = require "gbk"
local define    = require "define"
local iostream  = require "iostream"
local bistream  = iostream.bistream
local bostream  = iostream.bostream

local packet = {}
packet.XYID_CLCONNECT       = 355
packet.XYID_CLRETCONNECT    = 311
packet.XYID_CLASKLOGIN      = 299
packet.XYID_FGASKLOGIN      = 296
packet.XYID_LCRETLOGIN      = 223
packet.XYID_LCSTATUS        = 554
packet.XYID_CLASKCHARLIST   = 711
packet.XYID_LCRETCHARLIST   = 319
packet.XYID_CLASKCREATECHAR = 522
packet.XYID_LCRETCREATECHAR = 440
packet.XYID_CLASKCHARLOGIN  = 426
packet.XYID_LCRETCHARLOGIN  = 38
packet.XYID_CL_CHECK_ALLOW_CREATE_CHAR = 776
packet.XYID_LC_RET_CHECK_ALLOW_CREATE_CHAR = 777
packet.XYID_CL_DELETE_CHAR = 240
packet.XYID_LC_RET_DELETE_CHAR = 707

packet.CLConnect = {
    xy_id = packet.XYID_CLCONNECT,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CLConnect})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow = ""
        self.account = ""
        self.version = ""
        self.ip = ""
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.unknow     = stream:read(0x4)
        self.account    = stream:read(0x32)
        self.version    = stream:read(0x20)
        self.ip         = stream:read(0x18)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:write(self.unknow, 0x4)
        stream:write(self.account, 0x32)
        stream:write(self.version, 0x20)
        stream:write(self.ip, 0x18)
    end
}

packet.LCRetConnect = {
    xy_id = packet.XYID_CLRETCONNECT,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.LCRetConnect})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow     = 0
        self.loginport  = 0
        self.loginip    = ""
        self.port       = 0
        self.clientip   = ""
        self.unknow1    = 0
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.unknow     = stream:readint()
        self.port       = stream:readint()
        self.loginip    = stream:read(0x18)
        self.port       = stream:readint()
        self.clientip   = stream:read(0x18)
        self.unknow1    = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.unknow)
        stream:writeint(self.loginport)
        stream:write(self.loginip,  0x18)
        stream:writeint(self.port)
        stream:write(self.clientip, 0x18)
        stream:writeuint(self.unknow1)
        return stream:get()
    end
}

packet.FGAskLogin = {
    xy_id = packet.XYID_FGASKLOGIN,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.FGAskLogin})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.account = ""
        self.size    = 0
        self.unknow1 = ""
        self.unknow2 = 0
        self.unknow3 = ""
        self.unknow4 = ""
        self.cpu     = ""
        self.graph   = ""
        self.unknow7 = 0
        self.unknow8 = 0
        self.unknow9 = 0
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.account    = stream:read(0x32)
        self.size       = stream:readuint()
        self.unknow1    = stream:read(self.size)
        self.unknow2    = stream:readuint()
        self.unknow3    = stream:read(0x20)
        self.mac    = stream:read(0x10)
        self.cpu        = stream:read(0x80)
        self.graph      = stream:read(0x80)
        self.unknow7    = stream:readfloat()
        self.unknow8    = stream:readfloat()
        self.total_phys_memory = stream:readfloat()
        self.mask   = stream:readuchar()
        self.mask_data = {}
        for i = 1, 0x20 do
            local v = stream:readuchar()
            v = v - self.mask
            if v < 0 then
                v = 256 + v
            end
            self.mask_data[i] = string.char(v)
        end
        self.mask_data  = table.concat(self.mask_data, "")
        stream:readuchar()
    end
}

packet.CLAskLogin = {
    xy_id = packet.XYID_CLASKLOGIN,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CLAskLogin})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.account = ""
        self.strMd5 = ""
        self.uVersion = 0
        self.strMechineHash = ""
		self.mac 	 = ""
        self.cpu     = ""
        self.graph   = ""
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.account    = stream:read(0x32)
        self.strMd5    	= stream:read(32)
        self.uVersion   = stream:readuint()
        self.mac    = stream:read(0x10)
        self.cpu        = stream:read(0x80)
        self.graph      = stream:read(0x80)
		self.strMechineHash = stream:read(0x20)
    end
}

-- packet.CLAskLogin = {
    -- xy_id = packet.XYID_CLASKLOGIN,
    -- new = function()
        -- local o = {}
        -- setmetatable(o, {__index = packet.CLAskLogin})
        -- o:ctor()
        -- return o
    -- end,
    -- ctor = function(self)
        -- self.account = ""
        -- self.size    = 0
        -- self.unknow1 = ""
        -- self.unknow2 = 0
        -- self.unknow3 = ""
        -- self.unknow4 = ""
        -- self.cpu     = ""
        -- self.graph   = ""
        -- self.unknow7 = 0
        -- self.unknow8 = 0
        -- self.unknow9 = 0
    -- end,
    -- bis = function(self, buffer)
        -- local stream    = bistream.new()
        -- stream:attach(buffer)
        -- self.account    = stream:read(0x32)
        -- self.size       = stream:readuint()
        -- self.unknow1    = stream:read(self.size)
        -- self.unknow2    = stream:readuint()
        -- self.unknow3    = stream:read(0x20)
        -- self.mac    = stream:read(0x10)
        -- self.cpu        = stream:read(0x80)
        -- self.graph      = stream:read(0x80)
        -- self.unknow7    = stream:readfloat()
        -- self.unknow8    = stream:readfloat()
        -- self.total_phys_memory = stream:readfloat()
        -- self.mask   = stream:readuchar()
        -- self.mask_data = {}
        -- for i = 1, 0x20 do
            -- local v = stream:readuchar()
            -- v = v - self.mask
            -- if v < 0 then
                -- v = 256 + v
            -- end
            -- self.mask_data[i] = string.char(v)
        -- end
        -- self.mask_data  = table.concat(self.mask_data, "")
        -- stream:readuchar()
    -- end
-- }

packet.LCRetLogin = {
    xy_id = packet.XYID_LCRETLOGIN,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.LCRetLogin})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.uuid   = ""
        self.flag       = 0
        self.unknow_2   = ""
        self.uNeedWaitTime   = 0
        self.unknow_4   = 0
        self.unknow_5   = 0
        self.unknow_6   = 0
        self.unknow_7   = 0
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:write(self.uuid, 0x32)
        stream:writeint(self.flag)
        stream:write(self.unknow_2,  0xf)
        stream:writeint(self.uNeedWaitTime)
        if self.flag == 31 then
            stream:writeint(self.unknow_4)
        end
        stream:writechar(self.unknow_5)
        stream:writeuint(self.unknow_6)
        if self.flag == 35 then
            stream:writechar(self.unknow_7)
        end
        return stream:get()
    end
}

packet.LCStatus = {
    xy_id = packet.XYID_LCSTATUS,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.LCStatus})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow     = 0
        self.unknow_1   = 2
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeshort(self.unknow)
        stream:writeint(self.unknow_1)
        return stream:get()
    end
}

packet.CLAskCharList = {
    xy_id = packet.XYID_CLASKCHARLIST,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CLAskCharList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.account = ""
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.account    = stream:read(0x32)
    end
}

packet.LCRetCharList = {
    xy_id = packet.XYID_LCRETCHARLIST,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.LCRetCharList})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.unknow     = 0
        self.uuid       = ""
        self.charnum    = 0
        self.charlist   = {}
        self.placeholder= ""
    end,
    bis = function(self, buffer)
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.unknow)
        stream:write(self.uuid, 0x32)
        stream:writeuchar(self.charnum)
        for i = 1, self.charnum do
            local char = self.charlist[i]
            stream:writeuint(char.guid)
            stream:writeint(char.sex)
            stream:write(gbk.fromutf8(char.nickname), 0x1E)
            stream:writeshort(0)
            stream:writeint(char.level)
            stream:writeint(char.hair_color)
            stream:writeuchar(char.unknow_2)
            stream:writeuchar(char.hair)
            stream:writeshort(char.head)
            stream:writeint(char.sceneid)
            stream:writeint(char.menpai)
            stream:writeint(char.portrait_id)
            stream:writeint(0)
            stream:writeint(char.new_player_set or 0)
            for j = 1, define.HUMAN_EQUIP.HEQUIP_TOTAL do
                stream:writeint(char.equips[j])
            end
			for j = 1, define.HUMAN_EQUIP.HEQUIP_TOTAL do
                stream:writeshort(char.visuals[j])
            end
			stream:writeshort(0)
			for j = 1, define.HUMAN_EQUIP.HEQUIP_TOTAL do
                stream:writeint(char.gems[j])
            end
			for j = 1, 3 do
				stream:writeint(-1)
			end
			stream:writeint(0)		--deltime
			stream:writeint(-1)		--petdataid
			stream:writeshort(-1)	--kfsflag
			stream:writeshort(-1)	--kfswg
			stream:writeshort(0)	--kfsgrade
			
			stream:writeshort(0)	--WeaponID
			stream:writeshort(0)	--WeaponLv
			for i = 1,13 do
				stream:writeshort(0)
			end
			stream:writeint(0x62F631C4)
            --324
        end
        stream:write(self.placeholder, 0x8)
        return stream:get()
    end
}

packet.CLAskCreateChar = {
    xy_id = packet.XYID_CLASKCREATECHAR,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CLAskCreateChar})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.nickname   = ""    --0x1Eu
        self.model      = 0     --4u
        self.unknow_1   = 0     --1u
        self.unknow_2   = 0     --1u
        self.face_style   = 0     --4u
        self.unknow_4   = 0     --4u
        self.unknow_5   = 0     --1u
        self.unknow_6   = 0     --4u
        self.unknow_7   = 0     --4u
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.nickname   = stream:read(0x1E)
        self.model     = stream:readint()     --4u
        self.unknow_1   = stream:readuchar()     --1u
        self.unknow_2   = stream:readuchar()     --1u
        self.hair_style   = stream:readint()     --4u
        self.face_style   = stream:readint()     --4u
        self.portrait_id   = stream:readuchar()     --1u
        self.new_player_set   = stream:readint()     --4u
        self.unknow_7   = stream:readint()     --4u
    end
}

packet.LCRetCreateChar = {
    xy_id = packet.XYID_LCRETCREATECHAR,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.LCRetCreateChar})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.result = 0
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.result)
        return stream:get()
    end
}

packet.CLAskCharLogin = {
    xy_id = packet.XYID_CLASKCHARLOGIN,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CLAskCharLogin})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.guid = 0
        self.PlayerID = 0
        --self.unknow_2 = 0
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.guid       = stream:readuint()
        self.PlayerID   = stream:readushort()
        --self.unknow_2   = stream:readushort()
    end
}

packet.LCRetCharLogin = {
    xy_id = packet.XYID_LCRETCHARLOGIN,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.LCRetCharLogin})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.result   = 0
        self.port     = 0
        self.ip       = ""
        self.key      = 0
        self.unknow_5 = 0 --1u
        self.unknow_6 = 0
        self.unknow_7 = 0 --2u
        self.unknow_8 = 0
        self.unknow_9 = 0
        self.unknow_10= 0
        self.unknow_11= 0
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeuint(self.result)
        stream:writeuint(self.port)
        stream:write(self.ip, 0x18)
        stream:writeuint(self.key)
        stream:writeuchar(self.unknow_5)
        stream:writeuint(self.unknow_6)
        stream:writeushort(self.unknow_7)
        stream:writeuint(self.unknow_8)
        stream:writeuint(self.unknow_9)
        stream:writeuint(self.unknow_10)
        if self.result == 14 then
            stream:writeuint(self.unknow_11)
        end
        return stream:get()
    end
}

packet.CLCheckAllowCreateChar = {
    xy_id = packet.XYID_CL_CHECK_ALLOW_CREATE_CHAR,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CLCheckAllowCreateChar})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
    end
}

packet.LCRetCheckAllowCreateChar = {
    xy_id = packet.XYID_LC_RET_CHECK_ALLOW_CREATE_CHAR,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.LCRetCheckAllowCreateChar})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.flag = 1
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.flag)
        return stream:get()
    end
}

packet.CLAskDeleteChar = {
    xy_id = packet.XYID_CL_DELETE_CHAR,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.CLAskDeleteChar})
        o:ctor()
        return o
    end,
    ctor = function(self)
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.guid = stream:readint()
    end
}

packet.LCRetDeleteChar = {
    xy_id = packet.XYID_LC_RET_DELETE_CHAR,
    new = function()
        local o = {}
        setmetatable(o, {__index = packet.LCRetDeleteChar})
        o:ctor()
        return o
    end,
    ctor = function(self)
        self.flag = 1
    end,
    bis = function(self, buffer)
        local stream    = bistream.new()
        stream:attach(buffer)
        self.flag = stream:readint()
    end,
    bos = function(self)
        local stream = bostream.new()
        stream:writeint(self.flag)
        return stream:get()
    end
}

return packet
