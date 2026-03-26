local skynet = require "skynet"

skynet.start(function()
    skynet.error("=== LTLS_HOLDER STARTED (dummy - SSL enabled) ===")
    -- Nếu bạn có module C ltls thật, thay bằng code thực tế sau
    skynet.register(".ltls_holder")
end)
