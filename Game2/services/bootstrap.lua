local skynet = require "skynet"

skynet.start(function()
    skynet.newservice("launcher")     -- ← BẮT BUỘC phải có dòng này trước
    skynet.newservice("main")         -- khởi động game main.lua của bạn
    -- skynet.newservice("debug_console")  -- nếu muốn debug sau này
end)