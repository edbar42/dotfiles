return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "sindrets/diffview.nvim",
    "m00qek/baleia.nvim",
    "ibhagwan/fzf-lua",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
  opts = {
    kind = "floating",
  },
}
