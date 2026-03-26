local skynet = require "skynet"

skynet.start(function()
    skynet.error("=== LCIPHER_HOLDER STARTED ===")
    -- Cipher initialization handled in bootstrap if needed
    skynet.register(".lcipher_holder")
end)