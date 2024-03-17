-- Remaps and custom settings files
-- No plugins necessary
require("setup.remaps")
require("setup.settings")

-- Plugin files
-- This config heavily relies on kickstart
-- Kickstart is great if you wanna get started
-- writing your own config
-- https://github.com/nvim-lua/kickstart.nvim
require("plugins.lazy")
