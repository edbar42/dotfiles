-- Remaps and custom settings files
-- No lazy plugins necessary
require("setup.remaps")
require("setup.settings")

-- Plugin files
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy, and load my `lua/plugins/` folder
require("lazy").setup({ import = "plugins" }, {
	change_detection = {
		notify = false,
	},
})
