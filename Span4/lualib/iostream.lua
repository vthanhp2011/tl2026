local class = require "class"
local iostream = class("iostream")

function iostream:ctor()
    self.buffer = ""
    self.pos = 1
end

function iostream:attach(buffer)
    self.buffer = buffer
    self.pos = 1
end

function iostream:skip(i)
    self.pos = self.pos + i
end

function iostream:get()
    return self.buffer, self.pos - 1
end

local bistream = class("bistream", iostream)
function bistream:read(len)
    local start = self.pos
    local endd = self.pos + len - 1
    local s = string.sub(self.buffer, start, endd)
    self.pos = self.pos + len
    return s
end

function bistream:readushort()
    local start = self.pos
    local s = string.sub(self.buffer, start)
    local n = string.unpack("H", s)
    self.pos = self.pos + 2
    return n
end

function bistream:readshort()
    local start = self.pos
    local s = string.sub(self.buffer, start)
    local n = string.unpack("h", s)
    self.pos = self.pos + 2
    return n
end

function bistream:readuint()
    local start = self.pos
    local s = string.sub(self.buffer, start)
    local n = string.unpack("I4", s)
    self.pos = self.pos + 4
    return n
end

function bistream:readint()
    local start = self.pos
    local s = string.sub(self.buffer, start, start + 4)
    local n = string.unpack("i4", s)
    self.pos = self.pos + 4
    return n
end

function bistream:readulong()
    local start = self.pos
    local s = string.sub(self.buffer, start)
    local n = string.unpack("L", s)
    self.pos = self.pos + 8
    return n
end

function bistream:readuint8()
    local start = self.pos
    local s = string.sub(self.buffer, start)
    local n = string.unpack("I8", s)
    self.pos = self.pos + 8
    return n
end

function bistream:readuchar()
    local start = self.pos
    local s = string.sub(self.buffer, start, start + 1)
    local n = string.unpack("B", s)
    self.pos = self.pos + 1
    return n
end

function bistream:readbool()
    local n = self:readuchar()
    return n == 1
end

function bistream:readchar()
    local start = self.pos
    local s = string.sub(self.buffer, start)
    local n = string.unpack("b", s)
    self.pos = self.pos + 1
    return n
end

function bistream:readfloat()
    local start = self.pos
    local s = string.sub(self.buffer, start)
    local n = string.unpack("f", s)
    self.pos = self.pos + 4
    return n
end

local bostream = class("bostream", iostream)
function bostream:write(data, len)
    local fmt = string.format("c%d", len)
    local buffer = string.pack(fmt, data)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + len
    return self
end

-- function bostream:writechar(c)
    -- local buffer = string.pack("b", c)
    -- self.buffer = self.buffer .. buffer
    -- self.pos = self.pos + 1
    -- return self
-- end

function bostream:writeuchar(c)
    local buffer = string.pack("B", c)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + 1
    return self
end

-- function bostream:writebool(c)
    -- c = c and 1 or 0
    -- return self:writeuchar(c)
-- end

function bostream:writechar(c)
    local buffer = string.pack("b", c)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + 1
    return self
end

function bostream:writebool(c)
    c = c and 1 or 0
    return self:writechar(c)
end

function bostream:writeshort(s)
    local buffer = string.pack("h", s)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + 2
    return self
end

-- function bostream:writeint(n)
    -- local buffer = string.pack("i4", n)
    -- self.buffer = self.buffer .. buffer
    -- self.pos = self.pos + 4
    -- return self
-- end

function bostream:writeuint(n)
    local buffer = string.pack("I4", n)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + 4
    return self
end

function bostream:writeint(n)
    local buffer = string.pack("i4", n)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + 4
    return self
end

function bostream:writeulong(n)
    local buffer = string.pack("L", n)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + 8
    return self
end

function bostream:writeff(n)
    -- local t = {}
    for i = 1, n do
        self:writeuchar(255)
    end
    return self
end

function bostream:writeushort(s)
    local buffer = string.pack("H", s)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + 2
    return self
end

function bostream:writefloat(f)
    local buffer = string.pack("f", f)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + 4
    return self
end

function bostream:writehex(h)
    local buffer = string.pack("h", h)
    self.buffer = self.buffer .. buffer
    self.pos = self.pos + string.len(buffer)
    return self
end

iostream.bistream = bistream
iostream.bostream = bostream
return iostream