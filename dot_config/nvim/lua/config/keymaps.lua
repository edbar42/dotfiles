-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local del = vim.keymap.del
local set = vim.keymap.set

-- Use J and K to drag lines on visual mode
del({ "n", "i", "v" }, "<A-j>")
del({ "n", "i", "v" }, "<A-k>")
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Drag line down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Drag line up" })

-- U to redo
vim.keymap.set("n", "U", "<C-R>", { desc = "Redo last action" })

-- Extend Ctrl-a/Ctrl-x to toggle booleans
local bool_toggles = { ["true"] = "false", ["false"] = "true", ["True"] = "False", ["False"] = "True" }
vim.keymap.set("n", "<C-a>", function()
  local word = vim.fn.expand("<cword>")
  if bool_toggles[word] then
    vim.cmd("normal! ciw" .. bool_toggles[word])
  else
    vim.cmd("normal! \x01")
  end
end, { desc = "Increment number or toggle boolean" })
vim.keymap.set("n", "<C-x>", function()
  local word = vim.fn.expand("<cword>")
  if bool_toggles[word] then
    vim.cmd("normal! ciw" .. bool_toggles[word])
  else
    vim.cmd("normal! \x18")
  end
end, { desc = "Decrement number or toggle boolean" })
