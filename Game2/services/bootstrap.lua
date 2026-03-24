local skynet = require "skynet"

skynet.start(function()
    -- Khởi tạo launcher ĐẦU TIÊN (bắt buộc)
    skynet.newservice("launcher")

    -- Sau đó mới khởi tạo main service của game
    skynet.newservice("main")          -- hoặc "gamed" tùy source của bạn

    -- Nếu bạn muốn mở debug console (tùy chọn)
    skynet.newservice("debug_console", 8000)

    skynet.error("=== Server bootstrap done ===")
end)