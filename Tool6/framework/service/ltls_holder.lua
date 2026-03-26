local skynet = require "skynet"

skynet.start(function()
    skynet.error("=== LTLS_HOLDER STARTED ===")
    -- LTLS initialization handled in bootstrap if needed
    skynet.register(".ltls_holder")
end)
